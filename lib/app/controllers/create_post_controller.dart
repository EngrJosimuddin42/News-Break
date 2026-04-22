import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../modules/create_post/tag_location_sheet.dart';

class CreatePostController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final TextEditingController locationSearchController = TextEditingController();

  var selectedLocation = "".obs;
  var isLoading = false.obs;
  var selectedImage = Rxn<File>();
  var filteredLocations = <Map<String, String>>[].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    filteredLocations.assignAll(allLocations);
  }

  @override
  void onClose() {
    textController.dispose();
    locationSearchController.dispose();
    super.onClose();
  }

  void onAddMedia() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }


  void onBack() => Get.back();


  void onPost() async {
    if (textController.text.trim().isEmpty) return;
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }

  void onTagLocation() async {
    locationSearchController.clear();
    filteredLocations.assignAll(allLocations);
    final result = await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(
        maxWidth: double.infinity),
      useSafeArea: true,
      builder: (context) => const TagLocationSheet());

    if (result != null && result is Map) {
      selectedLocation.value = result['city'] ?? "";
    }
  }

  void filterLocations(String query) {if (query.isEmpty) {
    filteredLocations.assignAll(allLocations);
    } else {
      filteredLocations.assignAll(
        allLocations.where((loc) =>
        loc['city']!.toLowerCase().contains(query.toLowerCase()) ||
            loc['zip']!.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  final List<Map<String, String>> allLocations = [
    {'city': 'New York City', 'zip': 'NY, 100002'},
    {'city': 'Los Angeles', 'zip': 'CA, 90001'},
    {'city': 'Chicago', 'zip': 'IL, 60601'},
    {'city': 'Houston', 'zip': 'TX, 77001'},
    {'city': 'San Francisco', 'zip': 'CA, 94105'},
  ];

}