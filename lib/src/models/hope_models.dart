import 'dart:convert';

Hope hopeFromJson(String str) => Hope.fromJson(json.decode(str));

String hopeToJson(Hope data) => json.encode(data.toJson());

class Hope {

  String? id;
  DateTime? fecha;
  String? tipo_practica;
  String? user_id;

  Hope({
    this.id,
    this.fecha,
    this.tipo_practica,
    this.user_id,
  });

  factory Hope.fromJson(Map<String, dynamic> json) => Hope(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    tipo_practica: json["tipo_practica"],
    user_id: json["user_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "tipo_practica": tipo_practica,
    "user_id": user_id,
  };

}
