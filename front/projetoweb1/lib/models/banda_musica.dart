import 'musica.dart';
import 'banda.dart';

class BandaMusica {
  int? idBandaMusica;
  Banda? banda;
  Musica? musica;
  String? dataAdicao;

  BandaMusica({this.idBandaMusica, this.banda, this.musica, this.dataAdicao});

  factory BandaMusica.fromJson(Map<String, dynamic> json) {
    return BandaMusica(
      idBandaMusica: json['idBandaMusica'] as int?,
      banda: json['banda'] != null ? Banda.fromJson(json['banda']) : null,
      musica: json['musica'] != null ? Musica.fromJson(json['musica']) : null,
      dataAdicao: json['dataAdicao'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBandaMusica': idBandaMusica ?? 0,
      'banda': banda?.toJson(),
      'musica': musica?.toJson(),
      'dataAdicao': dataAdicao,
    };
  }
}
