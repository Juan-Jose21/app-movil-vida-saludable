import 'dart:convert';

import 'package:get/get.dart';
import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:intl/intl.dart';

import '../models/feeding_models.dart';
import '../models/response_api.dart';

class FeedingProviders extends GetConnect {
  String url = '${Environment.API_URL}api/feeding';

  Future<ResponseApi> create(Feeding feeding) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> feedingJson = {
      'fecha': dateFormat.format(feeding.fecha!),
      'hora': timeFormat.format(DateTime(2000, 1, 1, feeding.hora!.hour, feeding.hora!.minute)),
      'tipo_alimento': feeding.tipo_alimento,
      'saludable': feeding.saludable,
      'user_id': feeding.user_id,
    };

    try {
      final response = await post(
        '$url/create',
        feedingJson,
        headers: {'Content-Type': 'application/json'},
      );

      return ResponseApi.fromJson(response.body ?? '');
    } catch (e) {
      print('Error en la solicitud de creación: $e');
      throw Exception('Error en la solicitud de creación: $e');
    }
  }

  Future<ResponseApi> datosEstadisticos(String? user_id) async {
    try {
      final response = await get(
        '$url/$user_id',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas: $e');
      throw Exception('Error en la solicitud de estadísticas: $e');
    }
  }

  Future<ResponseApi> datosEstadisticosTipo(String? user_id, String? tipo_alimento) async {
    try {
      final response = await get(
        '$url/$user_id/$tipo_alimento',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas: $e');
      throw Exception('Error en la solicitud de estadísticas: $e');
    }
  }
}
