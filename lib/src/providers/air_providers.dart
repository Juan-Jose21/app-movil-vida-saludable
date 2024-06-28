import 'package:app_vida_saludable/src/environment/environment.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/air_models.dart';
import '../models/response_api.dart';

class AirProviders extends GetConnect {

  String url = Environment.API_URL + 'api/air';

  Future<ResponseApi> create(Air air) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    // final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> feedingJson = {
      'fecha': dateFormat.format(air.fecha!),
      'tiempo': air.tiempo,
      'user_id': air.user_id,
      // 'hora_inicio': timeFormat.format(DateTime(2000, 1, 1, air.hora_inicio!.hour, air.hora_inicio!.minute)),
      // 'hora_fin': timeFormat.format(DateTime(2000, 1, 1, air.hora_fin!.hour, air.hora_fin!.minute)),
    };

    Response response = await post(
      '$url/create',
      jsonEncode(feedingJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> datosEstadisticosAire(String? user_id) async {
    try {
      final response = await get(
        '$url/$user_id',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas Aire: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas Aire: $e');
      throw Exception('Error en la solicitud de estadísticas: $e');
    }
  }
}
