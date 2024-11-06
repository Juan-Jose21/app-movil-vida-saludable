import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:app_vida_saludable/src/models/exercise_models.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/response_api.dart';

class ExerciseProviders extends GetConnect {

  String url = '${Environment.API_URL}habits';
  String urlR = '${Environment.API_URL}reports';

  Future<ResponseApi> create(Exercise exercise) async {
    final dateFormat = DateFormat('yyyy-MM-dd');

    final Map<String, dynamic> exerciseJson = {
      'fecha': dateFormat.format(exercise.fecha!),
      'tipo': exercise.tipo,
      'tiempo': exercise.tiempo,
      'usuario': exercise.usuario
    };

    print('Json a enviar ${jsonEncode(exerciseJson)}');

    Response response = await post(
      '${url}/ejercicios/',
      jsonEncode(exerciseJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> datosEstadisticosE(String? user_id) async {
    try {
      print('${urlR}/reporte-ejercicio-porcentaje/$user_id/');
      final response = await get(
        '${urlR}/reporte-ejercicio-porcentaje/$user_id/',
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

  Future<ResponseApi> datosEjerciciosT(String? user_id) async {
    try {
      print('${urlR}/reporte-ejercicio/$user_id/');
      final response = await get(
        '${urlR}/reporte-ejercicio/$user_id/',
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

  Future<ResponseApi> datosEjerciciosTipo(String? user_id, String? tipo) async {
    try {
      print('datosEjerciciosTipo: ${urlR}/reporte-ejercicio-tipo/$user_id/$tipo/');
      final response = await get(
        '${urlR}/reporte-ejercicio-tipo/$user_id/$tipo/',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas E_Tipo: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas E_Tipo: $e');
      throw Exception('Error en la solicitud de estadísticas: $e');
    }
  }
}
