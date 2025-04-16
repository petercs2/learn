import 'dart:async';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recite_words/db_recite/db_recite.dart';
import 'package:recite_words/db_recite/recite_entity.dart';

class ReciteFirstLogic extends GetxController {
  Timer? _timer;

  int languageType = 0;
  var languageStr = 'English'.obs;

  final weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final allWords = [
    Word(word: 'Implement', phonetic: '/ˈɪmplɪment/', noun: [
      'n. tool',
      'n. Alat, perkakas,',
      'n. 工具，器具',
      'n. Инструменты.'
    ], verb: [
      'v. implement',
      'v. Pelaksanaan, Pelaksanaan',
      'v. 實施，執行',
      'v. Осуществление, осуществление'
    ], sentences: [
      [
        'We need to implement the new policy immediately.',
        'Kita perlu melaksanakan dasar baharu dengan segera.',
        '我們需要立即實施新政策。',
        'Мы должны немедленно приступить к осуществлению новой политики.'
      ],
      [
        'The kitchen implement was very useful.',
        'Alat dapur sangat berguna.',
        '這個廚具很有用。',
        'Кухонные принадлежности были очень полезны.'
      ]
    ]),
    Word(
      word: 'Resolve',
      phonetic: '/rɪˈzɑːlv/',
      noun: ['n. determination', 'n. Resolusi', 'n. 決心', 'n. решительн'],
      verb: ['v. Work out', 'v. Menyelesaikan', 'v. 解決', 'v. реш'],
      sentences: [
        [
          'She showed great resolve in difficult situations.',
          'Dia menunjukkan keazaman yang tinggi dalam situasi yang sukar.',
          '她在困境中表現出極大的決心。',
          'Она проявила большую решимость в сложных ситуациях.'
        ],
        [
          'The committee will resolve this issue soon.',
          'Jawatankuasa akan menyelesaikan isu ini tidak lama lagi.',
          '委員會將很快解決這個問題。',
          'Комитет вскоре решит этот вопрос.'
        ]
      ],
    ),
    Word(word: 'Address', phonetic: '[əˈdres]', noun: [
      'n. address',
      'n. Alamat',
      'n. 地址',
      'n. адрес'
    ], verb: [
      'v. handle',
      'v. Melupuskan',
      'v. 處理',
      'v. с'
    ], sentences: [
      [
        'Please fill in your mailing address.',
        'Sila isikan alamat surat-menyurat anda.',
        '請填寫你的通訊地址。',
        'Пожалуйста, введите ваш почтовый адрес.'
      ],
      [
        'We need to address this problem immediately.',
        'Kita perlu menangani masalah ini dengan segera.',
        '我們需要立即解決這個問題。',
        'Мы должны немедленно решить эту проблему.'
      ]
    ]),
    Word(word: 'Contract', phonetic: '/ˈkɑːntrækt/', noun: [
      'n. contract',
      'n. Kontrak',
      'n. 合同',
      'n. контракт'
    ], verb: [
      'v. shrink',
      'v. Mengecut',
      'v. 收縮',
      'v. схватк'
    ], sentences: [
      [
        'Please sign the contract before Friday.',
        'Sila tandatangani kontrak sebelum Jumaat.',
        '請在星期五之前籤合同。',
        'Пожалуйста, подпишите контракт до пятницы.'
      ],
      [
        'Metals contract when cooled.',
        'Logam mengecut apabila disejukkan.',
        '金屬冷卻時會收縮。',
        'Металлы сжимаются при охлаждении.'
      ]
    ]),
    Word(word: 'Present', phonetic: '/ˈpreznt/', noun: [
      'n. gift',
      'n. Hadiah',
      'n. 禮物',
      'n. подарк'
    ], verb: [
      'v. emerge',
      'v. Hadir',
      'v. 呈現',
      'v. представля'
    ], sentences: [
      [
        'I received a wonderful birthday present.',
        'Saya menerima hadiah hari jadi yang indah.',
        '我收到了一份很棒的生日禮物。',
        'Я получил замечательный подарок на день рождения.'
      ],
      [
        'She will present her research tomorrow.',
        'Dia akan membentangkan penyelidikannya esok.',
        '她明天將發表她的研究報告。',
        'Она представит свои исследования завтра.'
      ]
    ]),
    Word(word: 'Object', phonetic: '/ˈɑːbdʒekt/', noun: [
      'n. object',
      'n. Objek',
      'n. 物體',
      'n. объект'
    ], verb: [
      'v. oppose',
      'v. Menentang',
      'v. 反對',
      'v. прот'
    ], sentences: [
      [
        'There\'s a strange object on the table.',
        'Terdapat objek pelik di atas meja.',
        '桌子上有個奇怪的東西。',
        'На столе странный предмет.'
      ],
      [
        'Many people object to the new policy.',
        'Ramai orang membantah dasar baharu itu.',
        '許多人反對這項新政策。',
        'Многие люди возражают против новой политики.'
      ]
    ]),
    Word(word: 'Record', phonetic: '/ˈrekərd/', noun: [
      'n. Records',
      'n. Rakaman',
      'n. 記錄',
      'n. запис'
    ], verb: [
      'v. record',
      'v. Rakaman',
      'v. 錄製',
      'v. записа'
    ], sentences: [
      [
        'Keep a record of all transactions.',
        'Simpan rekod semua transaksi.',
        '把所有的交易都記錄下來。',
        'Вести учет всех операций.'
      ],
      [
        'We will record the live concert.',
        'Kami akan merakam konsert secara langsung.',
        '我們將錄製現場音樂會。',
        'Мы будем записывать живой концерт.'
      ]
    ])
  ];

