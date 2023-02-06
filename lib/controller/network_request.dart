import 'dart:convert';
import 'package:cms_flutter/model/UserData.dart';
import 'package:http/http.dart' as http;

class NetWorkRequestAPI {
  static const String url = 'http://14.160.33.94:3007/api';
  static var headers1 = {
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  static List<UserData> parseUserData(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<UserData> users =
        list.map((element) => UserData.fromJson(element)).toList();
    return users;
  }

  static Future<dynamic> generalQuery(String command, dynamic data) async {
    final body = {'command': command, 'DATA': data};
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: headers1);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get post');
    }
  }
}
