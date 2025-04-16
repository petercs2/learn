import 'package:get/get.dart';
import 'package:recite_words/db_recite/db_recite.dart';

import '../../db_recite/recite_entity.dart';

class ReciteSecondLogic extends GetxController {
  DBRecite dbRecite = Get.find();

  var list = <ReciteEntity>[].obs;



  getData() async {
    list.value = await dbRecite.getReciteAllData();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
