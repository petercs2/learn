import 'package:get/get.dart';
import 'package:recite_words/pages/recite_first/recite_first_logic.dart';

import '../recite_second/recite_second_logic.dart';
import '../recite_third/recite_third_logic.dart';
import 'recite_tab_logic.dart';

class ReciteTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReciteTabLogic());
    Get.lazyPut(() => ReciteFirstLogic());
    Get.lazyPut(() => ReciteSecondLogic());
    Get.lazyPut(() => ReciteThirdLogic());
  }
}
