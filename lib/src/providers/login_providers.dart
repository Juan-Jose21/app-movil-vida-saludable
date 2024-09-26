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

// class LoginProviders {
//
//   String url = Environment.API_URL+'login/';
//
//   Future<ResponseApi> login(String correo, String password) async {
//     try {
//       // Preparamos el cuerpo de la solicitud
//       final body = jsonEncode({
//         'correo': correo,
//         'password': password
//       });
//
//       // Realizamos la solicitud POST
//       final response = await http.post(
//         Uri.parse(url), // Convertimos la URL a Uri
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: body,
//       ).timeout(Duration(seconds: 30), onTimeout: () {
//         throw TimeoutException('La solicitud tardó demasiado tiempo');
//       });
//
//       // Verificamos si hay un error en la respuesta
//       if (response.statusCode != 200) {
//         return ResponseApi(
//           success: false,
//           message: 'Error de conexión: ${response.reasonPhrase}',
//         );
//       }
//
//       // Convertimos la respuesta a JSON
//       final responseBody = jsonDecode(response.body);
//
//       if (responseBody == null) {
//         return ResponseApi(
//           success: false,
//           message: 'No se pudo ejecutar la solicitud',
//         );
//       }
//
//       // Mapeamos el JSON a ResponseApi
//       ResponseApi responseApi = ResponseApi.fromJson(responseBody);
//       return responseApi;
//     } catch (e) {
//       return ResponseApi(
//         success: false,
//         message: 'Ocurrió un error inesperado: $e',
//       );
//     }
//   }
// }
