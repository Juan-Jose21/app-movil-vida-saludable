import 'dart:convert';

Hope hopeFromJson(String str) => Hope.fromJson(json.decode(str));

String hopeToJson(Hope data) => json.encode(data.toJson());

class Hope {

  String? id;
  DateTime? fecha;
  String? tipo_practica;
  String? usuario;

  Hope({
    this.id,
    this.fecha,
    this.tipo_practica,
    this.usuario,
  });

  factory Hope.fromJson(Map<String, dynamic> json) => Hope(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    tipo_practica: json["tipo_practica"],
    usuario: json["usuario"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "tipo_practica": tipo_practica,
    "usuario": usuario,
  };

}
