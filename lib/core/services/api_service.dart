import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> post({
    required url,
    required body,
    String? token,
    String? contentType,
    Map<String, dynamic>? headers,
  }) async {
    var response = await _dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType,
        headers: headers ?? {'Authorization': "Bearer $token"},
      ),
    );
    return response;
  }
}
