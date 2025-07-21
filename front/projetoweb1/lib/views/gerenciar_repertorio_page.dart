import 'package:flutter/material.dart';
import '../models/banda.dart';
import '../models/repertorio.dart';
import '../services/repertorio_service.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class GerenciarRepertorioPage extends StatefulWidget {
  final int idBanda;

  const GerenciarRepertorioPage({Key? key, required this.idBanda}) : super(key: key);

  @override
  _GerenciarRepertorioPageState createState() => _GerenciarRepertorioPageState();
}

class _GerenciarRepertorioPageState extends State<GerenciarRepertorioPage> {
  final RepertorioService _repertorioService = RepertorioService();
  List<Repertorio> _repertorios = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarRepertorios();
  }

  Future<void> _carregarRepertorios() async {
    setState(() => _carregando = true);
    try {
      Banda banda = await _repertorioService.buscarBanda(widget.idBanda);
      setState(() {
        _repertorios = banda.repertorios ?? [];
      });
    } catch (e) {
      print("Erro ao carregar repertórios: $e");
    } finally {
      setState(() => _carregando = false);
    }
  }

  void _editarRepertorio(Repertorio repertorio) {
    TextEditingController _controller = TextEditingController(text: repertorio.nome);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editar Repertório"),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: "Novo Nome"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Salvar"),
              onPressed: () async {
                String novoNome = _controller.text.trim();
                if (novoNome.isNotEmpty) {
                  await _repertorioService.atualizarRepertorio(repertorio.idRepertorio!, novoNome);
                  Navigator.pop(context, true);
                  _carregarRepertorios();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmarExclusao(int idRepertorio, String nomeRepertorio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Excluir Repertório"),
          content: Text("Tem certeza que deseja excluir o repertório \"$nomeRepertorio\"?"),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Excluir", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop();
                await _excluirRepertorio(idRepertorio);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _excluirRepertorio(int idRepertorio) async {
    bool sucesso = await _repertorioService.excluirRepertorio(idRepertorio);
    if (sucesso) {
      setState(() {
        _repertorios.removeWhere((r) => r.idRepertorio == idRepertorio);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Repertório excluído com sucesso!"), backgroundColor: Colors.green),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao excluir repertório."), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Repertório"),
        backgroundColor: Colors.blue,
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _repertorios.isEmpty
              ? const Center(child: Text("Nenhum repertório encontrado."))
              : ListView.builder(
                  itemCount: _repertorios.length,
                  itemBuilder: (context, index) {
                    final repertorio = _repertorios[index];
                    return Card(
                      child: ListTile(
                        title: Text(repertorio.nome ?? "Sem título"),
                        leading: const Icon(Icons.library_music),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editarRepertorio(repertorio),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmarExclusao(repertorio.idRepertorio!, repertorio.nome ?? "Repertório"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
