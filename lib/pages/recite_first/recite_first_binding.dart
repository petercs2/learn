import 'package:get/get.dart';

import 'recite_first_logic.dart';

class ReciteFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReciteFirstLogic());
  }
}
