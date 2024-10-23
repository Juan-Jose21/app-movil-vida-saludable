import 'dart:convert';
import 'package:flutter/material.dart';

Feeding feedingFromJson(String str) => Feeding.fromJson(json.decode(str));

String feedingToJson(Feeding data) => json.encode(data.toJson());

class Feeding {

  String? id;
  DateTime? fecha;
  TimeOfDay? desayuno_hora;
  TimeOfDay? almuerzo_hora;
  TimeOfDay? cena_hora;
  int? desayuno;
  int? almuerzo;
  int? cena;
  int? desayuno_saludable;
  int? almuerzo_saludable;
  int? cena_saludable;
  String? usuario;

  Feeding({
    this.id,
    this.fecha,
    this.desayuno_hora,
    this.almuerzo_hora,
    this.cena_hora,
    this.desayuno,
    this.almuerzo,
    this.cena,
    this.desayuno_saludable,
    this.almuerzo_saludable,
    this.cena_saludable,
    this.usuario,
  });

  factory Feeding.fromJson(Map<String, dynamic> json) => Feeding(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    desayuno_hora: TimeOfDay.fromDateTime(DateTime.parse(json["desayuno_hora"])),
    almuerzo_hora: TimeOfDay.fromDateTime(DateTime.parse(json["almuerzo_hora"])),
    cena_hora: TimeOfDay.fromDateTime(DateTime.parse(json["cena_hora"])),
    desayuno: json["desayuno"],
    almuerzo: json["almuerzo"],
    cena: json["cena"],
    desayuno_saludable: json["desayuno_saludable"],
    almuerzo_saludable: json["almuerzo_saludable"],
    cena_saludable: json["cena_saludable"],
    usuario: json["usuario"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": fecha.toString(),
    "desayuno_hora": "${desayuno_hora!.hour}:${desayuno_hora!.minute}",
    "almuerzo_hora": "${almuerzo_hora!.hour}:${almuerzo_hora!.minute}",
    "cena_hora": "${cena_hora!.hour}:${cena_hora!.minute}",
    "desayuno": desayuno,
    "almuerzo": almuerzo,
    "cena": cena,
    "desayuno_saludable": desayuno_saludable,
    "almuerzo_saludable": almuerzo_saludable,
    "cena_saludable": cena_saludable,
    "usuario": usuario
  };

}
