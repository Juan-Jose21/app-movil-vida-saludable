import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:get/get.dart';
import '../models/response_api.dart';

class LoginProviders extends GetConnect {

  String url = Environment.API_URL + 'login/';

  Future<ResponseApi> login(String correo, String password) async {
    try {
      final response = await post(
        url,
        {
          'correo': correo,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.status.hasError) {
        return ResponseApi(
          success: false,
          message: 'Error de conexión: ${response.statusText}',
        );
      }

      final responseBody = response.body;
      if (responseBody == null) {
        Get.snackbar('Error', 'No se pudo ejecutar la solicitud');
        return ResponseApi();
      }

      ResponseApi responseApi = ResponseApi.fromJson(responseBody);
      return responseApi;
    } catch (e) {
      return ResponseApi(
        success: false,
        message: 'Ocurrió un error inesperado: $e',
      );
    }
  }
}
