class UserModel {
  final String id;
  final String name;
  final String email;
  final List<String> roles;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
  });

  /// Désérialisation : convertir un Map (JSON) en UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      roles: List<String>.from(json["roles"] ?? []),
    );
  }

  /// Sérialisation : convertir UserModel en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "roles": roles,
    };
  }
}
