import 'dart:convert';

List<AuthModel> authModelFromJson(String str) =>
    List<AuthModel>.from(json.decode(str).map((x) => AuthModel.fromJson(x)));

String authModelToJson(List<AuthModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthModel {
  final String name;
  final String email;
  final String password;
  final String id;

  AuthModel({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "id": id,
      };
}
