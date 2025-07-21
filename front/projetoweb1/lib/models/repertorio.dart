class Repertorio {
  int? idRepertorio;
  String? nome;

  Repertorio({this.idRepertorio, this.nome});

  factory Repertorio.fromJson(Map<String, dynamic> json) {
    return Repertorio(
      idRepertorio: json['idRepertorio'] as int?,
      nome: json['nome'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idRepertorio': idRepertorio ?? 0,
      'nome': nome,
    };
  }
}
