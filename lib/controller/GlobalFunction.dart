import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalFunction {  

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', 'reset');
  }
  static void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text('$message '),
      action:
          SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
