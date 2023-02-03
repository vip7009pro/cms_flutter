import 'dart:convert';
import 'package:cms_flutter/model/UserData.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetWorkRequestAPI {
  static const String url = 'http://192.168.1.21:3007/api';
  static List<UserData> parseUserData(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<UserData> users =
        list.map((element) => UserData.fromJson(element)).toList();
    return users;
  }

  static Future<List<UserData>> fetchUserData({int page = 1}) async {
    Map<String, dynamic> bodyRequest = {
      'command': 'login2',
      'DATA': json.encode({'user': 'nhu1903', 'pass': 'dauxanhrauma'}),
    };

    var headers1 = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };

    final body = {
      'command': 'login2',
      'DATA': {'user': 'nhu1903', 'pass': 'dauxanhrauma'}
    };

    final response = await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: headers1);
    if (response.statusCode == 200) {
      print(response.body);
      return parseUserData(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get post');
    }
  }
}
