import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Para definir o tipo do arquivo
import '../models/musica.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MusicaService {
  final String baseUrl = "http://localhost:8080/musicas"; 

  /// Faz o upload do arquivo e cria uma música com a URL retornada
  Future<bool> createMusicaComArquivo(String titulo, dynamic arquivo, int bandaId) async {
    var uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest('POST', uri);

    // Criar JSON corretamente formatado
    Map<String, dynamic> musicaData = {
      "titulo": titulo,
    };

    String musicaJson = jsonEncode(musicaData);

    // Adicionar o JSON da música como String
    request.fields['musica'] = musicaJson;
    request.fields['bandaId'] = bandaId.toString(); // Enviar bandaId no body

    // Adicionar o arquivo PDF
    if (kIsWeb) {
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        arquivo['bytes'],
        filename: arquivo['nome'],
        contentType: MediaType('application', 'pdf'),
      ));
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        arquivo.path,
        contentType: MediaType('application', 'pdf'),
      ));
    }

    // Enviar a requisição
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      String responseBody = await response.stream.bytesToString();
      print("Erro ao criar música: ${response.statusCode}");
      print("Resposta do servidor: $responseBody");
      return false;
    }
  }

}
