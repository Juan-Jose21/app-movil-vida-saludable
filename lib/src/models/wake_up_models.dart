import 'dart:convert';
import 'package:flutter/material.dart';

Wake_up wake_upFromJson(String str) => Wake_up.fromJson(json.decode(str));

String wake_upToJson(Wake_up data) => json.encode(data.toJson());

class Wake_up {

  String? id;
  DateTime? fecha;
  TimeOfDay? hora;
  String? estado;
  String? usuario;

  Wake_up({
    this.id,
    this.fecha,
    this.hora,
    this.estado,
    this.usuario,
  });

  factory Wake_up.fromJson(Map<String, dynamic> json) => Wake_up(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    hora: TimeOfDay.fromDateTime(DateTime.parse(json["hora"])),
    estado: json["estado"],
    usuario: json["usuario"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "hora": "${hora!.hour}:${hora!.minute}",
    "estado": estado,
    "usuario": usuario,
  };

}
