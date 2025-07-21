import 'package:flutter/material.dart';
import 'package:projetoweb1/services/login_service.dart';
import 'package:projetoweb1/models/usuario.dart';
import 'package:projetoweb1/views/home_page.dart';
import 'package:projetoweb1/views/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecSenha = TextEditingController();
  bool _obscureText = true;
  final LoginService loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Bem-vindo ao SongFlow",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: tecEmail,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: tecSenha,
                obscureText: _obscureText,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Ainda não tem conta? Cadastre-se",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginAction() async {
    Usuario? usuario = await loginService.autenticar(
      email: tecEmail.text,
      senha: tecSenha.text,
    );

    if (usuario != null) {
      print("✅ [LOGIN] Sucesso! ID: \${usuario.idUsuario}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(usuarioId: usuario.idUsuario!)),
      );
    } else {
      print("❌ [LOGIN] Falha ao autenticar");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao fazer login. Verifique suas credenciais."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
