import 'package:flutter/material.dart';
import 'package:projetoweb1/services/repertorio_service.dart';

class CriarRepertorioPage extends StatefulWidget {
  final int idBanda;

  const CriarRepertorioPage({Key? key, required this.idBanda}) : super(key: key);

  @override
  _CriarRepertorioPageState createState() => _CriarRepertorioPageState();
}

class _CriarRepertorioPageState extends State<CriarRepertorioPage> {
  final RepertorioService _repertorioService = RepertorioService();
  final TextEditingController _nomeController = TextEditingController();
  bool _isLoading = false;

  void _criarRepertorio() async {
    String nomeRepertorio = _nomeController.text.trim();
    if (nomeRepertorio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, insira um nome para o repertório.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool sucesso = await _repertorioService.criarRepertorio(widget.idBanda, nomeRepertorio);
    setState(() {
      _isLoading = false;
    });

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Repertório criado com sucesso!"), backgroundColor: Colors.green),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao criar repertório!"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Repertório", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // Azul para seguir o padrão do app
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nome do Repertório:", style: TextStyle(color: Colors.white)),
            TextField(
              controller: _nomeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Digite o nome",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _criarRepertorio,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Azul para seguir padrão
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("Criar", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
