import 'dart:convert';

import 'package:get/get.dart';
import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:intl/intl.dart';

import '../models/feeding_models.dart';
import '../models/response_api.dart';

class FeedingProviders extends GetConnect {
  String url = '${Environment.API_URL}habits';
  String urlR = '${Environment.API_URL}reports';

  Future<ResponseApi> createDesayuno(Feeding feeding) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> feedingJson = {
      'fecha': dateFormat.format(feeding.fecha!), // Formato correcto de fecha
      'desayuno_hora': timeFormat.format(DateTime(2000, 1, 1, feeding.desayuno_hora!.hour, feeding.desayuno_hora!.minute)), // Formato correcto de hora
      'desayuno': feeding.desayuno,
      'desayuno_saludable': feeding.desayuno_saludable,
      'usuario': feeding.usuario,
    };

    try {
      final response = await post(
        '${url}/alimentaciones/',
        jsonEncode(feedingJson), // Asegúrate de codificar el JSON correctamente
        headers: {'Content-Type': 'application/json'},
      );
      print('Json a enviar ${jsonEncode(feedingJson)}');
      if (response.status.hasError) {
        return Future.error('Error en la solicitud: ${response.statusText}');
      }

      return ResponseApi.fromJson(response.body); // Aquí se espera un Map<String, dynamic>
    } catch (e) {
      print('Error en la solicitud de creación: $e');
      throw Exception('Error en la solicitud de creación: $e');
    }
  }


  Future<ResponseApi> createAlmuerzo(Feeding feeding) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> feedingJson = {
      'fecha': dateFormat.format(feeding.fecha!),
      'almuerzo_hora': timeFormat.format(DateTime(2000, 1, 1, feeding.almuerzo_hora!.hour, feeding.almuerzo_hora!.minute)),
      'almuerzo': feeding.almuerzo,
      'almuerzo_saludable': feeding.almuerzo_saludable,
      'usuario': feeding.usuario,
    };
    print('Json a enviar ${jsonEncode(feedingJson)}');
    try {
      final response = await post(
        '${url}/alimentaciones/',
        jsonEncode(feedingJson),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.status.hasError) {
        return Future.error('Error en la solicitud: ${response.statusText}');
      }

      return ResponseApi.fromJson(response.body);
    } catch (e) {
      print('Error en la solicitud de creación: $e');
      throw Exception('Error en la solicitud de creación: $e');
    }
  }

  Future<ResponseApi> createCena(Feeding feeding) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> feedingJson = {
      'fecha': dateFormat.format(feeding.fecha!),
      'cena_hora': timeFormat.format(DateTime(2000, 1, 1, feeding.cena_hora!.hour, feeding.cena_hora!.minute)),
      'cena': feeding.cena,
      'cena_saludable': feeding.cena_saludable,
      'usuario': feeding.usuario,
    };
    print('Json a enviar ${jsonEncode(feedingJson)}');
    try {
      print('Json a enviar $feedingJson');
      final response = await post(
        '${url}/alimentaciones/',
        jsonEncode(feedingJson),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.status.hasError) {
        return Future.error('Error en la solicitud: ${response.statusText}');
      }

      return ResponseApi.fromJson(response.body); // Aquí se espera un Map<String, dynamic>
    } catch (e) {
      print('Error en la solicitud de creación: $e');
      throw Exception('Error en la solicitud de creación: $e');
    }
  }

  Future<ResponseApi> datosEstadisticos(String? user_id) async {
    try {
      if (user_id == null) {
        throw Exception('El ID de usuario no puede ser nulo');
      }
      print('${urlR}/reporte-alimentacion-porcentaje/$user_id/');
      final response = await get(
        '${urlR}/reporte-alimentacion-porcentaje/$user_id/',
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
      print('${urlR}/reporte-alimentacion-porcentaje-tipo/$user_id/$tipo_alimento/');
      final response = await get(
        '${urlR}/reporte-alimentacion-porcentaje-tipo/$user_id/$tipo_alimento',
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
