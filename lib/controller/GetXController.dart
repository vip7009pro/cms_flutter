import 'package:get/get.dart';

class GlobalController extends GetxController {
  var count = 0.obs;
  increment() {
    count++;
  }

  decrement() {
    count--;
  }
}
