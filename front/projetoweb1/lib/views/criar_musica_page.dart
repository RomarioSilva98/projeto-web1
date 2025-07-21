import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../services/musica_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CriarMusicaPage extends StatefulWidget {
  final int usuarioId;
  final int bandaId;

  CriarMusicaPage({required this.usuarioId, required this.bandaId});

  @override
  _CriarMusicaPageState createState() => _CriarMusicaPageState();
}

class _CriarMusicaPageState extends State<CriarMusicaPage> {
  final MusicaService _musicaService = MusicaService();

  dynamic _arquivoSelecionado;
  TextEditingController _tituloController = TextEditingController();

  @override
  Future<void> _selecionarArquivo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        if (kIsWeb) {
          _arquivoSelecionado = {
            'bytes': result.files.first.bytes!,
            'nome': result.files.first.name,
          };
        } else {
          _arquivoSelecionado = File(result.files.single.path!);
        }
      });
    }
  }

  Future<void> _salvarMusica() async {
    String titulo = _tituloController.text.trim();

    if (titulo.isEmpty || _arquivoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Preencha todos os campos!"), backgroundColor: Colors.red),
      );
      return;
    }

    bool sucesso = await _musicaService.createMusicaComArquivo(
      titulo, _arquivoSelecionado, widget.bandaId, // Usa a bandaId diretamente
    );

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Música criada com sucesso!"), backgroundColor: Colors.green),
      );

      setState(() {
        _tituloController.clear();
        _arquivoSelecionado = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao criar música!"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Criar Música"),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Título",
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _arquivoSelecionado != null
                          ? (kIsWeb ? _arquivoSelecionado['nome'] : _arquivoSelecionado.path.split('/').last)
                          : "Nenhum arquivo selecionado",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _selecionarArquivo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text("Selecionar", style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: _salvarMusica,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Salvar Música", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
