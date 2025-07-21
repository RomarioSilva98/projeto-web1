import 'package:flutter/material.dart';
import 'package:projetoweb1/models/banda.dart';
import 'package:projetoweb1/services/banda_service.dart';

class GerenciarBandaPage extends StatefulWidget {
  final int usuarioId;

  const GerenciarBandaPage({Key? key, required this.usuarioId}) : super(key: key);

  @override
  _GerenciarBandaPageState createState() => _GerenciarBandaPageState();
}

class _GerenciarBandaPageState extends State<GerenciarBandaPage> {
  late Future<List<Banda>> _bandasFuture;
  final BandaService _bandaService = BandaService();

  @override
  void initState() {
    super.initState();
    _atualizarBandas();
  }

  void _atualizarBandas() {
    setState(() {
      _bandasFuture = _bandaService.buscarBandasDoUsuario(widget.usuarioId);
    });
  }

  void _confirmarExclusaoBanda(int bandaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: const Text("Tem certeza que deseja excluir esta banda?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _bandaService.excluirBanda(bandaId, widget.usuarioId);
                _atualizarBandas();
              },
              child: const Text("Excluir", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _editarBanda(Banda banda) {
    TextEditingController nomeController = TextEditingController(text: banda.nomeBanda);
    TextEditingController generoController = TextEditingController(text: banda.genero);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editar Banda"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Novo Nome"),
              ),
              TextField(
                controller: generoController,
                decoration: const InputDecoration(labelText: "Novo Gênero"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                String novoNome = nomeController.text.trim();
                String novoGenero = generoController.text.trim();
                
                if ((novoNome.isNotEmpty && novoNome != banda.nomeBanda) ||
                    (novoGenero.isNotEmpty && novoGenero != banda.genero)) {
                  await _bandaService.atualizarBanda(
                    banda.idBanda!,
                    novoNome: novoNome.isNotEmpty ? novoNome : null,
                    novoGenero: novoGenero.isNotEmpty ? novoGenero : null,
                  );
                  _atualizarBandas();
                }
                Navigator.of(context).pop();
              },
              child: const Text("Salvar", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gerenciar Bandas"), backgroundColor: Colors.blue),
      body: FutureBuilder<List<Banda>>(
        future: _bandasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar bandas"));
          }

          final bandas = snapshot.data ?? [];

          return bandas.isEmpty
              ? const Center(child: Text("Você não possui bandas."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: bandas.length,
                  itemBuilder: (context, index) {
                    final banda = bandas[index];
                    return Card(
                      child: ListTile(
                        title: Text(banda.nomeBanda ?? ''),
                        subtitle: Text(banda.genero ?? 'Gênero desconhecido'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editarBanda(banda),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmarExclusaoBanda(banda.idBanda!),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
