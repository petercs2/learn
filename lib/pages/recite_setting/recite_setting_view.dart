import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'recite_setting_logic.dart';

class ReciteSettingPage extends GetView<ReciteSettingLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: <Widget>[
                const Text('Automatic word pronunciation'),
                Obx(() {
                  return Switch(
                      value: controller.isFirst.value,
                      activeTrackColor: Colors.blue,
                      onChanged: (v) async {
                        controller.isFirst.value = v;
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isFirst', v);
                      });
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: <Widget>[
                const Expanded(
                    child: Text('The sentence is pronounced automatically')),
                Obx(() {
                  return Switch(
                      value: controller.isSecond.value,
                      activeTrackColor: Colors.blue,
                      onChanged: (v) async {
                        controller.isSecond.value = v;
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isSecond', v);
                      });
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text('Feedback'),
            )
                .decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12))
                .gestures(onTap: () {
                  Get.toNamed('/feedback');
            }),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: <Widget>[
                const Text('Version'),
                const Text("1.0.0")
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            )
                .decorated(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)),
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
