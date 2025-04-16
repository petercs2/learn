import 'package:get/get.dart';

import 'tts_init_logic.dart';

class TtsInitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      TtsInitLogic(),
      permanent: true,
    );
  }
}
