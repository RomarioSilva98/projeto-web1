import 'package:flutter/material.dart';
import 'package:projetoweb1/models/banda.dart';
import 'package:projetoweb1/services/banda_service.dart';
import 'package:projetoweb1/services/usuario_service.dart';
import 'package:projetoweb1/views/criar_banda_page.dart';
import 'package:projetoweb1/views/detalhes_banda_page.dart';
import 'package:projetoweb1/views/editar_usuario_page.dart';
import 'package:projetoweb1/views/login_page.dart';
import 'gerenciar_banda_page.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class HomePage extends StatefulWidget {
  final int usuarioId;

  const HomePage({Key? key, required this.usuarioId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Banda>> _bandasFuture;
  late Future<String> _nomeUsuarioFuture;
  final BandaService _bandaService = BandaService();
  final UsuarioService _usuarioService = UsuarioService();
  StompClient? stompClient;

  @override
  void initState() {
    super.initState();
    _bandasFuture = _bandaService.buscarBandasDoUsuario(widget.usuarioId);
    _nomeUsuarioFuture = _usuarioService.buscarNomeUsuario(widget.usuarioId);
    _conectarWebSocket();
  }

  void _conectarWebSocket() {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url:
            'http://localhost:8080/ws', 
        onConnect: (StompFrame frame) {
          stompClient!.subscribe(
            destination: '/topic/bandas',
            callback: (StompFrame frame) {
              _atualizarBandas();
            },
          );
        },
        onWebSocketError: (dynamic error) => print('Erro WebSocket: $error'),
      ),
    );

    stompClient!.activate();
  }

  void _atualizarBandas() {
    setState(() {
      _bandasFuture = _bandaService.buscarBandasDoUsuario(widget.usuarioId);
    });
  }

  void _notificarAtualizacao() {
    stompClient?.send(
      destination: '/app/atualizar-bandas',
      body: "Atualizar bandas",
    );
  }

  @override
  void dispose() {
    stompClient?.deactivate();
    super.dispose();
  }

  void _excluirConta() async {
    bool sucesso = await _usuarioService.excluirConta(widget.usuarioId);
    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Conta excluída com sucesso!")),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Erro ao excluir conta. Tente novamente.")),
      );
    }
  }

  void _confirmarExclusaoConta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text(
              "Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                _excluirConta();
              },
              child: const Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _nomeUsuarioFuture,
          builder: (context, snapshot) {
            String titulo = "Bem-vindo";
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              titulo = "Bem-vindo, ${_corrigirAcentos(snapshot.data!)}";
            }
            return Center(
              child: Text(
                titulo,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: FutureBuilder<String>(
                future: _nomeUsuarioFuture,
                builder: (context, snapshot) {
                  String nome = "Usuário";
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    nome = _corrigirAcentos(snapshot.data!);
                  }
                  return Text(
                    nome,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Editar Perfil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditarUsuarioPage(usuarioId: widget.usuarioId),
                  ),
                );
              },
            ),
            FutureBuilder<List<Banda>>(
              future: _bandasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  bool isResponsavel = snapshot.data!.any((banda) =>
                      banda.responsavel?.idUsuario == widget.usuarioId);
                  if (isResponsavel) {
                    return ListTile(
                      leading: const Icon(Icons.music_note),
                      title: const Text("Gerenciar Bandas"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GerenciarBandaPage(usuarioId: widget.usuarioId),
                          ),
                        ).then((_) => _atualizarBandas());
                      },
                    );
                  }
                }
                return Container(); 
              },
            ),
            ListTile(
              leading: const Icon(Icons.person,
                  color: Color.fromARGB(
                      255, 10, 10, 10)), // Ícone de perfil para conta
              title: const Text("Excluir Conta",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              trailing: const Icon(Icons.delete,
                  color: Colors.red), 
              onTap: () => _confirmarExclusaoConta(),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Sair"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Banda>>(
        future: _bandasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Erro ao carregar bandas",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final bandas = snapshot.data ?? [];

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Minhas Bandas",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: bandas.isEmpty
                    ? const Center(
                        child: Text(
                          "Você não possui bandas.",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: bandas.length,
                        itemBuilder: (context, index) {
                          final banda = bandas[index];
                          return Card(
                            color: Colors.blueGrey[900],
                            child: ListTile(
                              title: Text(
                                banda.nomeBanda ?? '',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              subtitle: Text(
                                banda.genero ?? 'Gênero desconhecido',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward,
                                    color: Colors.white),
                                onPressed: () {
                                  if (banda.idBanda != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetalhesBandaPage(
                                          banda: banda,
                                          usuarioId: widget.usuarioId,
                                        ),
                                      ),
                                    ).then((_) => _atualizarBandas());
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "Criar Banda",
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CriarBandaPage(usuarioId: widget.usuarioId),
                      ),
                    ).then((_) {
                      _notificarAtualizacao(); // Notifica os outros usuários sobre a atualização
                      _atualizarBandas(); // Atualiza a lista na tela
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _corrigirAcentos(String texto) {
    return String.fromCharCodes(texto.runes);
  }
}
