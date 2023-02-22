import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class API_Request {
  static const String url = 'http://14.160.33.94:3007/api';

  static Future<dynamic> api_query(String command, dynamic data) async {
    var dio = Dio(BaseOptions(
        connectTimeout: 10000, // in ms
        receiveTimeout: 10000,
        sendTimeout: 10000,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        }));
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    final body = {'command': command, 'token_string': '', 'DATA': data};
    final response = await dio.post(url, data: jsonEncode(body));
    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get post');
    }
  }
}