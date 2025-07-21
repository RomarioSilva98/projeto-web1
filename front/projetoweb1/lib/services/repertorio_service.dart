import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/repertorio.dart';
import '../models/banda.dart';
import '../models/musica.dart';
import '../models/repertorio_musica.dart';

class RepertorioService {
  final String baseUrl = 'http://localhost:8080/repertorios';

  Future<bool> criarRepertorio(int idBanda, String nomeRepertorio) async {
  var url = Uri.parse('$baseUrl/criar/$idBanda');
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"nomeRepertorio": nomeRepertorio}),
    );

    return response.statusCode == 200;
  } catch (e) {
    print("❌ [REPERTÓRIO] Erro ao criar repertório: $e");
    return false;
  }
}


  // Adicionar uma música ao repertório
  Future<Banda?> adicionarMusicaAoRepertorio({
  required int idRepertorio,
  required int idBanda,
  required int idMusica,
  required String ordem,
}) async {
  // Montando a URL com os parâmetros na query string
  var url = Uri.parse('$baseUrl/adicionar'
      '?idRepertorio=$idRepertorio'
      '&idBanda=$idBanda'
      '&idMusica=$idMusica'
      '&ordem=$ordem');

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Banda.fromJson(jsonDecode(response.body));
    } else {
      print("❌ [REPERTÓRIO] Erro ao adicionar música: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ [REPERTÓRIO] Erro na requisição: $e");
    return null;
  }
}


  // Listar músicas do repertório de uma banda
 Future<List<RepertorioMusicas>> listarMusicasDoRepertorio(int idRepertorio) async {
  var url = Uri.parse('$baseUrl/$idRepertorio'); // Corrigido para repertório
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((rep) => RepertorioMusicas.fromJson(rep)).toList();
    } else {
      print("❌ [REPERTÓRIO] Erro ao buscar músicas: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("❌ [REPERTÓRIO] Erro na requisição: $e");
    return [];
  }
}


Future<List<RepertorioMusicas>?> atualizarOrdemMusicas(
    int idRepertorio, List<Map<String, dynamic>> novaOrdem) async {
  var url = Uri.parse('$baseUrl/$idRepertorio/atualizar-ordem');

  print("🔄 Enviando requisição para: $url");

  try {
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"musicas": novaOrdem}),
    );

    print("📩 Resposta recebida: ${response.statusCode}");
    print("📦 Corpo da resposta: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<RepertorioMusicas> listaMusicas =
          jsonResponse.map((rep) => RepertorioMusicas.fromJson(rep)).toList();

      print("✅ Lista de músicas convertida: $listaMusicas");

      return listaMusicas;
    } else {
      print("❌ Erro ao atualizar ordem: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ Erro na requisição: $e");
    return null;
  }
}




  Future<List<Musica>> buscarMusicas(String titulo, int idBanda) async {
  var url = Uri.parse('http://localhost:8080/musicas/buscar?titulo=$titulo&idBanda=$idBanda');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((musica) => Musica.fromJson(musica)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print("❌ [MÚSICA] Erro ao buscar músicas: $e");
    return [];
  }
}


Future<Banda> buscarBanda(int idBanda) async {
    final response = await http.get(Uri.parse("http://localhost:8080/banda/$idBanda"));

    if (response.statusCode == 200) {
      return Banda.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao buscar banda");
    }
  }


  // Remover uma música do repertório
  Future<bool> removerMusicaDoRepertorio(int idRepertorio, int idMusica) async {
    var url = Uri.parse('$baseUrl/remover?idRepertorio=$idRepertorio&idMusica=$idMusica');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      print("❌ [REPERTÓRIO] Erro ao remover música: $e");
      return false;
    }
  }

  // Listar banda com músicas do repertório
  Future<Banda?> listarBandaComMusicasDoRepertorio(int idRepertorio) async {
    var url = Uri.parse('$baseUrl/banda-repertorio/$idRepertorio');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Banda.fromJson(jsonDecode(response.body));
      } else {
        print("❌ [REPERTÓRIO] Erro ao buscar banda: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ [REPERTÓRIO] Erro na requisição: $e");
      return null;
    }
  }

  Future<bool> atualizarRepertorio(int idRepertorio, String novoNome) async {
  var url = Uri.parse('$baseUrl/atualizar/$idRepertorio');
  try {
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"novoNome": novoNome}),
    );

    return response.statusCode == 200;
  } catch (e) {
    print("❌ [REPERTÓRIO] Erro ao atualizar repertório: $e");
    return false;
  }
}


  // Excluir repertório de uma banda
  Future<bool> excluirRepertorio(int idRepertorio) async {
    var url = Uri.parse('$baseUrl/excluir/repertorio/$idRepertorio');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      print("❌ [REPERTÓRIO] Erro ao excluir repertório: $e");
      return false;
    }
}


  Future<List<Repertorio>> listarRepertorios(int idBanda) async {
  var url = Uri.parse('$baseUrl/listar/$idBanda');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((rep) => Repertorio.fromJson(rep)).toList();
    } else {
      print("❌ [REPERTÓRIO] Erro ao listar repertórios: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("❌ [REPERTÓRIO] Erro na requisição: $e");
    return [];
  }
}


  // 🔥 Método para abrir o PDF de uma música
  Future<bool> abrirPdf(String? url) async {
    if (url == null || url.isEmpty) {
      print("❌ URL do PDF é inválida.");
      return false;
    }

    final Uri pdfUri = Uri.parse(url); // Agora assume que a URL já está completa no banco

    if (await canLaunchUrl(pdfUri)) {
      await launchUrl(pdfUri);
      return true;
    } else {
      print("❌ Não foi possível abrir o PDF.");
      return false;
    }
  }
}
