import 'package:bcrypt/bcrypt.dart';

class CryptoUtil {
  /// Criptografa a senha usando BCrypt com um custo configurável
  static String criptografarSenha(String senha,) {
    return BCrypt.hashpw(senha, BCrypt.gensalt(logRounds : 12));
  }

  /// Compara a senha digitada com a senha armazenada no banco
  static bool verificarSenha(String senhaDigitada, String senhaArmazenada) {
    try {

      return BCrypt.checkpw(senhaDigitada, senhaArmazenada);
    } catch (e) {
      print("Erro ao verificar senha: $e");
      return false; // Retorna falso se houver erro na comparação
    }
  }
}
