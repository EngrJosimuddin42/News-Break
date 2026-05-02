import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateReelController extends GetxController {
  var selectedTab = 1.obs;
  var hasCameraPermission = false.obs;
  var hasMicPermission = false.obs;
  var selectedMedia = Rxn<File>();
  var isCameraBtnPressed = false.obs;
  var isMicBtnPressed = false.obs;


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
      AppSnackbar.success(message: 'Camera access granted');
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
      AppSnackbar.success(message: 'Microphone access granted');
    } else if (status.isPermanentlyDenied) {
      AppSnackbar.warning(title: 'Permission',message:'Please enable microphone from settings',
          mainButton: TextButton(onPressed: () => openAppSettings(), child: const Text('Open')));
    }
  }

  void startRecording() async {
    if (isCameraBtnPressed.value && isMicBtnPressed.value) {
      AppSnackbar.success(message: 'Recording Started...');
    } else {
      AppSnackbar.warning(
        title: 'Permission Required',
        message: 'Please allow both Camera and Microphone access.',
      );
    }
  }
}