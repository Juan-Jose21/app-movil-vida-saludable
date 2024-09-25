import 'dart:convert';

import 'package:flutter/material.dart';

Air airFromJson(String str) => Air.fromJson(json.decode(str));

String airToJson(Air data) => json.encode(data.toJson());

class Air {

  String? id;
  DateTime? fecha;
  String? tiempo;
  String? usuario;
  // TimeOfDay? hora_inicio;
  // TimeOfDay? hora_fin;

  Air({
    this.id,
    this.fecha,
    this.tiempo,
    this.usuario,
    // this.hora_inicio,
    // this.hora_fin,
  });

  factory Air.fromJson(Map<String, dynamic> json) => Air(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    tiempo: json["tiempo"],
    usuario: json["usuario"],
    // hora_inicio: TimeOfDay.fromDateTime(DateTime.parse(json["hora_inicio"])),
    // hora_fin: TimeOfDay.fromDateTime(DateTime.parse(json["hora_fin"])),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "tiempo": tiempo,
    "usuario": usuario,
    // "hora_inicio": "${hora_inicio!.hour}:${hora_inicio!.minute}",
    // "hora_fin": "${hora_fin!.hour}:${hora_fin!.minute}",
  };

}
