import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> post({
    required url,
    required body,
    required token,
    String? contentType,
  }) async {
    var response = await _dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType,
        headers: {'Authorization': "Bearer $token"},
      ),
    );
    return response;
  }
}
