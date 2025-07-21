import 'package:flutter/material.dart';
import '../services/repertorio_service.dart';
import '../models/musica.dart';

class AdicionarMusicaPage extends StatefulWidget {
  final int idRepertorio;
  final int idBanda;

  const AdicionarMusicaPage({
    Key? key,
    required this.idRepertorio,
    required this.idBanda,
  }) : super(key: key);

  @override
  _AdicionarMusicaPageState createState() => _AdicionarMusicaPageState();
}

class _AdicionarMusicaPageState extends State<AdicionarMusicaPage> {
  final RepertorioService _repertorioService = RepertorioService();
  final TextEditingController _buscaController = TextEditingController();
  List<Musica> _musicasEncontradas = [];
  final Map<int, TextEditingController> _ordemControllers = {}; // Guarda a ordem das músicas
  bool _carregando = false;

void _buscarMusicas() async {
  setState(() => _carregando = true);
  List<Musica> musicas = await _repertorioService.buscarMusicas(_buscaController.text, widget.idBanda);
  setState(() {
    _musicasEncontradas = musicas;
    _carregando = false;
    _ordemControllers.clear();
    for (var musica in musicas) {
      _ordemControllers[musica.idMusica ?? 0] = TextEditingController();
    }
  });
}


  void _adicionarMusica(int idMusica) async {
    String ordem = _ordemControllers[idMusica]?.text.trim() ?? "1"; // Pegando a ordem inserida pelo usuário

    if (ordem.isEmpty || int.tryParse(ordem) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Digite um número válido para a ordem."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool sucesso = await _repertorioService.adicionarMusicaAoRepertorio(
          idRepertorio: widget.idRepertorio,
          idBanda: widget.idBanda,
          idMusica: idMusica,
          ordem: ordem,
        ) !=
        null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(sucesso ? "Música adicionada com sucesso!" : "Erro ao adicionar música."),
        backgroundColor: sucesso ? Colors.green : Colors.red,
      ),
    );
    
    if (sucesso) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Música", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _buscaController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Buscar Música",
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _buscarMusicas,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _carregando
                ? const CircularProgressIndicator(color: Colors.white)
                : Expanded(
                    child: ListView.builder(
                      itemCount: _musicasEncontradas.length,
                      itemBuilder: (context, index) {
                        final musica = _musicasEncontradas[index];
                        return Card(
                          color: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    musica.titulo ?? " ",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _ordemControllers[musica.idMusica ?? 0],
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: "Ordem",
                                          labelStyle: const TextStyle(color: Colors.white70),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.white70),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () => _adicionarMusica(musica.idMusica ?? 0),
                                      child: const Text("Adicionar"),
                                      
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
