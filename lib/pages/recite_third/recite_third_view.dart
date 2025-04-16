import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recite_words/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'recite_third_logic.dart';

class ReciteThirdPage extends GetView<ReciteThirdLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const SizedBox(
          width: double.infinity,
          height: double.infinity,
        ),
        Image.asset(
          'assets/mineBG.webp',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Positioned(
            top: 95,
            left: 15,
            child: <Widget>[
              // Image.asset(
              //   'assets/head.webp',
              //   width: 55,
              //   height: 55,
              //   fit: BoxFit.cover,
              // ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Learn a little every day',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ].toRow()),
        Positioned(
            top: 60,
            right: 30,
            child:const Icon(
              Icons.settings,
              size: 25,
              color: Colors.white,
            ).gestures(onTap: (){
              Get.toNamed('/setting')?.then((_) {
                controller.getData();
              });
            })),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: GetBuilder<ReciteThirdLogic>(
              init: ReciteThirdLogic(),
              builder: (_) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      child: <Widget>[
                        <Widget>[
                          Container(
                            width: 8,
                            height: 2,
                          ).decorated(color: Colors.grey),
                          const Text(
                            'Get achievements',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            width: 8,
                            height: 2,
                          ).decorated(color: Colors.grey),
                        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
                        const SizedBox(
                          height: 20,
                        ),
                        controller.gridCount == 0
                            ? const Center(
                                child: Text('No data'),
                              )
                            : GridView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10),
                                itemCount: controller.gridCount,
                                itemBuilder: (_, index) {
                                  return <Widget>[
                                    Image.asset(
                                      'assets/achievements$index.webp',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      achievements[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ].toColumn();
                                })
                      ].toColumn(),
                    ).decorated(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            child: <Widget>[
                              <Widget>[
                                const Text(
                                  'Cumulative word count',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  'The cumulative progress is${controller.list.length / 500}%',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                )
                              ].toColumn(
                                  crossAxisAlignment: CrossAxisAlignment.start),
                              <Widget>[
                                Text(
                                  controller.list.length.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff02bfc0),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text('Entries')
                              ].toRow(mainAxisAlignment: MainAxisAlignment.end)
                            ].toRow(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween))
                        .decorated(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20))
                  ].toColumn(),
                );
              }).marginAll(15),
        ).marginOnly(top: 170)
      ].toStack(),
    );
  }
}
