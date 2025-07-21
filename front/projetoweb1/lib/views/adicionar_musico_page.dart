import 'package:flutter/material.dart';
import 'package:projetoweb1/services/banda_service.dart';
import 'package:projetoweb1/services/usuario_service.dart';
import 'package:projetoweb1/models/usuario.dart';
import 'package:projetoweb1/models/banda.dart';
import 'detalhes_banda_page.dart';

class AdicionarMusicoPage extends StatefulWidget {
  final int bandaId;
  final Banda banda;
  final int usuarioLogadoId; 

  const AdicionarMusicoPage({
    Key? key,
    required this.bandaId,
    required this.banda,
    required this.usuarioLogadoId,
  }) : super(key: key);

  @override
  _AdicionarMusicoPageState createState() => _AdicionarMusicoPageState();
}

class _AdicionarMusicoPageState extends State<AdicionarMusicoPage> {
  final TextEditingController _emailController = TextEditingController();
  final UsuarioService _usuarioService = UsuarioService();
  final BandaService _bandaService = BandaService();
  Usuario? _usuarioEncontrado;
  String? _mensagemErro;

  void _buscarMusico() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) return;

    Usuario? usuario = await _usuarioService.buscarUsuarioPorEmail(email);

    setState(() {
      if (usuario != null) {
        _usuarioEncontrado = usuario;
        _mensagemErro = null;
      } else {
        _usuarioEncontrado = null;
        _mensagemErro = "Usuário não encontrado.";
      }
    });
  }

  void _adicionarMusico() async {
    if (_usuarioEncontrado == null) return;

    bool sucesso =
        await _bandaService.adicionarMusico(widget.bandaId, _usuarioEncontrado!.idUsuario!);
    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Músico adicionado com sucesso!"),
          
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
      setState(() {
        _usuarioEncontrado = null; 
        _emailController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao adicionar músico."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _voltarParaDetalhesBanda() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesBandaPage(
          banda: widget.banda,
          usuarioId: widget.usuarioLogadoId, 
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        title: const Text("Buscar Músico"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white), 
              decoration: InputDecoration(
                labelText: "E-mail do músico",
                labelStyle: const TextStyle(color: Colors.white70),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _buscarMusico,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_mensagemErro != null)
              Text(
                _mensagemErro!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (_usuarioEncontrado != null)
              Card(
                color: Colors.grey[900], 
                child: ListTile(
                  title: Text(
                    _usuarioEncontrado!.nomeUsuario!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    _usuarioEncontrado!.email!,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: ElevatedButton(
                    onPressed: _adicionarMusico,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("Adicionar", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
