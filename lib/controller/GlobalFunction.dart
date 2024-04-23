import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  static String convertVietnameseString(String input) {
  const Map<String, String> vietnameseCharacters = {
    'á': 'a', 'à': 'a', 'ả': 'a', 'ã': 'a', 'ạ': 'a',
    'â': 'a', 'ấ': 'a', 'ầ': 'a', 'ẩ': 'a', 'ẫ': 'a', 'ậ': 'a',
    'ă': 'a', 'ắ': 'a', 'ằ': 'a', 'ẳ': 'a', 'ẵ': 'a', 'ặ': 'a',
    'é': 'e', 'è': 'e', 'ẻ': 'e', 'ẽ': 'e', 'ẹ': 'e',
    'ê': 'e', 'ế': 'e', 'ề': 'e', 'ể': 'e', 'ễ': 'e', 'ệ': 'e',
    'í': 'i', 'ì': 'i', 'ỉ': 'i', 'ĩ': 'i', 'ị': 'i',
    'ó': 'o', 'ò': 'o', 'ỏ': 'o', 'õ': 'o', 'ọ': 'o',
    'ô': 'o', 'ố': 'o', 'ồ': 'o', 'ổ': 'o', 'ỗ': 'o', 'ộ': 'o',
    'ơ': 'o', 'ớ': 'o', 'ờ': 'o', 'ở': 'o', 'ỡ': 'o', 'ợ': 'o',
    'ú': 'u', 'ù': 'u', 'ủ': 'u', 'ũ': 'u', 'ụ': 'u',
    'ư': 'u', 'ứ': 'u', 'ừ': 'u', 'ử': 'u', 'ữ': 'u', 'ự': 'u',
    'ý': 'y', 'ỳ': 'y', 'ỷ': 'y', 'ỹ': 'y', 'ỵ': 'y',
  };
  return input.split('').map((char) => vietnameseCharacters[char] ?? char).join();
}
static String MyDate(String format, String datetimedata) {
  if(datetimedata == null)  
  return "";
  return DateFormat(format).format(DateTime.parse(datetimedata));
}
}
bool CheckPermission(UserData userData, List<String> permitted_main_dept,
    List<String> permitted_position, List<String> permitted_empl, void func()) {
  bool check = false;
  if (userData.eMPLNO == 'NHU1903') {
    func();
    check = true;
  } else {
    if (permitted_main_dept.contains('ALL')) {
      if (permitted_position.contains('ALL')) {
        if (permitted_empl.contains('ALL')) {
          func();
          check = true;
        } else {
          if (permitted_empl.contains(userData.eMPLNO)) {
            check = true;
            func();
          }
        }
      } else {
        if (permitted_position.contains(userData.pOSITIONNAME)) {
          check = true;
          func();
        }
      }
    } else {
      if (permitted_main_dept.contains(userData.mAINDEPTNAME)) {
        check = true;
        func();
      }
    }
  }
  return check;
}
