import 'package:app_vida_saludable/src/environment/environment.dart';
import 'package:get/get.dart';
import '../models/response_api.dart';

class LoginProviders extends GetConnect {

  String url = Environment.API_URL + 'api/users';

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login',
        {
          'email': email,
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
