import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:app_vida_saludable/src/models/wake_up_models.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/response_api.dart';

class Wake_upProviders extends GetConnect {

  String url = Environment.API_URL + 'api/wake_up';

  Future<ResponseApi> create(Wake_up wake_up) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> wake_upJson = {
      'fecha': dateFormat.format(wake_up.fecha!),
      'hora': timeFormat.format(DateTime(2000, 1, 1, wake_up.hora!.hour, wake_up.hora!.minute)),
      'estado': wake_up.estado,
      'user_id': wake_up.user_id
    };

    Response response = await post(
      '$url/create',
      jsonEncode(wake_upJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> datosEstadisticosD(String? user_id) async {
    try {
      final response = await get(
        '$url/$user_id',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas Descanso: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas Descanso: $e');
      throw Exception('Error en la solicitud de estadísticas: $e');
    }
  }
}
