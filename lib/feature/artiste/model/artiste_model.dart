class ArtisteModel {
  final int id;
  final int userId;

  final String nomComplet;
  final String nomArtiste;

  final String dateNaissance;
  final String sexe;
  final String discipline;

  final String adresse;
  final String? quartier;

  final String telephone;
  final String email;

  final String? biographie;

  final String? photoUrl;
  final String? videoUrl;
  final String? pieceIdentiteUrl;

  final String statut;

  final String? festirasId;

  final String? province;
  final String? ville;
  final String? pays;

  final String? hashtagOfficiel;

  final int totalVotes;
  final double scoreJury;
  final double scoreFinal;

  final int? phaseActuelleId;

  final String createdAt;
  final String updatedAt;

  ArtisteModel({
    required this.id,
    required this.userId,
    required this.nomComplet,
    required this.nomArtiste,
    required this.dateNaissance,
    required this.sexe,
    required this.discipline,
    required this.adresse,
    this.quartier,
    required this.telephone,
    required this.email,
    this.biographie,
    this.photoUrl,
    this.videoUrl,
    this.pieceIdentiteUrl,
    required this.statut,
    this.festirasId,
    this.province,
    this.ville,
    this.pays,
    this.hashtagOfficiel,
    required this.totalVotes,
    required this.scoreJury,
    required this.scoreFinal,
    this.phaseActuelleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ArtisteModel.fromJson(Map<String, dynamic> json) {
    return ArtisteModel(
      id: json["id"],
      userId: json["user_id"],

      nomComplet: json["nom_complet"] ?? "",
      nomArtiste: json["nom_artiste"] ?? "",

      dateNaissance: json["date_naissance"] ?? "",

      sexe: json["sexe"] ?? "",
      discipline: json["discipline"] ?? "",

      adresse: json["adresse"] ?? "",
      quartier: json["quartier"],

      telephone: json["telephone"] ?? "",
      email: json["email"] ?? "",

      biographie: json["biographie"],

      photoUrl: json["photo_url"],
      videoUrl: json["video_url"],
      pieceIdentiteUrl: json["piece_identite_url"],

      statut: json["statut"] ?? "",

      festirasId: json["festiras_id"],

      province: json["province"],
      ville: json["ville"],
      pays: json["pays"],

      hashtagOfficiel: json["hashtag_officiel"],

      totalVotes: json["total_votes"] ?? 0,
      scoreJury: (json["score_jury"] ?? 0).toDouble(),
      scoreFinal: (json["score_final"] ?? 0).toDouble(),

      phaseActuelleId: json["phase_actuelle_id"],

      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "nom_complet": nomComplet,
      "nom_artiste": nomArtiste,
      "date_naissance": dateNaissance,
      "sexe": sexe,
      "discipline": discipline,
      "adresse": adresse,
      "quartier": quartier,
      "telephone": telephone,
      "email": email,
      "biographie": biographie,
      "photo_url": photoUrl,
      "video_url": videoUrl,
      "piece_identite_url": pieceIdentiteUrl,
      "statut": statut,
      "festiras_id": festirasId,
      "province": province,
      "ville": ville,
      "pays": pays,
      "hashtag_officiel": hashtagOfficiel,
      "total_votes": totalVotes,
      "score_jury": scoreJury,
      "score_final": scoreFinal,
      "phase_actuelle_id": phaseActuelleId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}