import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class CreatePostController extends GetxController {
  final TextEditingController textController = TextEditingController();

  void onPost() {
    if (textController.text.trim().isEmpty) return;
    Get.back();
  }

  void onBack() => Get.back();

  void onTagLocation() async {
    final result = await Get.toNamed(Routes.TAG_LOCATION);
    if (result != null) {
      // handle selected location
    }
  }

  void onAddMedia() {}

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}