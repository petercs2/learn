import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recite_words/db_recite/db_recite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'recite_first_logic.dart';

class ReciteFirstPage extends StatefulWidget {
  const ReciteFirstPage({Key? key}) : super(key: key);

  @override
  State<ReciteFirstPage> createState() => _ReciteFirstPageState();
}

class _ReciteFirstPageState extends State<ReciteFirstPage> {
  ReciteFirstLogic controller = Get.find();

  final FlutterTts flutterTts = FlutterTts();

  Future _speak(String text) async {
    final result = await flutterTts.speak(text);
    if (result == 1) setState(() => controller.isPlay == true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => controller.isPlay == false);
  }

  Widget _buildHighlightedSentence(String sentence, String targetWord) {
    final words = sentence.split(' ');
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black54),
        children: words.map((word) {
          final cleanWord = word.replaceAll(RegExp(r'[^\w]'), '');
          return TextSpan(
            text: '$word ',
            style: TextStyle(
              color: cleanWord.toLowerCase() == targetWord.toLowerCase()
                  ? const Color(0xffff6685)
                  : Colors.black,
              fontWeight: cleanWord.toLowerCase() == targetWord.toLowerCase()
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _initTTS() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage('en-US');
    flutterTts.setErrorHandler((msg) {
      // print("TTS Error: $msg");
    });

    Future.delayed(const Duration(seconds: 2), () async {
      DBRecite dbRecite = Get.find();
      final result = await dbRecite.getReciteAllData();
      final now = DateTime.now();
      bool todayDone = false;
      for (var element in result) {
        if (DateFormat('MM/dd/yyyy').format(element.createdTime) ==
            DateFormat('MM/dd/yyyy').format(now)) {
          todayDone = true;
          break;
        }
      }
      if (todayDone) {
        return;
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? isFirst = prefs.getBool('isFirst');
      final bool? isSecond = prefs.getBool('isSecond');
      if (isFirst == true) {
        await _speak(controller.currentWord!.word);
        controller.isPlay = false;
      }
      if (isSecond == true) {
        await _speak(controller.currentWord!.sentences[0][0]);
        await _speak(controller.currentWord!.sentences[1][0]);
        controller.isPlay = false;
      }
      controller.update();
    });
  }

  @override
  void initState() {
    super.initState();
    _initTTS();
  }

  Widget _buildWordPage() {
    if (controller.emptyPage) {
      return <Widget>[
        <Widget>[
          Container(
            width: 8,
            height: 2,
          ).decorated(color: Colors.grey),
          const Text('Update countdown'),
          Container(
            width: 8,
            height: 2,
          ).decorated(color: Colors.grey),
        ].toRow(mainAxisAlignment: MainAxisAlignment.center),
        const SizedBox(
          height: 30,
        ),
        Obx(() {
          return Text(
            controller.downTimeStr.value,
            style: const TextStyle(
                fontSize: 53, fontWeight: FontWeight.bold, color: Colors.grey),
          );
        }),
        const SizedBox(
          height: 60,
        ),
        Container(
          width: 150,
          height: 48,
          alignment: Alignment.center,
          child: const Text(
            'Back to today',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ).decorated(color: const Color(0xff5b7cfe),
            borderRadius: BorderRadius.circular(24)).gestures(onTap: () {
          controller.emptyPage = false;
          controller.update();
        })
      ].toColumn();
    }
    return <Widget>[
      <Widget>[
        Expanded(
            child: <Widget>[
              Text(
                controller.currentWord!.word,
                style: const TextStyle(
                    fontSize: 36, fontWeight: FontWeight.bold),
              ),
              <Widget>[
                Image.asset(
                  'assets/voice.webp',
                  width: 15,
                  height: 15,
                  fit: BoxFit.cover,
                ).gestures(onTap: () async {
                  await _stop();
                  await _speak(controller.currentWord!.word);
                  await flutterTts.awaitSpeakCompletion(true);
                  controller.isPlay = false;
                  controller.playCount += 1;
                  controller.addData();
                  controller.update();
                }),
                const SizedBox(width: 7),
                const Text(
                  'America',
                  style: TextStyle(
                      fontSize: 15, color: Colors.black54),
                ),
                const SizedBox(width: 7),
                Text(
                  controller.currentWord!.phonetic,
                  style: const TextStyle(
                      fontSize: 15, color: Color(0xff8a8a8a)),
                )
              ].toRow(),
              const SizedBox(
                height: 20,
              ),
              Text(
                controller
                    .currentWord!.noun[controller.languageType],
                style: const TextStyle(
                    fontSize: 15, color: Colors.black87),
              ),
              Text(
                controller
                    .currentWord!.verb[controller.languageType],
                style: const TextStyle(
                    fontSize: 15, color: Colors.black87),
              ),
            ].toColumn(
                crossAxisAlignment:
                CrossAxisAlignment.start)),
        Image.asset(
          'assets/bgPlay.webp',
          width: 124,
          height: 111,
          fit: BoxFit.cover,
        ),
      ].toRow(),
      const SizedBox(
        height: 25,
      ),
      <Widget>[
        const Text(
          'Example sentence',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold),
        ),
        <Widget>[
          Text(
            controller.languageStr.value,
            style: const TextStyle(
                color: Colors.black87, fontSize: 15),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 25,
            color: Colors.black87,
          )
        ].toRow().gestures(onTap: () {
          controller.selectedLanguage();
        })
      ].toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween),
      <Widget>[
        Image.asset(
          'assets/voice.webp',
          width: 15,
          height: 15,
          fit: BoxFit.cover,
        ).gestures(onTap: () async {
          await _stop();
          await _speak(
              controller.currentWord!.sentences[0][0]);
          await flutterTts.awaitSpeakCompletion(true);
          controller.isPlay = false;
          controller.playCount += 1;
          controller.addData();
          controller.update();
        }),
        const SizedBox(width: 7),
        Expanded(
            child: _buildHighlightedSentence(
                controller.currentWord!.sentences[0][0],
                controller.currentWord!.word))
      ].toRow(),
      Text(
        controller.currentWord!.sentences[0]
        [controller.languageType],
        style: const TextStyle(color: Colors.grey),
      ),
      const SizedBox(
        height: 20,
      ),
      <Widget>[
        Image.asset(
          'assets/voice.webp',
          width: 15,
          height: 15,
          fit: BoxFit.cover,
        ).gestures(onTap: () async {
          await _stop();
          await _speak(
              controller.currentWord!.sentences[1][0]);
          await flutterTts.awaitSpeakCompletion(true);
          controller.isPlay = false;
          controller.playCount += 1;
          controller.addData();
          controller.update();
        }),
        const SizedBox(width: 7),
        Expanded(
            child: _buildHighlightedSentence(
                controller.currentWord!.sentences[1][0],
                controller.currentWord!.word))
      ].toRow(),
      Text(
        controller.currentWord!.sentences[1]
        [controller.languageType],
        style: const TextStyle(color: Colors.grey),
      )
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<ReciteFirstLogic>(builder: (_) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: <Widget>[
                  <Widget>[
                    Obx(() {
                      return Text(
                        controller.hmdStr.value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    }),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Obx(() {
                        return Text(
                          controller.weekdayStr.value,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        );
                      }),
                    )
                  ].toRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: controller.currentWord == null
                        ? null
                        : _buildWordPage(),
                  ).decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.17),
                            blurRadius: 14.5,
                            offset: const Offset(0, 1))
                      ])
                ].toColumn(),
              );
            }).marginAll(15)),
      ),
    );
  }
}
