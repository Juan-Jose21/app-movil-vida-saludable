import 'dart:convert';

import 'package:flutter/material.dart';

Sun sunFromJson(String str) => Sun.fromJson(json.decode(str));

String sunToJson(Sun data) => json.encode(data.toJson());

class Sun {

  String? id;
  DateTime? fecha;
  String? tiempo;
  String? usuario;

  Sun({
    this.id,
    this.fecha,
    this.tiempo,
    this.usuario,
  });

  factory Sun.fromJson(Map<String, dynamic> json) => Sun(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    tiempo: json["tiempo"],
    usuario: json["usuario"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "tiempo": tiempo,
    "usuario": usuario,
  };

}
