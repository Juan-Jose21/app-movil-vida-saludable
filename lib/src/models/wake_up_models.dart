import 'dart:convert';
import 'package:flutter/material.dart';

Wake_up wake_upFromJson(String str) => Wake_up.fromJson(json.decode(str));

String wake_upToJson(Wake_up data) => json.encode(data.toJson());

class Wake_up {

  String? id;
  DateTime? fecha;
  TimeOfDay? hora;
  String? estado;
  String? user_id;

  Wake_up({
    this.id,
    this.fecha,
    this.hora,
    this.estado,
    this.user_id,
  });

  factory Wake_up.fromJson(Map<String, dynamic> json) => Wake_up(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    hora: TimeOfDay.fromDateTime(DateTime.parse(json["hora"])),
    estado: json["estado"],
    user_id: json["user_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "hora": "${hora!.hour}:${hora!.minute}",
    "estado": estado,
    "user_id": user_id,
  };

}
