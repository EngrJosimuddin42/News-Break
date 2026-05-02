import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../modules/create_post/create_post_view.dart';
import '../create_post_controller.dart';

class CreateReelController extends GetxController {
  var selectedTab = 1.obs;
  var hasCameraPermission = false.obs;
  var hasMicPermission = false.obs;
  var selectedMedia = Rxn<File>();
  var isCameraBtnPressed = false.obs;
  var isMicBtnPressed = false.obs;

  final ImagePicker _picker = ImagePicker();


  @override
  void onInit() {
    super.onInit();
    _checkPermissions();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> _checkPermissions() async {
    hasCameraPermission.value = await Permission.camera.isGranted;
    hasMicPermission.value = await Permission.microphone.isGranted;
  }


  Future<void> requestCameraPermission() async {
    if (isCameraBtnPressed.value) return;
    var status = await Permission.camera.request();
    hasCameraPermission.value = status.isGranted;
    if (status.isGranted) {
      isCameraBtnPressed.value = true;
    } else if (status.isPermanentlyDenied) {
      AppSnackbar.warning(title: 'Permission',message:'Please enable camera from settings',
          mainButton: TextButton(onPressed: () => openAppSettings(), child: const Text('Open')));
    }
  }


  Future<void> requestMicPermission() async {
    if (isMicBtnPressed.value) return;
    var status = await Permission.microphone.request();
    hasMicPermission.value = status.isGranted;
    if (status.isGranted) {
      isMicBtnPressed.value = true;
    } else if (status.isPermanentlyDenied) {
      AppSnackbar.warning(title: 'Permission',message:'Please enable microphone from settings',
          mainButton: TextButton(onPressed: () => openAppSettings(), child: const Text('Open')));
    }
  }

  void startRecording() async {
    if (isCameraBtnPressed.value && isMicBtnPressed.value) {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

      if (video != null) {
        File videoFile = File(video.path);

        final postController = Get.put(CreatePostController());

        postController.postType.value = PostType.reel;
        postController.isReel.value = true;
        postController.selectedMedia.value = videoFile;

        await postController.generateThumbnail(videoFile.path);

        Get.to(() => const CreatePostView());
      }
    } else {
      AppSnackbar.warning(
        title: 'Permission Required',
        message: 'Please allow both Camera and Microphone access.',
      );
    }
  }
}