import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  var selectedLanguage = 'English'.obs;
  var isDarkMode = true.obs;
  var selectedTextSize = 'Medium'.obs;
  var isLocationVisible = true.obs;

  void toggleLocationVisible(bool value) => isLocationVisible.value = value;
  void changeLanguage(String lang) => selectedLanguage.value = lang;
  void toggleDarkMode(bool value) => isDarkMode.value = value;
  void changeTextSize(String size) => selectedTextSize.value = size;
}