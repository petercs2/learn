import 'package:get/get.dart';

import 'preview_logic.dart';

class PreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreviewLogic());
  }
}
