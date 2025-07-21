import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoweb1/models/banda.dart';

class BandaService {
  final String baseUrl = 'http://localhost:8080/banda';

  Future<List<Banda>> buscarBandasDoUsuario(int idUsuario) async {
    var url = Uri.parse('$baseUrl/usuario/$idUsuario');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((banda) => Banda.fromJson(banda)).toList();
      }
      return [];
    } catch (e) {
      print("❌ [BANDAS] Erro na requisição: $e");
      return [];
    }
  }

  Future<Banda?> buscarBandaPorId(int bandaId) async {
    var url = Uri.parse('$baseUrl/$bandaId');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return Banda.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print("❌ [BANDAS] Erro na requisição: $e");
      return null;
    }
  }

   Future<bool> criarBanda(Banda banda, int usuarioId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/criar'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nomeBanda": banda.nomeBanda,
        "genero": banda.genero,
        "idResponsavel": usuarioId, // Ajustado para corresponder ao backend
      }),
    );

    return response.statusCode == 200; // Ajustado para a resposta correta do backend
  }

  Future<bool> adicionarMusico(int bandaId, int musicoId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$bandaId/adicionarMusico?musicoId=$musicoId'),
    );
    return response.statusCode == 200;
  }

  Future<bool> removerMusico(int bandaId, int musicoId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$bandaId/removerMusico?musicoId=$musicoId'),
    );
    return response.statusCode == 200;
  }

  Future<bool> atualizarBanda(int bandaId, {String? novoNome, String? novoGenero}) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$bandaId/atualizar?novoNome=$novoNome&novoGenero=$novoGenero'),
    );
    return response.statusCode == 200;
  }

  Future<bool> excluirBanda(int bandaId, int usuarioId) async {
  final url = '$baseUrl/$bandaId/excluir?usuarioId=$usuarioId';
  print('URL de exclusão: $url');  // Verifique a URL gerada
  final response = await http.delete(Uri.parse(url));
  print('Código de status: ${response.statusCode}');
  return response.statusCode == 200;

  }
}