  var hmdStr = ''.obs;
  var weekdayStr = ''.obs;
  Word? currentWord;

  bool isPlay = false;

  String formatTimeDifference(DateTime date1, DateTime date2) {
    Duration difference = date1.difference(date2);
    int totalSeconds = difference.inSeconds.abs();
    int hours = totalSeconds ~/ 3600;
    int remainingSeconds = totalSeconds % 3600;
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$hoursStr:$minutesStr:$secondsStr';
  }

  startTimer() async {
    _timer?.cancel();
    _timer = null;
    DBRecite dbRecite = Get.find();
    final result = await dbRecite.getReciteAllData();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      hmdStr.value = DateFormat('MM/dd/yyyy').format(now);
      weekdayStr.value = '${weekdays[now.weekday - 1]},just learn a little';
      currentWord = allWords[now.weekday - 1];
      update();

      if (result.isNotEmpty) {
        final lastEntity = result.first;
        final waitTime = lastEntity.createdTime.add(const Duration(days: 1));
        final waitTime1 = DateTime(waitTime.year,waitTime.month,waitTime.day,0,0,0);
        downTimeStr.value = formatTimeDifference(now, waitTime1);
        if (downTimeStr.value == '00:00:00') {
          playCount = 0;
          emptyPage = false;
          update();
        }
      }
    });
  }

  void selectedLanguage() {
    final items = ['English', 'Malay', 'Complex form', 'Russian'];
    BottomPicker(
      pickerTitle: const Text(''),
      items: items.map((e) => Text(e)).toList(),
      onSubmit: (index) {
        languageType = index;
        languageStr.value = items[index];
        update();
      },
    ).show(Get.context!);
  }

  var playCount = 0;
  bool emptyPage = false;
  var downTimeStr = ''.obs;

  void addData() async {
    DBRecite dbRecite = Get.find();
    final result = await dbRecite.getReciteAllData();
    final now = DateTime.now();
    final here = result
        .where((element) =>
            DateFormat('MM/dd/yyyy').format(element.createdTime) ==
            DateFormat('MM/dd/yyyy').format(now))
        .toList();
    if (here.isEmpty && playCount >= 3) {
      await dbRecite.insertRecite(ReciteEntity(id: 0,createdTime: DateTime.now()));
      emptyPage = true;
      update();
      startTimer();
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    DBRecite dbRecite = Get.find();
    final result = await dbRecite.getReciteAllData();
    final now = DateTime.now();
    final here = result
        .where((element) =>
    DateFormat('MM/dd/yyyy').format(element.createdTime) ==
        DateFormat('MM/dd/yyyy').format(now))
        .toList();
    if (here.isNotEmpty) {
      emptyPage = true;
      update();
    }
    startTimer();
    super.onInit();
  }
}
