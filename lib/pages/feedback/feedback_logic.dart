import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackLogic extends GetxController {

  Uint8List? image;
  String content = '';

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        image = imageBytes;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Please check album permissions or select a new image');
      return;
    }
  }

  void commit(BuildContext context) {
    if (image == null) {
      Fluttertoast.showToast(msg: 'Please select image');
      return;
    }
    if (content.isEmpty) {
      Fluttertoast.showToast(msg: 'Please input content');
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    Fluttertoast.showToast(msg: 'Commit success');
    Get.back();
  }

}
