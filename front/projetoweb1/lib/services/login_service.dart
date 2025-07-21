import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetoweb1/models/usuario.dart';
class LoginService {
  Future<Usuario?> autenticar({required String email, required String senha}) async {
    var url = Uri.parse('http://localhost:8080/login');
    var strJson = jsonEncode({'email': email, 'senha': senha});

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8"
    };

    try {
      http.Response response = await http.post(url, body: strJson, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return Usuario.fromJson(jsonResponse);
      } else {
        print("❌ [LOGIN] Erro: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ [LOGIN] Erro na requisição: $e");
      return null;
    }
  }
}

