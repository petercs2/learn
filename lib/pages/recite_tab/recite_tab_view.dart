import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recite_words/pages/recite_first/recite_first_logic.dart';
import 'package:recite_words/pages/recite_first/recite_first_view.dart';
import 'package:recite_words/pages/recite_second/recite_second_view.dart';
import 'package:recite_words/pages/recite_third/recite_third_view.dart';

import '../recite_second/recite_second_logic.dart';
import '../recite_third/recite_third_logic.dart';
import 'recite_tab_logic.dart';

class ReciteTabPage extends GetView<ReciteTabLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [ReciteFirstPage(), ReciteSecondPage(), ReciteThirdPage()],
      ),
      bottomNavigationBar: Obx(() => _navReciteBars()),
    );
  }

  Widget _navReciteBars() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Get.bottomBarHeight / 2),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/item0.webp',
                width: 35,
                height: 34,
                fit: BoxFit.cover,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/item1.webp',
                width: 38,
                height: 32.5,
                fit: BoxFit.cover,
              ),
              label: 'Achievements',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/item2.webp',
                width: 38,
                height: 36,
                fit: BoxFit.cover,
              ),
              label: 'Mine',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.currentIndex.value = index;
            controller.pageController.jumpToPage(index);
            if (index == 0) {
              ReciteFirstLogic firstLogic = Get.put(ReciteFirstLogic());
              firstLogic.startTimer();
            } else if (index == 1) {
              ReciteSecondLogic secondLogic = Get.put(ReciteSecondLogic());
              secondLogic.getData();
            } else if (index == 2) {
              ReciteThirdLogic thirdLogic = Get.put(ReciteThirdLogic());
              thirdLogic.getData();
            }
          },
        ),
      ),
    );
  }
}
