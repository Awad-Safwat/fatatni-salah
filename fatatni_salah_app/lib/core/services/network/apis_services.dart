import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  final String baseUrl = 'https://api.aladhan.com/v1/calendar';

  ApiService({required Dio dio}) : _dio = dio;

  Future<Map<String, dynamic>> get({
    required Map<String, dynamic> params,
  }) async {
    // print('$baseUrl$endPoint');
    var response = await _dio.get(baseUrl, queryParameters: params);
    return response.data;
  }

  // Future<Map<String, dynamic>> getCurrentLocation() async {
  //   var response = await _dio.get("http://ip-api.com/json");
  //   return response.data;
  // }
}
