import 'dart:convert';
import 'dart:io';

import 'package:cms_flutter/controller/GetXController.dart';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';

class API_Request {
  /* static const String url = 'http://14.160.33.94:3007/api';
 */

  static Future<dynamic> api_query(String command, dynamic data) async {
    String url = '';
    url = await LocalDataAccess.getVariable('serverIP');
    if (url == '' || url == 'MAIN_SERVER') {
      url = 'http://14.160.33.94:5011/api';
    } else if (url == 'TEST_SERVER') {
      url = 'http://localhost:3007/api';
    } else {
      url = 'http://14.160.33.94:3007/api';
    }
    var dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 10000), // in ms
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 10000),
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
