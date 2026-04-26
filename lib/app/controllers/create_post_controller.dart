import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_break/app/controllers/social_utility_controller.dart';
import 'package:news_break/app/controllers/socials/socials_controller.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../models/news_model.dart';
import '../modules/create_post/tag_location_sheet.dart';

//  Post type enum
enum PostType { news, reel, social }

class CreatePostController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final TextEditingController locationSearchController = TextEditingController();
  final utility = Get.find<SocialUtilityController>();

  // ── State
  var selectedLocation = "".obs;
  var isLoading = false.obs;
  var filteredLocations = <Map<String, String>>[].obs;
  var postType = PostType.news.obs;

  final Rx<File?> selectedMedia = Rx<File?>(null);
  final Rx<File?> videoThumbnail = Rx<File?>(null);
  final RxBool isReel = false.obs;

  final ImagePicker _picker = ImagePicker();

  //  Post type getters
  bool get isNewsPost => postType.value == PostType.news;
  bool get isReelPost => postType.value == PostType.reel;
  bool get isSocialPost => postType.value == PostType.social;

  @override
  void onInit() {
    super.onInit();
    resetAll();
    filteredLocations.assignAll(allLocations);
    _handleArguments();
  }


  void _handleArguments() {
    final args = Get.arguments;
    if (args == null) return;

    if (args is File) {
      selectedMedia.value = args;
      if (args.path.toLowerCase().endsWith('.mp4') ||
          args.path.toLowerCase().endsWith('.mov')) {
        postType.value = PostType.reel;
        isReel.value = true;
        _generateThumbnail(args.path);
      } else {
        postType.value = PostType.news;
      }
    } else if (args is NewsModel) {
      postType.value = PostType.news;
      textController.text = "${args.title}\n\n";
    } else if (args is String && args == 'social') {
      postType.value = PostType.social;
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

  //  Post type অনুযায়ী validation ও submit
  void onPost() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));

      if (isSocialPost) {
        await Get.find<SocialsController>().submitPost(
          textController.text,
          imageUrl: utility.selectedImage.value?.path,
        );
      }

      final String message = _getSuccessMessage();
      resetAll();
      Get.back();
      AppSnackbar.success(message: message);
    } catch (e) {
      AppSnackbar.error(message: 'Something went wrong while uploading.');
    } finally {
      isLoading.value = false;
    }
  }

  //  Type validation
  bool _validate() {
    if (isReelPost && selectedMedia.value == null) {
      AppSnackbar.warning(title: 'Video Required', message: 'Please select a video.');
      return false;
    }
    if (!isReelPost &&
        textController.text.trim().isEmpty &&
        selectedMedia.value == null &&
        utility.selectedImage.value == null &&
        utility.selectedGifUrl.value == null) {
      AppSnackbar.warning(title: 'Empty Post', message: 'Please add some text or media.');
      return false;
    }
    return true;
  }

  //  Type success message
  String _getSuccessMessage() {
    switch (postType.value) {
      case PostType.reel:
        return 'Your reel has been posted!';
      case PostType.social:
        return 'Your post has been shared!';
      case PostType.news:
      default:
        return 'Your post has been shared!';
    }
  }

  // Public reset
  void resetAll() {
    textController.clear();
    selectedMedia.value = null;
    videoThumbnail.value = null;
    selectedLocation.value = '';
    isReel.value = false;
    isLoading.value = false;
    postType.value = PostType.news;
    utility.clearAllMedia();
    utility.clearTags();
  }

  void onBack() {
    resetAll();
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
      builder: (context) => const TagLocationSheet(),
    );
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