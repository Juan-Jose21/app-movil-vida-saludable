import 'dart:convert';

Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));

String exerciseToJson(Exercise data) => json.encode(data.toJson());

class Exercise {

  String? id;
  DateTime? fecha;
  String? tipo;
  String? tiempo;
  String? user_id;

  Exercise({
    this.id,
    this.fecha,
    this.tipo,
    this.tiempo,
    this.user_id,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    tipo: json["tipo"],
    tiempo: json["tiempo"],
    user_id: json["user_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "tipo": tipo,
    "tiempo": tiempo,
    "user_id": user_id,
  };

}
