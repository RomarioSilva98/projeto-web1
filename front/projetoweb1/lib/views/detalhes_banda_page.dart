import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projetoweb1/models/banda.dart';
import 'package:projetoweb1/services/banda_service.dart';
import 'detalhes_repertorio_page.dart';
import 'criar_repertorio_page.dart';
import 'adicionar_musico_page.dart';
import 'criar_musica_page.dart';
import 'home_page.dart';
import 'gerenciar_repertorio_page.dart';
import 'package:projetoweb1/views/login_page.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class DetalhesBandaPage extends StatefulWidget {
  final Banda banda;
  final int usuarioId;

  const DetalhesBandaPage(
      {Key? key, required this.banda, required this.usuarioId})
      : super(key: key);

  @override
  _DetalhesBandaPageState createState() => _DetalhesBandaPageState();
}

class _DetalhesBandaPageState extends State<DetalhesBandaPage> {
  final BandaService _bandaService = BandaService();
  StompClient? _stompClient;

  @override
  void initState() {
    super.initState();
    _conectarWebSocket();
  }

  void _conectarWebSocket() {
    _stompClient = StompClient(
      config: StompConfig(
        url:
            'ws://localhost:8080/ws/websocket', 
        onConnect: (StompFrame frame) {
          print("Conectado ao WebSocket!");

          // Assina o tópico global para receber qualquer atualização da banda
          _stompClient?.subscribe(
            destination: '/topic/bandas',
            callback: (StompFrame frame) {
              print("Banda atualizada: ${frame.body}");
              print("Dados recebidos no WebSocket: ${frame.body}");
              _buscarDetalhesBanda(); // Atualiza tudo
            },
          );
        },
        onWebSocketError: (dynamic error) => print("Erro WebSocket: $error"),
      ),
    );

    _stompClient?.activate();
  }

  @override
  void dispose() {
    _stompClient?.deactivate();
    super.dispose();
  }

  void _buscarDetalhesBanda() async {
    if (widget.banda.idBanda != null) {
      Banda? bandaAtualizada =
          await _bandaService.buscarBandaPorId(widget.banda.idBanda!);
      if (bandaAtualizada != null) {
        setState(() {
          widget.banda.usuarios = bandaAtualizada.usuarios;
          widget.banda.repertorios = bandaAtualizada.repertorios;
        });
      }
    }
  }

  void _removerMusico(int bandaId, int musicoId, String nomeMusico) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Remover Músico"),
          content: Text("Tem certeza que deseja remover $nomeMusico da banda?"),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Remover", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop(); 

                bool sucesso =
                    await _bandaService.removerMusico(bandaId, musicoId);
                if (sucesso) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Músico removido com sucesso!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  _stompClient?.send(
                    destination: '/app/atualizar-bandas',
                    body: jsonEncode({'mensagem': 'Músico removido'}),
                  );
                  _buscarDetalhesBanda();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Erro ao remover músico."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _voltarParaHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(usuarioId: widget.usuarioId!)),
    );
  }

  void _abrirMenu(String opcao) {
    switch (opcao) {
      case 'adicionar_musico':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdicionarMusicoPage(
              bandaId: widget.banda.idBanda!,
              banda: widget.banda,
              usuarioLogadoId: widget.usuarioId,
            ),
          ),
        ).then((resultado) {
          print("Resultado do Navigator.pop: $resultado"); 
          if (resultado == true) {
            _stompClient?.send(
              destination: '/app/atualizar-bandas',
              body: jsonEncode({'mensagem': 'Musico Adicionado'}),
            );
            _buscarDetalhesBanda();
          }
        });
        break;
      case 'criar_musica':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CriarMusicaPage(
              usuarioId: widget.usuarioId,
              bandaId: widget.banda.idBanda!,
            ),
          ),
        );
        break;

      case 'criar_repertorio':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CriarRepertorioPage(idBanda: widget.banda.idBanda!)),
        ).then((resultado) {
          print("Resultado do Navigator.pop: $resultado"); 
          if (resultado == true) {
            _stompClient?.send(
              destination: '/app/atualizar-bandas',
              body: jsonEncode({'mensagem': 'Repertório criado'}),
            );
            _buscarDetalhesBanda();
          }
        });
        break;
      case 'gerenciar_repertorio':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GerenciarRepertorioPage(idBanda: widget.banda.idBanda!)),
        ).then((resultado) {
          print("Resultado do Navigator.pop: $resultado"); 
          if (resultado == true) {
            _stompClient?.send(
              destination: '/app/atualizar-bandas',
              body: jsonEncode({'mensagem': 'Repertório atualizado'}),
            );
            _buscarDetalhesBanda();
          }
        });
        break;

      case 'voltar_home':
        _voltarParaHome();
        break;
      case 'sair':
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isResponsavel =
        widget.banda.responsavel?.idUsuario == widget.usuarioId;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Banda"),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Text(widget.banda.nomeBanda ?? "Sem nome",
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
            ),
            

            if (isResponsavel) ...[
             
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text("Adicionar Músico"),
                onTap: () => _abrirMenu('adicionar_musico'),
              ),
              ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text("Criar Música"),
                onTap: () => _abrirMenu('criar_musica'),
              ),
              ListTile(
                leading: const Icon(Icons.library_music),
                title: const Text("Criar Repertório"),
                onTap: () => _abrirMenu('criar_repertorio'),
              ),
              ListTile(
                leading:
                    const Icon(Icons.edit, color: Color.fromARGB(255, 0, 0, 0)),
                title: const Text("Gerenciar Repertorios"),
                onTap: () => _abrirMenu('gerenciar_repertorio'),
              ),
              const Divider(),
            ],
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Voltar para Home"),
                onTap: () => _abrirMenu('voltar_home'),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Sair"),
              onTap: () => _abrirMenu('sair'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                widget.banda.nomeBanda ?? "Sem nome",
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white70, thickness: 0.5),
            const Text("Integrantes:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 5),
            widget.banda.usuarios != null && widget.banda.usuarios!.isNotEmpty
                ? Column(
                    children: widget.banda.usuarios!.map((usuario) {
                      return ListTile(
                        title: Text(usuario.nomeUsuario ?? "Sem nome",
                            style: const TextStyle(color: Colors.white)),
                        leading: const Icon(Icons.person, color: Colors.white),
                        trailing: isResponsavel
                            ? IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () => _removerMusico(
                                    widget.banda.idBanda!,
                                    usuario.idUsuario!,
                                    usuario.nomeUsuario!),
                              )
                            : null,
                      );
                    }).toList(),
                  )
                : const Text("Nenhum integrante cadastrado.",
                    style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 10),
            const Divider(color: Colors.white70, thickness: 0.5),
            const Text("Repertório:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 5),
            widget.banda.repertorios != null &&
                    widget.banda.repertorios!.isNotEmpty
                ? Column(
                    children: widget.banda.repertorios!.map((repertorio) {
                      return ListTile(
                        title: Text(repertorio.nome ?? "Sem título",
                            style: const TextStyle(color: Colors.white)),
                        leading:
                            const Icon(Icons.music_note, color: Colors.white),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesRepertorioPage(
                                  repertorio: repertorio,
                                  idBanda: widget.banda.idBanda!,
                                  responsavelId:
                                      widget.banda.responsavel?.idUsuario ?? 0,
                                  usuarioId: widget.usuarioId,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  )
                : const Text("Nenhum repertório cadastrado.",
                    style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
