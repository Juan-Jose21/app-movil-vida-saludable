import 'dart:convert';
import 'package:flutter/material.dart';

Feeding feedingFromJson(String str) => Feeding.fromJson(json.decode(str));

String feedingToJson(Feeding data) => json.encode(data.toJson());

class Feeding {

  String? id;
  DateTime? fecha;
  TimeOfDay? hora;
  String? tipo_alimento;
  String? saludable;
  String? user_id;

  Feeding({
    this.id,
    this.fecha,
    this.hora,
    this.tipo_alimento,
    this.saludable,
    this.user_id,
  });

  factory Feeding.fromJson(Map<String, dynamic> json) => Feeding(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    hora: TimeOfDay.fromDateTime(DateTime.parse(json["hora"])),
    tipo_alimento: json["tipo_alimento"],
    saludable: json["saludable"],
    user_id: json["user_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "hora": "${hora!.hour}:${hora!.minute}",
    "tipo_alimento": tipo_alimento,
    "saludable": saludable,
    "user_id": user_id
  };

}
