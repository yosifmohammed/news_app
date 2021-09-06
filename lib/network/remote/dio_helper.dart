import 'package:dio/dio.dart';
import 'package:news/constants/strings.dart';

class DioHelper{

  static late Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> getData({
    required Map<String, dynamic> query,
    required String url,
  }) async
  {
    return await dio.get(url, queryParameters: query);
  }
}