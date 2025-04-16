import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recite_words/pages/recite_second/second_item.dart';
import 'package:styled_widget/styled_widget.dart';

import 'recite_second_logic.dart';

class ReciteSecondPage extends GetView<ReciteSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: <Widget>[
        const Text(
          'Achievements',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ).marginOnly(left: 20),
        Expanded(
            child: GetBuilder<ReciteSecondLogic>(
                init: ReciteSecondLogic(),
                builder: (_) {
                  return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (_, index) {
                        final maxList = [10, 50, 99, 200, 500];
                        return SecondItem(maxList[index],
                            controller.list.value.length, index);
                      });
                }))
      ]
              .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
              .marginSymmetric(horizontal: 15)),
    );
  }
}
