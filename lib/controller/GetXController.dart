import 'package:cms_flutter/model/DataInterfaceClass.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  var count = 0.obs;
  var userData = UserData();
  increment() {
    count++;
  }

  decrement() {
    count--;
  }


  updateUserData(UserData usr) {
    userData = usr;
  }
  String serverIP = 'http:/14.160.33.94:3007/api';
  void changeServerIP(String newIP) {
    serverIP = newIP;
  }

  String loggedinUser = '';
  void changeLoggedInUser(String newUser) {
    loggedinUser = newUser;
  }
}
