import 'dart:convert';
import 'package:flutter/material.dart';

Sleep sleepFromJson(String str) => Sleep.fromJson(json.decode(str));

String airToJson(Sleep data) => json.encode(data.toJson());

class Sleep {

  String? id;
  DateTime? fecha;
  TimeOfDay? hora;
  String? user_id;

  Sleep({
    this.id,
    this.fecha,
    this.hora,
    this.user_id,
  });

  factory Sleep.fromJson(Map<String, dynamic> json) => Sleep(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    hora: TimeOfDay.fromDateTime(DateTime.parse(json["hora"])),
    user_id: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "hora_inicio": "${hora!.hour}:${hora!.minute}",
    "user_id": user_id,
  };

}
