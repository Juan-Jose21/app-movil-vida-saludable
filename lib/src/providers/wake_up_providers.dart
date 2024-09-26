import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:app_vida_saludable/src/models/wake_up_models.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/response_api.dart';

class Wake_upProviders extends GetConnect {

  String url = '${Environment.API_URL}habits';
  String urlR = '${Environment.API_URL}reports';

  Future<ResponseApi> create(Wake_up wake_up) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> wake_upJson = {
      'fecha': dateFormat.format(wake_up.fecha!),
      'hora': timeFormat.format(DateTime(2000, 1, 1, wake_up.hora!.hour, wake_up.hora!.minute)),
      'estado': wake_up.estado,
      'usuario': wake_up.usuario
    };

    Response response = await post(
      '${url}/despertares/',
      jsonEncode(wake_upJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> datosEstadisticosD(String? user_id) async {
    try {
      print('${urlR}/reporte-descanso-porcentaje/$user_id/');
      final response = await get(
        '${urlR}/reporte-descanso-porcentaje/$user_id/',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas Descanso: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas Descanso: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas Descanso: $e');
      throw Exception('Error en la solicitud de estadísticas Descanso: $e');
    }
  }
}
