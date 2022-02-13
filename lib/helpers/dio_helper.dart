import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) {
    return dio.get(
      url,
      queryParameters: query,
    );
  }
}
