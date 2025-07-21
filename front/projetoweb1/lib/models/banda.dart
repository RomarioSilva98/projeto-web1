import 'usuario.dart';
import 'repertorio.dart';

class Banda {
  int? idBanda;
  String? nomeBanda;
  String? genero;
  Usuario? responsavel; 
  List<Usuario>? usuarios;
  List<Repertorio>? repertorios;

  Banda({this.idBanda, this.nomeBanda, this.genero, this.responsavel, this.usuarios, this.repertorios});

  factory Banda.fromJson(Map<String, dynamic> json) {
    return Banda(
      idBanda: json['idBanda'] as int?,
      nomeBanda: json['nomeBanda'] as String?,
      genero: json['genero'] as String?,
      responsavel: json['responsavel'] != null ? Usuario.fromJson(json['responsavel']) : null, 
      usuarios: json['usuarios'] != null
          ? (json['usuarios'] as List).map((u) => Usuario.fromJson(u)).toList()
          : [],
      repertorios: json['repertorios'] != null
          ? (json['repertorios'] as List).map((r) => Repertorio.fromJson(r)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBanda': idBanda ?? 0,
      'nomeBanda': nomeBanda,
      'genero': genero,
      'responsavel': responsavel?.toJson(), // Adicionado
      'usuarios': usuarios?.map((u) => u.toJson()).toList(),
      'repertorios': repertorios?.map((r) => r.toJson()).toList(),
    };
  }
}
