import 'package:flutter/material.dart';
import 'package:projetoweb1/models/repertorio.dart';
import 'package:projetoweb1/models/repertorio_musica.dart';
import 'package:projetoweb1/services/repertorio_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'adicionar_musica_repertorio_page.dart';
import '../models/banda.dart';
import 'show_page.dart';
import 'detalhes_banda_page.dart';
import 'login_page.dart';
import 'pdf_view_page.dart';
import 'dart:convert';
import 'package:projetoweb1/services/banda_service.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DetalhesRepertorioPage extends StatefulWidget {
  final Repertorio repertorio;
  final int idBanda;
  final int usuarioId;
  final int responsavelId;

  const DetalhesRepertorioPage({
    Key? key,
    required this.repertorio,
    required this.idBanda,
    required this.usuarioId,
    required this.responsavelId,
  }) : super(key: key);

  @override
  _DetalhesRepertorioPageState createState() => _DetalhesRepertorioPageState();
}

class _DetalhesRepertorioPageState extends State<DetalhesRepertorioPage> {
  final RepertorioService _repertorioService = RepertorioService();
  List<RepertorioMusicas> musicas = [];
  bool isLoading = true;
  StompClient? _stompClient;
  String? _pdfUrl; // Armazena a URL do PDF selecionado

  bool get isResponsavel => widget.usuarioId == widget.responsavelId;

  @override
  void initState() {
    super.initState();
    _conectarWebSocket();
    _carregarMusicas();
  }

 void _conectarWebSocket() {
  _stompClient = StompClient(
    config: StompConfig(
      url: 'ws://localhost:8080/ws/websocket',
      onConnect: (StompFrame frame) {
        _stompClient?.subscribe(
          destination: '/topic/repertorio-atualizar/${widget.repertorio.idRepertorio}',
          callback: (StompFrame frame) {
            if (frame.body != null) {
              _carregarMusicas();
            }
          },
        );
      },
    ),
  );
  _stompClient?.activate();
}

  @override
  void dispose() {
    _stompClient?.deactivate();
    super.dispose();
  }

  Future<void> _carregarMusicas() async {
    setState(() {
      isLoading = true;
      musicas.clear();
    });
    List<RepertorioMusicas> listaMusicas = await _repertorioService.listarMusicasDoRepertorio(widget.repertorio.idRepertorio ?? 0);
    setState(() {
      musicas = List.from(listaMusicas);
      musicas.sort((a, b) => int.parse(a.ordem ?? '0').compareTo(int.parse(b.ordem ?? '0')));
      isLoading = false;
    });
  }

void _enviarNotificacao() {
  _stompClient?.send(
    destination: '/app/atualizar-repertorio/${widget.repertorio.idRepertorio}',
  body: jsonEncode({'idRepertorio': widget.repertorio.idRepertorio}),
  );
}

  void _moverMusica(int index, int direcao) async {
    final novoIndex = index + direcao;
    if (novoIndex < 0 || novoIndex >= musicas.length) return;

    final temp = musicas[index];
    musicas[index] = musicas[novoIndex];
    musicas[novoIndex] = temp;

    for (int i = 0; i < musicas.length; i++) {
      musicas[i] = RepertorioMusicas(
        idMusica: musicas[i].idMusica,
        tituloMusica: musicas[i].tituloMusica,
        arquivoPdf: musicas[i].arquivoPdf,
        ordem: (i + 1).toString(),
      );
    }

    await _repertorioService.atualizarOrdemMusicas(widget.repertorio.idRepertorio ?? 0, musicas.map((m) => {"idMusica": m.idMusica, "ordem": m.ordem}).toList());
    _enviarNotificacao();
    _carregarMusicas();
  }

  void _removerMusica(int index) async {
    bool sucesso = await _repertorioService.removerMusicaDoRepertorio(
      widget.repertorio.idRepertorio ?? 0,
      musicas[index].idMusica ?? 0,
    );

    if (sucesso) {
      setState(() {
        musicas.removeAt(index);
        for (int i = 0; i < musicas.length; i++) {
          musicas[i] = RepertorioMusicas(
            idMusica: musicas[i].idMusica,
            tituloMusica: musicas[i].tituloMusica,
            arquivoPdf: musicas[i].arquivoPdf,
            ordem: (i + 1).toString(),
          );
        }
        musicas.sort((a, b) => int.parse(a.ordem ?? '0').compareTo(int.parse(b.ordem ?? '0')));
      });

      _enviarNotificacao();
    }
  }

void _abrirPdf(String? url) {
  if (url != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(pdfUrl: url),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.repertorio.nome ?? "Detalhes do Repertório"),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            if (isResponsavel)
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Adicionar Música ao Repertório"),
                onTap: () async {
                  bool sucesso = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdicionarMusicaPage(
                        idRepertorio: widget.repertorio.idRepertorio ?? 0,
                        idBanda: widget.idBanda,
                      ),
                    ),
                  );

                  if (sucesso == true) {
                    _carregarMusicas();
                    _enviarNotificacao();
                  }
                },
              ),
            ListTile(
              leading: const Icon(Icons.play_circle_filled, color: Colors.green),
              title: const Text("Iniciar Show"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModoShowPage(
                      musicas: musicas,
                      idRepertorio: widget.repertorio.idRepertorio ?? 0,
                      isResponsavel: isResponsavel,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text("Voltar para a Banda"),
              onTap: () async {
                BandaService bandaService = BandaService();
                Banda? banda = await bandaService.buscarBandaPorId(widget.idBanda);

                if (banda != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesBandaPage(
                        banda: banda,
                        usuarioId: widget.usuarioId,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Erro ao carregar detalhes da banda."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Sair"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Músicas:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : musicas.isNotEmpty
                      ? ListView.builder(
                          itemCount: musicas.length,
                          itemBuilder: (context, index) {
                            return Card(
                              key: ValueKey(musicas[index].idMusica),
                              color: Colors.grey[900],
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Center(
                                  child: Text(
                                    "${musicas[index].ordem} - ${musicas[index].tituloMusica}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (isResponsavel) ...[
                                      IconButton(
                                        icon: const Icon(Icons.arrow_upward, color: Colors.green),
                                        onPressed: index > 0 ? () => _moverMusica(index, -1) : null,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.arrow_downward, color: Colors.red),
                                        onPressed: index < musicas.length - 1 ? () => _moverMusica(index, 1) : null,
                                      ),
                                    ],
                                    if (musicas[index].arquivoPdf != null)
                                      TextButton.icon(
                                        icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                                        label: const Text("Abrir", style: TextStyle(color: Colors.white70)),
                                        onPressed: () => _abrirPdf(musicas[index].arquivoPdf),
                                      ),
                                    if (isResponsavel)
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _removerMusica(index),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            "Nenhuma música cadastrada.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
            ),
             const SizedBox(height: 20),

            // Exibir o PDF somente se _pdfUrl não for nulo
          ],
        ),
      ),
    );
  }
}