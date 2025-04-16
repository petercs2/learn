
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recite_words/pages/feedback/recite_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';
import 'feedback_logic.dart';

class FeedbackPage extends GetView<FeedbackLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<FeedbackLogic>(builder: (_) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            width: double.infinity,
                            height: 180,
                            child: controller.image == null
                                ? <Widget>[
                              Icon(
                                Icons.add_box,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                              const Text(
                                'Add image',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              )
                            ].toColumn(
                                mainAxisAlignment: MainAxisAlignment.center)
                                : Image.memory(
                              controller.image!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ))
                            .decorated(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)).gestures(
                            onTap: () {
                              controller.imageSelected();
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: ReciteTextField(
                            hintText: 'Please enter your feedback',
                            maxLines: 8,
                            maxLength: 500,
                            onChange: (value) {
                              controller.content = value;
                            }),
                      ).decorated(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Commit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                          .decorated(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10))
                          .gestures(onTap: () {
                        controller.commit(context);
                      })
                    ].toColumn(),
                  ).decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10))
                ].toColumn(),
              );
            }).marginAll(15)),
      ),
    );
  }
}
