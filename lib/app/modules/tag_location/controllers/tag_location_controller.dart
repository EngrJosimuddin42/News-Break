import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagLocationController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxList<Map<String, String>> locations = <Map<String, String>>[
    {'city': 'New York City', 'zip': 'NY, 100002'},
    {'city': 'New York City', 'zip': 'NY, 100009'},
    {'city': 'New York City', 'zip': 'NY, 100009'},
  ].obs;

  void onSelectLocation(Map<String, String> location) {
    Get.back(result: location);
  }

  void onCancel() => Get.back();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}