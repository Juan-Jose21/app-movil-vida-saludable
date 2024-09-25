import 'dart:convert';

import 'package:flutter/material.dart';

Water waterFromJson(String str) => Water.fromJson(json.decode(str));

String waterToJson(Water data) => json.encode(data.toJson());

class Water {

  String? id;
  DateTime? fecha;
  TimeOfDay? hora;
  String? cantidad;
  String? usuario;

  Water({
    this.id,
    this.fecha,
    this.hora,
    this.cantidad,
    this.usuario,
  });

  factory Water.fromJson(Map<String, dynamic> json) => Water(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    hora: TimeOfDay.fromDateTime(DateTime.parse(json["hora"])),
    cantidad: json["cantidad"],
    usuario: json["usuario"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "hora": "${hora!.hour}:${hora!.minute}",
    "catidad": cantidad,
    "usuario": usuario,
  };

}
