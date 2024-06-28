import 'dart:convert';

import 'package:flutter/material.dart';

Water waterFromJson(String str) => Water.fromJson(json.decode(str));

String waterToJson(Water data) => json.encode(data.toJson());

class Water {

  String? id;
  DateTime? fecha;
  TimeOfDay? hora;
  String? cantidad;
  String? user_id;

  Water({
    this.id,
    this.fecha,
    this.hora,
    this.cantidad,
    this.user_id,
  });

  factory Water.fromJson(Map<String, dynamic> json) => Water(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    hora: TimeOfDay.fromDateTime(DateTime.parse(json["hora"])),
    cantidad: json["cantidad"],
    user_id: json["user_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "hora": "${hora!.hour}:${hora!.minute}",
    "catidad": cantidad,
    "user_id": user_id,
  };

}
