class RepertorioMusicas {
  final int? idRepertorioMusica;
  final int? idMusica;
  final String? tituloMusica;
  final String? ordem;
  final int? idRepertorio;
  final int? idBanda;
  final String? arquivoPdf; 

  RepertorioMusicas({
    this.idRepertorioMusica,
    this.idMusica,
    this.tituloMusica,
    this.ordem,
    this.idRepertorio,
    this.idBanda,
    this.arquivoPdf,
  });

  factory RepertorioMusicas.fromJson(Map<String, dynamic> json) {
    return RepertorioMusicas(
      idRepertorioMusica: json["idRepertorioMusica"] as int?,
      idMusica: json["idMusica"] as int?,
      tituloMusica: json["tituloMusica"] as String?,
      ordem: json["ordem"] as String?,
      idRepertorio: json["idRepertorio"] as int?,
      idBanda: json["idBanda"] as int?,
      arquivoPdf: json["arquivoPdf"] as String?, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idRepertorioMusica": idRepertorioMusica,
      "idMusica": idMusica,
      "tituloMusica": tituloMusica,
      "ordem": ordem,
      "idRepertorio": idRepertorio,
      "idBanda": idBanda,
      "arquivoPdf": arquivoPdf, 
    };
  }
}
