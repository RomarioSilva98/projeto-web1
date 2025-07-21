import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'dart:html' as html;
import 'package:projetoweb1/models/repertorio_musica.dart';

class ModoShowPage extends StatefulWidget {
  final List<RepertorioMusicas> musicas;
  final int idRepertorio;
  final bool isResponsavel;

  const ModoShowPage({
    Key? key,
    required this.musicas,
    required this.idRepertorio,
    required this.isResponsavel,
  }) : super(key: key);

  @override
  _ModoShowPageState createState() => _ModoShowPageState();
}

class _ModoShowPageState extends State<ModoShowPage> {
  int indexAtual = 0;
  String? pdfUrl;
  late StompClient stompClient;
  late List<RepertorioMusicas> musicasOrdenadas;

  @override
  void initState() {
    super.initState();
    _ordenarMusicas();
    _connectWebSocket();
    _carregarPdf();
  }

  void _ordenarMusicas() {
    musicasOrdenadas = List.from(widget.musicas);

    // Se 'ordem' for um número, converte antes de ordenar
    musicasOrdenadas.sort((a, b) =>
        int.tryParse(a.ordem ?? '0')!.compareTo(int.tryParse(b.ordem ?? '0')!));
  }

  void _enviarMudarMusica(int novoIndex) {
    if (widget.isResponsavel) {
      stompClient.send(
        destination: "/app/mudar-musica",
        body: jsonEncode(novoIndex),
      );
    }
  }

  void _mudarMusica(int novoIndex) {
    setState(() {
      indexAtual = novoIndex;
      _carregarPdf();
    });

    _enviarMudarMusica(novoIndex);
  }

void _connectWebSocket() {
  stompClient = StompClient(
    config: StompConfig(
      url: 'ws://localhost:8080/ws/websocket',
      onConnect: (StompFrame frame) {
        stompClient.subscribe(
          destination: '/topic/repertorio',
          callback: (StompFrame frame) {
            if (frame.body != null) {
              try {
                var data = jsonDecode(frame.body!);
                
                if (data is int) {
                  setState(() {
                    indexAtual = data;
                    _carregarPdf();
                  });
                } else {
                  print("Formato de dado inesperado: $data");
                }
              } catch (e) {
                print("Erro ao processar dados do WebSocket: $e");
              }
            }
          },
        );
      },
    ),
  );
  stompClient.activate();
}


  void _carregarPdf() {
    if (musicasOrdenadas.isEmpty) return;

    String? novoPdfUrl = musicasOrdenadas[indexAtual].arquivoPdf;

    if (novoPdfUrl != null) {
      // Adiciona um parâmetro dinâmico para evitar cache
      novoPdfUrl = '$novoPdfUrl?t=${DateTime.now().millisecondsSinceEpoch}';
    }

    // print("Novo PDF URL: $novoPdfUrl");

    setState(() {
      pdfUrl = novoPdfUrl;
    });
  }

  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modo Show - ${musicasOrdenadas[indexAtual].tituloMusica}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: pdfUrl == null
                ? Center(child: CircularProgressIndicator())
                : HtmlWidget(
                    key: ValueKey(
                        pdfUrl), // Força a reconstrução do widget quando o pdfUrl muda
                    '<iframe src="$pdfUrl" width="412px" height="900px" style="border: none;"></iframe>',
                  ),
          ),
          if (widget.isResponsavel) // Apenas o responsável pode ver os botões
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (indexAtual > 0)
                  ElevatedButton(
                    onPressed: () => _mudarMusica(indexAtual - 1),
                    child: Text("Anterior"),
                  ),
                SizedBox(width: 10),
                if (indexAtual < musicasOrdenadas.length - 1)
                  ElevatedButton(
                    onPressed: () => _mudarMusica(indexAtual + 1),
                    child: Text("Próximo"),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
