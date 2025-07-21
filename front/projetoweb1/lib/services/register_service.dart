import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoweb1/models/usuario.dart';
class RegisterService {
  final String baseUrl = "http://localhost:8080"; 

  Future<Usuario?> cadastrar({required String nome, required String email, required String senha}) async {
    var url = Uri.parse("$baseUrl/usuarios");
    var strJson = jsonEncode({'nomeUsuario': nome, 'email': email, 'senha': senha});

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };

    try {
      http.Response response = await http.post(url, body: strJson, headers: headers);

      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        return Usuario.fromJson(jsonResponse);
      } else if (response.statusCode == 409) {
        print ("❌ [REGISTER] Erro: ${response.statusCode} - ${response.body}");
        return null; // Captura o erro específico
      } else {
        print("❌ [REGISTER] Erro: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ [REGISTER] Erro na requisição: $e");
      return null;
    }
  }
}
