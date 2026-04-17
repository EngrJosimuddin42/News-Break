import 'package:get/get.dart';

class CreateReelController extends GetxController {

  var selectedTab = 0.obs;

  var hasCameraPermission = false.obs;
  var hasMicPermission = false.obs;


  void changeTab(int index) {
    selectedTab.value = index;
  }


  Future<void> pickVideoFromGallery() async {}

  void startRecording() {}
}