import 'package:get/get.dart';

import 'connect_failed_logic.dart';

class ConnectFailedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConnectFailedLogic());
  }
}
