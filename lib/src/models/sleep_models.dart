import 'dart:convert';
import 'package:flutter/material.dart';

Sleep sleepFromJson(String str) => Sleep.fromJson(json.decode(str));

String airToJson(Sleep data) => json.encode(data.toJson());

class Sleep {

  String? id;
  DateTime? fecha;
  TimeOfDay? hora;
  String? usuario;

  Sleep({
    this.id,
    this.fecha,
    this.hora,
    this.usuario,
  });

  factory Sleep.fromJson(Map<String, dynamic> json) => Sleep(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    hora: TimeOfDay.fromDateTime(DateTime.parse(json["hora"])),
    usuario: json["usuario"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "hora": "${hora!.hour}:${hora!.minute}",
    "usuario": usuario,
  };

}
