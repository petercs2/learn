import 'package:get/get.dart';

import 'recite_setting_logic.dart';

class ReciteSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReciteSettingLogic());
  }
}
