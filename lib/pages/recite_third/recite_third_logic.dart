import 'package:get/get.dart';
import 'package:recite_words/db_recite/db_recite.dart';

import '../../db_recite/recite_entity.dart';

class ReciteThirdLogic extends GetxController {

  DBRecite dbRecite = Get.find();

  List<ReciteEntity> list = [];

  int gridCount = 0;

  void getData() async {
    list = await dbRecite.getReciteAllData();
    final maxList = [10, 50, 99, 200, 500];
    if (list.length >= 10) {
      gridCount = 1;
    } else if (list.length >= 50) {
      gridCount = 2;
    } else if (list.length >= 99) {
      gridCount = 3;
    } else if (list.length >= 200) {
      gridCount = 4;
    } else if (list.length >= 500) {
      gridCount = 5;
    } else {
      gridCount = 0;
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
