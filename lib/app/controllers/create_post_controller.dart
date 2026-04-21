import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/create_post/create_post_view.dart';

class CreatePostController extends GetxController {
  final TextEditingController textController = TextEditingController();

  var selectedLocation = "".obs;

  void onPost() {
    if (textController.text.trim().isEmpty) {
      return;
    }
    Get.back();
  }


  void onBack() => Get.back();

  void onTagLocation() async {
    final result = await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(
        maxWidth: double.infinity),
      useSafeArea: true,
      builder: (context) => const TagLocationSheet(),
    );

    if (result != null && result is Map) {
      selectedLocation.value = result['city'] ?? "";
    }
  }


  void onAddMedia() {}

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}