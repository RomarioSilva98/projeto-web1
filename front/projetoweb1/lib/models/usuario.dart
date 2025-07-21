import 'banda.dart';

class Usuario {
  int? idUsuario; 
  String? nomeUsuario;
  String? email;
  String? senha;
  List<Banda>? bandas;

  Usuario({this.idUsuario, this.nomeUsuario, this.email, this.senha, this.bandas});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['idUsuario'] as int?,
      nomeUsuario: json['nomeUsuario'] as String?,
      email: json['email'] as String?,
      senha: json['senha'] as String?,
      bandas: (json['bandas'] as List<dynamic>?)
          ?.map((banda) => Banda.fromJson(banda))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario??0,
      'nomeUsuario': nomeUsuario,
      'email': email,
      'senha': senha,
      'bandas': bandas?.map((banda) => banda.toJson()).toList(),
    };
  }
}
