import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tts_init_logic.dart';

class TtsInitView extends GetView<TtsInitLogic> {
  const TtsInitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.steuber.value
              ? CircularProgressIndicator(color: Colors.blue[300])
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.hlkotsd();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
