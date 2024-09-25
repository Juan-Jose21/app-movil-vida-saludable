import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:app_vida_saludable/src/models/sleep_models.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/response_api.dart';

class SleepProviders extends GetConnect {

  String url = Environment.API_URL + 'habits';

  Future<ResponseApi> create(Sleep sleep) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    final Map<String, dynamic> sleepJson = {
      'fecha': dateFormat.format(sleep.fecha!),
      'hora': timeFormat.format(DateTime(2000, 1, 1, sleep.hora!.hour, sleep.hora!.minute)),
      'usuario': sleep.usuario
    };

    Response response = await post(
      '$url/sleeps/',
      jsonEncode(sleepJson),
      headers: {'Content-Type': 'application/json'},
    );

    print('Lo que se envia ${sleepJson}');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
