class Musica {
  int? idMusica;
  String? titulo;
  String? arquivoPdf;
  StatusMusica? status;
  int? repertorioId;

  Musica({
    this.idMusica,
    this.titulo,
    this.arquivoPdf,
    this.status = StatusMusica.inativa, 
    this.repertorioId,
  });

  factory Musica.fromJson(Map<String, dynamic> json) {
    return Musica(
      idMusica: json['idMusica'] as int?,
      titulo: json['titulo'] as String?,
      arquivoPdf: json['arquivoPdf'] as String?,
      status: _parseStatus(json['status']),
      repertorioId: json['repertorioId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMusica': idMusica,
      'titulo': titulo,
      'arquivoPdf': arquivoPdf,
      'status': status?.name, 
      'repertorioId': repertorioId,
    };
  }

  static StatusMusica _parseStatus(String? status) {
    switch (status) {
      case 'ativa':
        return StatusMusica.ativa;
      case 'inativa':
        return StatusMusica.inativa;
      case 'removida':
        return StatusMusica.removida;
      default:
        return StatusMusica.inativa; 
    }
  }
}

enum StatusMusica { ativa, inativa, removida }
