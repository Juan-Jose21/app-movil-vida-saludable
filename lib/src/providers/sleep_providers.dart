import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:app_vida_saludable/src/models/sleep_models.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/response_api.dart';

class SleepProviders extends GetConnect {

  String url = '${Environment.API_URL}habits';
  String urlR = '${Environment.API_URL}reports';


  Future<ResponseApi> create(Sleep sleep) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> sleepJson = {
      'fecha': dateFormat.format(sleep.fecha!),
      'hora': timeFormat.format(DateTime(2000, 1, 1, sleep.hora!.hour, sleep.hora!.minute)),
      'usuario': sleep.usuario
    };

    Response response = await post(
      '${url}/sleeps/',
      jsonEncode(sleepJson),
      headers: {'Content-Type': 'application/json'},
    );

    print('Lo que se envia ${sleepJson}');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> datosDescansoHorasT(String? user_id) async {
    try {
      if (user_id == null) {
        throw Exception('El ID de usuario no puede ser nulo');
      }
      print('${urlR}/reporte-descanso/$user_id/');
      final response = await get(
        '${urlR}/reporte-descanso/$user_id/',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic decodedBody = json.decode(response.bodyString ?? '');
        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas Descanso Horas: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas Descanso Horas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas Descanso Horas: $e');
      throw Exception('Error en la solicitud de estadísticas Descanso Horas: $e');
    }
  }

}
