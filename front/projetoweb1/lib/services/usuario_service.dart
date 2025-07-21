import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoweb1/models/usuario.dart';

class UsuarioService {
  final String apiUrl = "http://localhost:8080/usuarios";

  Future<Usuario?> buscarUsuarioPorId(int usuarioId) async {
    final response = await http.get(Uri.parse("$apiUrl/$usuarioId"));

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<Usuario?> buscarUsuarioPorEmail(String email) async {
    final response = await http.get(Uri.parse("$apiUrl/buscar?email=$email"));

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<String> buscarNomeUsuario(int usuarioId) async {
    final usuario = await buscarUsuarioPorId(usuarioId);
    return usuario?.nomeUsuario ?? "Usuário";
  }

  Future<bool> atualizarUsuario(Usuario usuario) async {
    final response = await http.put(
      Uri.parse("$apiUrl/${usuario.idUsuario}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuario.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> excluirConta(int usuarioId) async {
  final response = await http.delete(
    Uri.parse("$apiUrl/${usuarioId}"),
  );
  return response.statusCode == 200;
}

}
