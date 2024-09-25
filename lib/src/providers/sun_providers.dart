import 'package:app_vida_saludable/src/environment/environment.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/response_api.dart';
import '../models/sun_models.dart';

class SunProviders extends GetConnect {

  String url = Environment.API_URL + 'habits';

  Future<ResponseApi> create(Sun sun) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    // final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> feedingJson = {
      'fecha': dateFormat.format(sun.fecha!),
      'tiempo': sun.tiempo,
      'usuario': sun.usuario
    };

    Response response = await post(
      '$url/soles/',
      jsonEncode(feedingJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> datosSol(String? user_id) async {
    try {
      final response = await get(
        '$url/$user_id',
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {

        final dynamic decodedBody = json.decode(response.bodyString ?? '');

        return ResponseApi.fromJsonDynamic(decodedBody);
      } else {
        print('Error en la solicitud de estadísticas Sol: ${response.statusCode}');
        throw Exception('Error en la solicitud de estadísticas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud de estadísticas Sol: $e');
      throw Exception('Error en la solicitud de estadísticas: $e');
    }
  }
}
