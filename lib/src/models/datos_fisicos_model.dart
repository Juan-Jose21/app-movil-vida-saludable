// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

DatosFisicos datosFisicosFromJson(String str) => DatosFisicos.fromJson(json.decode(str));

String datosFisicosToJson(DatosFisicos data) => json.encode(data.toJson());

class DatosFisicos {
  double? peso;
  int? altura;  // Ahora representará altura en cm
  double? imc;
  double? radio_abdominal;
  double? grasa_corporal;
  double? grasa_visceral;
  double? porcentaje_musculo;
  DateTime? fecha;
  String? tipo;
  String? usuario;

  DatosFisicos({
    this.peso,
    this.altura,
    this.imc,
    this.radio_abdominal,
    this.grasa_corporal,
    this.grasa_visceral,
    this.porcentaje_musculo,
    this.fecha,
    this.tipo,
    this.usuario,
  });

  factory DatosFisicos.fromJson(Map<String, dynamic> json) => DatosFisicos(
    peso: (json['peso'] is String)
        ? double.tryParse(json['peso'])
        : (json['peso'] as num?)?.toDouble(),
    altura: json['altura'] as int?, // Altura en cm
    imc: (json['imc'] is String)
        ? double.tryParse(json['imc'])
        : (json['imc'] as num?)?.toDouble(),
    radio_abdominal: (json['radio_abdominal'] is String)
        ? double.tryParse(json['radio_abdominal'])
        : (json['radio_abdominal'] as num?)?.toDouble(),
    grasa_corporal: (json['grasa_corporal'] is String)
        ? double.tryParse(json['grasa_corporal'])
        : (json['grasa_corporal'] as num?)?.toDouble(),
    grasa_visceral: (json['grasa_visceral'] is String)
        ? double.tryParse(json['grasa_visceral'])
        : (json['grasa_visceral'] as num?)?.toDouble(),
    porcentaje_musculo: (json['porcentaje_musculo'] is String)
        ? double.tryParse(json['porcentaje_musculo'])
        : (json['porcentaje_musculo'] as num?)?.toDouble(),
    fecha: DateTime.tryParse(json['fecha'] as String? ?? ''),
    tipo: json["tipo"].toString(),
    usuario: json["usuario"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "peso": peso,
    "altura": altura,  // Altura en cm
    "imc": imc,
    "radio_abdominal": radio_abdominal,
    "grasa_corporal": grasa_corporal,
    "grasa_visceral": grasa_visceral,
    "porcentaje_musculo": porcentaje_musculo,
    "fecha": fecha?.toIso8601String(),
    "tipo": tipo,
    "usuario": usuario,
  };
}
