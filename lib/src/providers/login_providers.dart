import 'dart:async';
import 'dart:convert'; // Para manejar JSON
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http; // Paquete HTTP
import 'package:app_vida_saludable/src/environment/environment.dart';
import '../models/response_api.dart';

class LoginProviders extends GetConnect {

  String url = '${Environment.API_URL}login/';

  Future<ResponseApi> login(String correo, String password) async {
    print('$url');
    Response response = await post(
        '${url}',
        {
          'correo': correo,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json'
        }
    );

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la ejecution');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}

