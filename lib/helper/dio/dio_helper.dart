import 'package:dio/dio.dart';
import 'package:movieapp/helper/constans/end_points.dart';

class DioHelper {
  static final dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
    ),
  );

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'Lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'Lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'Lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
