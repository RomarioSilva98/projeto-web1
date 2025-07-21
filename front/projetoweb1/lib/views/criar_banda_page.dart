import 'package:flutter/material.dart';
import 'package:projetoweb1/models/banda.dart';
import 'package:projetoweb1/services/banda_service.dart';

class CriarBandaPage extends StatefulWidget {
  final int usuarioId;

  const CriarBandaPage({Key? key, required this.usuarioId}) : super(key: key);

  @override
  _CriarBandaPageState createState() => _CriarBandaPageState();
}

class _CriarBandaPageState extends State<CriarBandaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _generoController = TextEditingController();
  final BandaService _bandaService = BandaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        title: const Text("Criar Banda", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white), // Ícones brancos
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomeController,
                style: const TextStyle(color: Colors.white), 
                decoration: const InputDecoration(
                  labelText: "Nome da Banda",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, insira o nome da banda";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _generoController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Gênero",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Banda novaBanda = Banda(
                        nomeBanda: _nomeController.text,
                        genero: _generoController.text,
                      );
                      bool sucesso = await _bandaService.criarBanda(novaBanda, widget.usuarioId);
                      if (sucesso) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Banda criada com sucesso!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Erro ao criar banda!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Criar Banda"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
