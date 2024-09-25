import 'dart:convert';

User userFromJson(String str) => User.fronJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  int? id;
  String? correo;
  String? nombre;
  String? refresh;
  String? access;

  User({
    this.id,
    this.correo,
    this.nombre,
    this.refresh,
    this.access
  });

  factory User.fronJson(Map<String, dynamic> json) => User(
      id: json["id"],
      correo: json["correo"],
      nombre: json["nombre"],
      refresh: json["refresh"],
      access: json["access"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "correo": correo,
    "nombre": nombre,
    "refresh": refresh,
    "access": access,
  };

}
