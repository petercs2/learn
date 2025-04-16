import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recite_words/db_recite/db_recite.dart';
import 'package:recite_words/db_recite/tts_config_init.dart';
import 'package:recite_words/pages/connect_failed/connect_failed_binding.dart';
import 'package:recite_words/pages/connect_failed/connect_failed_view.dart';
import 'package:recite_words/pages/feedback/feedback_binding.dart';
import 'package:recite_words/pages/feedback/feedback_view.dart';
import 'package:recite_words/pages/preview/preview_binding.dart';
import 'package:recite_words/pages/preview/preview_view.dart';
import 'package:recite_words/pages/recite_first/recite_first_binding.dart';
import 'package:recite_words/pages/recite_first/recite_first_view.dart';
import 'package:recite_words/pages/recite_second/recite_second_binding.dart';
import 'package:recite_words/pages/recite_second/recite_second_view.dart';
import 'package:recite_words/pages/recite_setting/recite_setting_binding.dart';
import 'package:recite_words/pages/recite_setting/recite_setting_view.dart';
import 'package:recite_words/pages/recite_tab/recite_tab_binding.dart';
import 'package:recite_words/pages/recite_tab/recite_tab_view.dart';
import 'package:recite_words/pages/recite_third/recite_third_binding.dart';
import 'package:recite_words/pages/recite_third/recite_third_view.dart';
import 'package:recite_words/pages/tts_init/tts_init_binding.dart';
import 'package:recite_words/pages/tts_init/tts_init_view.dart';

Color primaryColor = const Color(0xff34374c);
Color bgColor = const Color(0xfff5f7fb);

final achievements = [
  'The test',
  'The rise',
  'The glow',
  'Who are me',
  'Strongest'
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBRecite().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Words,
      initialRoute: '/tts_init',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Words = [
  GetPage(name: '/tts_init', page: () => const TtsInitView(), binding: TtsInitBinding()),
  GetPage(name: '/first', page: () => const ReciteFirstPage(), binding: ReciteFirstBinding()),
  GetPage(name: '/second', page: () => ReciteSecondPage(), binding: ReciteSecondBinding()),
  GetPage(name: '/third', page: () => ReciteThirdPage(), binding: ReciteThirdBinding()),
  GetPage(name: '/tts_config_init', page: () => const TtsConfigInit()),
  GetPage(name: '/tab', page: () => ReciteTabPage(), binding: ReciteTabBinding()),
  GetPage(name: '/setting', page: () => ReciteSettingPage(), binding: ReciteSettingBinding()),
  GetPage(name: '/preview', page: () => PreviewPage(), binding: PreviewBinding()),
  GetPage(name: '/feedback', page: () => FeedbackPage(), binding: FeedbackBinding()),
  GetPage(name: '/connect_failed', page: () => const ConnectFailedView(), binding: ConnectFailedBinding()),
];