import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../modules/create_post/tag_location_sheet.dart';

class CreatePostController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final TextEditingController locationSearchController = TextEditingController();

  late VideoPlayerController videoController;
  var isVideoInitialized = false.obs;

  var selectedLocation = "".obs;
  var isLoading = false.obs;
  var filteredLocations = <Map<String, String>>[].obs;

  final Rx<File?> selectedMedia = Rx<File?>(null);
  final Rx<File?> videoThumbnail = Rx<File?>(null);
  final RxBool isReel = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    filteredLocations.assignAll(allLocations);

    if (Get.arguments != null) {
      final file = Get.arguments as File;
      selectedMedia.value = file;

      if (file.path.toLowerCase().endsWith('.mp4') ||
          file.path.toLowerCase().endsWith('.mov')) {
        isReel.value = true;
        _generateThumbnail(file.path);
      }
    }
  }


  @override
  void onClose() {
    textController.dispose();
    locationSearchController.dispose();
    super.onClose();
  }

  Future<void> _generateThumbnail(String path) async {
    try {
      final thumbPath = await VideoThumbnail.thumbnailFile(
        video: path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,
        quality: 70,
      );
      if (thumbPath != null) {
        videoThumbnail.value = File(thumbPath);
        videoThumbnail.refresh();
        debugPrint("Thumbnail Generated: $thumbPath");
      }
    } catch (e) {
      debugPrint("Thumbnail Error: $e");
    }
  }


  void onAddMedia() async {
    final XFile? pickedFile = isReel.value
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedMedia.value = File(pickedFile.path);

      if (isReel.value) {
        await _generateThumbnail(pickedFile.path);
      } else {
        videoThumbnail.value = null;
      }
    }
  }

  void onPost() async {
    if (isReel.value && selectedMedia.value == null) {
      Get.snackbar('Video Required', 'Please select a video for your reel.');
      return;
    }
    if (!isReel.value && textController.text.trim().isEmpty && selectedMedia.value == null) {
      AppSnackbar.warning(title: 'Empty Post',message:  'Please add some text or an image.');
      return;
    }
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      String message = isReel.value ? 'Your reel has been posted!' : 'Your post has been shared!';
      _resetAll();
      Get.back();
     AppSnackbar.success(message: message);
    } catch (e) {
      AppSnackbar.error(message:  'Something went wrong while uploading.');
    } finally {
      isLoading.value = false;
    }
  }

  void _resetAll() {
    textController.clear();
    selectedMedia.value = null;
    videoThumbnail.value = null;
    selectedLocation.value = '';
    isReel.value = false;
  }

  void onBack() {
    _resetAll();
    Get.back();
  }

  void onTagLocation() async {
    locationSearchController.clear();
    filteredLocations.assignAll(allLocations);
    final result = await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        builder: (context) => const TagLocationSheet());

    if (result != null && result is Map) {
      selectedLocation.value = result['city'] ?? "";
    }
  }

  void filterLocations(String query) {
    if (query.isEmpty) {
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