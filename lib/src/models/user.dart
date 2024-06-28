import 'dart:convert';

User userFromJson(String str) => User.fronJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String? id;
  String? email;
  String? name;
  String? last_name;
  String? phone;
  String? password;
  String? session_token;

  User({
    this.id,
    this.email,
    this.name,
    this.last_name,
    this.phone,
    this.password,
    this.session_token
  });

  factory User.fronJson(Map<String, dynamic> json) => User(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      last_name: json["last_name"],
      phone: json["phone"],
      password: json["password"],
      session_token: json["session_token"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "last_name": last_name,
    "phone": phone,
    "password": password,
    "session_token": session_token
  };

}
