import 'package:get/get.dart';

import 'recite_third_logic.dart';

class ReciteThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReciteThirdLogic());
  }
}
