import 'package:get/get.dart';

import 'recite_second_logic.dart';

class ReciteSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReciteSecondLogic());
  }
}
