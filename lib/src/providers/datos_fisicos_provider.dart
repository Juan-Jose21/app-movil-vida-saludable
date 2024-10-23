import 'dart:convert';
import 'package:get/get.dart';
import '../environment/environment.dart';
import '../models/datos_fisicos_model.dart';
import '../models/response_api.dart';
import 'package:http/http.dart' as http;

class DatosFisicosProviders extends GetConnect {
  String url = '${Environment.API_URL}health'; // Ajusta la ruta según tu API

  Future<ResponseApi> getAll(String userID) async {
    final String urlList = '$url/lista-datos-fisicos/$userID/';

    try {
      final response = await http.get(Uri.parse(urlList));
      print('Ruta: $urlList');
      print('Código de estado: ${response.statusCode}');

      if (response.statusCode != 200) {
        print('Error de conexión: ${response.statusCode}');
        return ResponseApi(
          success: false,
          message: 'Error de conexión: ${response.statusCode}',
        );
      }

      final responseBody = json.decode(response.body);
      List<dynamic> datosFisicosJson;
      print(responseBody);

      // Procesar la respuesta y extraer los datos
      if (responseBody is Map<String, dynamic> && responseBody['data'] != null) {
        datosFisicosJson = responseBody['data'] as List<dynamic>;
      } else if (responseBody is List) {
        datosFisicosJson = responseBody;
      } else {
        throw Exception('El formato de la respuesta no es compatible.');
      }

      // Convertir la lista de JSON a una lista de objetos DatosFisicos
      final List<DatosFisicos> datosFisicos =
      datosFisicosJson.map((json) => DatosFisicos.fromJson(json)).toList();

      return ResponseApi(
        success: true,
        data: datosFisicos,
      );
    } catch (e) {
      print('Error: $e'); // Imprimir el error para depuración
      return ResponseApi(
        success: false,
        message: 'Ocurrió un error inesperado: $e',
      );
    }
  }
}
