import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:app_vida_saludable/src/models/exercise_models.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/response_api.dart';

class ExerciseProviders extends GetConnect {

  String url = Environment.API_URL + 'habits';

  Future<ResponseApi> create(Exercise exercise) async {
    final dateFormat = DateFormat('yyyy-MM-dd');

    final Map<String, dynamic> exerciseJson = {
      'fecha': dateFormat.format(exercise.fecha!),
      'tipo': exercise.tipo,
      'tiempo': exercise.tiempo,
      'usuario': exercise.usuario
    };

    Response response = await post(
      '$url/ejercicios/',
      jsonEncode(exerciseJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> datosEstadisticosE(String? user_id) async {
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

  Future<ResponseApi> datosEjerciciosT(String? user_id) async {
    try {
      final response = await get(
        '$url/tiempo/$user_id',
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
      final response = await get(
        '$url/tipo/$user_id/$tipo',
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
