import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:app_vida_saludable/src/models/hope_models.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/response_api.dart';

class HopeProviders extends GetConnect {

  String url = '${Environment.API_URL}habits';
  String urlR = '${Environment.API_URL}reports';

  Future<ResponseApi> create(Hope hope) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    // final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> hopeJson = {
      'fecha': dateFormat.format(hope.fecha!),
      'tipo_practica': hope.tipo_practica,
      'usuario': hope.usuario
    };

    Response response = await post(
      '${url}/esperanzas/',
      jsonEncode(hopeJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }


  Future<ResponseApi> datosEstadisticosHope(String? user_id) async {
    try {
      final response = await get(
        '${urlR}/reporte-esperanza/$user_id/',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas Esperanza: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas Esperanza: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas Esperanza: $e');
      throw Exception('Error en la solicitud de estadísticas Esperanza: $e');
    }
  }
}
