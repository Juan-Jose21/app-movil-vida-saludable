import 'dart:convert';

Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));

String exerciseToJson(Exercise data) => json.encode(data.toJson());

class Exercise {

  String? id;
  DateTime? fecha;
  String? tipo;
  String? tiempo;
  String? usuario;

  Exercise({
    this.id,
    this.fecha,
    this.tipo,
    this.tiempo,
    this.usuario,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    tipo: json["tipo"],
    tiempo: json["tiempo"],
    usuario: json["usuario"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "tipo": tipo,
    "tiempo": tiempo,
    "usuario": usuario,
  };

}
