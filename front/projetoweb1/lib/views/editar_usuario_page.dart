import 'package:flutter/material.dart';
import 'package:projetoweb1/models/usuario.dart';
import 'package:projetoweb1/services/usuario_service.dart';
import 'package:projetoweb1/utils/crypto_util.dart';

class EditarUsuarioPage extends StatefulWidget {
  final int usuarioId;

  const EditarUsuarioPage({Key? key, required this.usuarioId}) : super(key: key);

  @override
  _EditarUsuarioPageState createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final _formDadosKey = GlobalKey<FormState>();
  final _formSenhaKey = GlobalKey<FormState>();
  final UsuarioService _usuarioService = UsuarioService();

  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _senhaAtualController;
  late TextEditingController _novaSenhaController;

  bool _isLoading = true;
  bool _mostrarSenhaAtual = false;
  bool _mostrarNovaSenha = false;
  String? _senhaCriptografadaNoBanco;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _emailController = TextEditingController();
    _senhaAtualController = TextEditingController();
    _novaSenhaController = TextEditingController();
    _carregarDadosUsuario();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaAtualController.dispose();
    _novaSenhaController.dispose();
    super.dispose();
  }

  Future<void> _carregarDadosUsuario() async {
    try {
      Usuario? usuario = await _usuarioService.buscarUsuarioPorId(widget.usuarioId);
      if (usuario != null) {
        setState(() {
          _nomeController.text = usuario.nomeUsuario ?? "";
          _emailController.text = usuario.email ?? "";
          _senhaCriptografadaNoBanco = usuario.senha;
          _isLoading = false;
        });
      } else {
        throw Exception("Usuário não encontrado");
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar dados do usuário: $e")),
      );
    }
  }

  Future<void> _salvarDados() async {
    if (!_formDadosKey.currentState!.validate()) return;

    Usuario usuarioAtualizado = Usuario(
      idUsuario: widget.usuarioId,
      nomeUsuario: _nomeController.text,
      email: _emailController.text,
      senha: _senhaCriptografadaNoBanco,
    );

    bool sucesso = await _usuarioService.atualizarUsuario(usuarioAtualizado);
    _mostrarMensagem(sucesso, "Dados atualizados com sucesso!", "Erro ao atualizar usuário");
  }

  Future<void> _alterarSenha() async {
    if (!_formSenhaKey.currentState!.validate()) return;

    bool senhaCorreta = await CryptoUtil.verificarSenha(
      _senhaAtualController.text, _senhaCriptografadaNoBanco!,
    );

    if (!senhaCorreta) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Senha atual incorreta!")),
      );
      return;
    }

    String novaSenhaCriptografada = await CryptoUtil.criptografarSenha(_novaSenhaController.text);
    Usuario usuarioAtualizado = Usuario(
      idUsuario: widget.usuarioId,
      nomeUsuario: _nomeController.text,
      email: _emailController.text,
      senha: novaSenhaCriptografada,
    );

    bool sucesso = await _usuarioService.atualizarUsuario(usuarioAtualizado);
    _mostrarMensagem(sucesso, "Senha alterada com sucesso!", "Erro ao alterar senha");
  }

  void _mostrarMensagem(bool sucesso, String sucessoMsg, String erroMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(sucesso ? sucessoMsg : erroMsg)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    bool? mostrarSenha,
    VoidCallback? toggleMostrarSenha,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText && !(mostrarSenha ?? false),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.white),
          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(mostrarSenha! ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                  onPressed: toggleMostrarSenha,
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Editar Perfil"), backgroundColor: Colors.blue),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formDadosKey,
                    child: Column(
                      children: [
                        _buildTextField(controller: _nomeController, label: "Nome", icon: Icons.person, validator: (value) => value!.isEmpty ? "Digite um nome" : null),
                        _buildTextField(controller: _emailController, label: "Email", icon: Icons.email, validator: (value) => value!.isEmpty ? "Digite um email" : null),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _salvarDados,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child: const Text("Salvar Dados", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formSenhaKey,
                    child: Column(
                      children: [
                        _buildTextField(controller: _senhaAtualController, label: "Senha Atual", icon: Icons.lock, obscureText: true, mostrarSenha: _mostrarSenhaAtual, toggleMostrarSenha: () => setState(() => _mostrarSenhaAtual = !_mostrarSenhaAtual), validator: (value) => value!.isEmpty ? "Digite sua senha atual" : null),
                        _buildTextField(controller: _novaSenhaController, label: "Nova Senha", icon: Icons.lock_outline, obscureText: true, mostrarSenha: _mostrarNovaSenha, toggleMostrarSenha: () => setState(() => _mostrarNovaSenha = !_mostrarNovaSenha)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _alterarSenha,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child: const Text("Alterar Senha", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
