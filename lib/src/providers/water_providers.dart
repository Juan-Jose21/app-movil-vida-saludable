import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:app_vida_saludable/src/models/water_models.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/response_api.dart';

class WaterProviders extends GetConnect {

  String url = Environment.API_URL + 'api/water';

  Future<ResponseApi> create(Water water) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> waterJson = {
      'fecha': dateFormat.format(water.fecha!),
      'hora': timeFormat.format(DateTime(2000, 1, 1, water.hora!.hour, water.hora!.minute)),
      'cantidad': water.cantidad,
      'user_id': water.user_id
    };

    Response response = await post(
      '$url/create',
      jsonEncode(waterJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> datosEstadisticosAgua(String? user_id) async {
    try {
      final response = await get(
        '$url/$user_id',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas Agua: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas Agua: $e');
      throw Exception('Error en la solicitud de estadísticas: $e');
    }
  }
}