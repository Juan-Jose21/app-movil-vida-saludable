import 'dart:convert';

class ResponseApi {
  bool? success;
  String? message;
  dynamic data;

  ResponseApi({
    this.success,
    this.message,
    this.data,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) {
    return ResponseApi(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  static ResponseApi fromJsonDynamic(dynamic json) {
    if (json is Map<String, dynamic>) {
      return ResponseApi.fromJson(json);
    } else if (json is List<dynamic>) {
      return ResponseApi(success: true, data: json); // Manejar listas de datos aquí
    } else {
      throw Exception('Invalid format for ResponseApi');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}
