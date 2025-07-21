class Participacao {
  int? idParticipacao;
  int? bandaId;
  int? usuarioId; 

  Participacao({this.idParticipacao, this.bandaId, this.usuarioId});

  factory Participacao.fromJson(Map<String, dynamic> json) {
    return Participacao(
      idParticipacao: json['idParticipacao'] as int?,
      bandaId: json['bandaId'] as int?,
      usuarioId: json['usuarioId'] as int?, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idParticipacao': idParticipacao ?? 0,
      'bandaId': bandaId,
      'usuarioId': usuarioId, 
    };
  }
}
