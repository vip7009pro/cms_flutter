import 'dart:async';

import 'package:get/get.dart';

class GlobalController extends GetxController {
  var count = 0.obs;

  increment() {
    count++;
  }

  decrement() {
    count--;
  }

/*   Timer mytimer =
      Timer.periodic(const Duration(minutes: 0, seconds: 2), (timer) {
    //code to run on every 2 minutes 5 seconds

    print('Chay dinh ky 5s 1 lan');
    print('______');
  }); */

  String loggedinUser = '';
  void changeLoggedInUser(String newUser) {
    loggedinUser = newUser;
  }
}
