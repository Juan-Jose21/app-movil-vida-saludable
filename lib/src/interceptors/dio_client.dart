import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../environment/environment.dart';
import '../models/user.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  static Dio get dio => _instance._dio;

  final Dio _dio;

  DioClient._internal()
      : _dio = Dio(BaseOptions(
    baseUrl: Environment.API_URL,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    validateStatus: (status) => status != null && status < 500,
  )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final storage = GetStorage();
        final userData = storage.read('User');

        if (userData != null) {
          final userDataMap = Map<String, dynamic>.from(userData);
          User userSession = User.fronJson(userDataMap);
          final accessToken = userSession.access;

          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
            // print("Token de acceso agregado en interceptor: $accessToken");
          } else {
            print("Token de acceso no encontrado en el almacenamiento.");
          }
        } else {
          print("Datos de usuario no encontrados en GetStorage.");
        }

        return handler.next(options); // Continuar con la solicitud
      },
      onResponse: (response, handler) {
        print("Código de respuesta: ${response.statusCode}");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          print("Error 401: No autorizado.");

          final storage = GetStorage();
          final userData = storage.read('User');

          if (userData != null) {
            final refreshToken = userData['refresh'];

            if (refreshToken != null) {
              try {
                final newToken = await _instance._refreshAccessToken(refreshToken);
                if (newToken != null) {
                  userData['access'] = newToken;
                  storage.write('User', userData);

                  final options = e.requestOptions;
                  options.headers['Authorization'] = 'Bearer $newToken';
                  final retryResponse = await _dio.fetch(options);
                  return handler.resolve(retryResponse);
                } else {
                  _handleAuthError();
                }
              } catch (refreshError) {
                _handleAuthError();
              }
            } else {
              print("No se encontró el refresh token.");
              _handleAuthError();
            }
          } else {
            print("Datos de usuario no encontrados en GetStorage.");
            _handleAuthError();
          }
        }
        return handler.next(e);
      },
    ));
  }

  factory DioClient() {
    return _instance;
  }

  // Ahora `_refreshAccessToken` es un método de instancia y puede usar `_dio`
  Future<String?> _refreshAccessToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        'token/refresh/',
        data: {'refresh': refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 && response.data['access'] != null) {
        print("Nuevo token de acceso recibido: ${response.data['access']}");
        return response.data['access'];
      } else {
        print("Error al refrescar el token: ${response.data}");
      }
    } catch (e) {
      print("Error al solicitar un nuevo token de acceso: $e");
    }
    return null;
  }

  static void _handleAuthError() {
    GetStorage().remove('User');
    Get.offAllNamed('/login');
    Get.snackbar(
      'Sesión expirada',
      'Por favor, inicia sesión nuevamente',
      backgroundColor: const Color(0xFFFF3B3B),
      colorText: const Color(0xFFFFFFFF),
      duration: const Duration(seconds: 3),
    );
  }
}
