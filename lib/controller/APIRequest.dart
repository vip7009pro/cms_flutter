import 'dart:convert';
import 'dart:io';
import 'package:cms_flutter/controller/LocalDataAccess.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// ignore: camel_case_types
class API_Request {
  static Future<Map<String, dynamic>> api_query(
      String command, Map<String, dynamic> data) async {
    String url = '';
    url = await LocalDataAccess.getVariable('serverIP');
    if (url == '' || url == 'MAIN_SERVER') {
      url = 'http://14.160.33.94:5013/api';
    } else if (url == 'TEST_SERVER') {
      url = 'http://192.168.1.136:3007/api';
    } else {
      url = 'http://14.160.33.94:3007/api';
    }
    var dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 10000), // in ms
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 1000),
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        }));
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    String savedToken = await LocalDataAccess.getVariable("token");
    data['token_string'] = savedToken;
    final body = {'command': command, 'DATA': data};
    try {
      final response = await dio.post(url, data: jsonEncode(body));
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 404) {
        return {'tk_status': 'NG', 'message': 'Không tìm thấy dữ liệu'};
      } else {
        return {'tk_status': 'NG', 'message': 'Kết nối có vấn đề'};
      }
    } on DioException catch (e) {
      return {'tk_status': 'NG', 'message': '$e'};
    } catch (e) {
      return {'tk_status': 'NG', 'message': '$e'};
    }
  }
  static Future<Map<String, dynamic>> api_upload_query(
      String filepath, String filename, String uploadfoldername) async {
    String url = '';
    url = await LocalDataAccess.getVariable('serverIP');
    if (url == '' || url == 'MAIN_SERVER') {
      url = 'http://14.160.33.94:5013/uploadfile';
    } else if (url == 'TEST_SERVER') {
      url = 'http://192.168.1.136:3007/uploadfile';
    } else {
      url = 'http://14.160.33.94:3007/uploadfile';
    }
    var dio = Dio(BaseOptions(
        connectTimeout: const Duration(milliseconds: 10000), // in ms
        receiveTimeout: const Duration(milliseconds: 10000),
        sendTimeout: const Duration(milliseconds: 1000),
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        }));
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    String savedToken = await LocalDataAccess.getVariable("token");
    FormData body = FormData.fromMap({
      'uploadedfile':
          await MultipartFile.fromFile(filepath, filename: filename),
      'filename': filename,
      'uploadfoldername': uploadfoldername,
      'token_string': savedToken,
    });
    print(body.fields);
    final body2 = {
      'uploadedfile': '123456789',
      'filename': filename,
      'uploadfoldername': uploadfoldername,
      'token_string': savedToken,
    };
    try {
      final response = await dio.post(
        url,
        data: jsonEncode(body2),
        onSendProgress: (int sent, int total) {
          print('Uploading: $sent/$total');
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 404) {
        return {'tk_status': 'NG', 'message': 'Không tìm thấy dữ liệu'};
      } else {
        return {'tk_status': 'NG', 'message': 'Kết nối có vấn đề'};
      }
    } on DioException catch (e) {
      return {'tk_status': 'NG', 'message': '$e'};
    } catch (e) {
      return {'tk_status': 'NG', 'message': '$e'};
    }
  }
}
