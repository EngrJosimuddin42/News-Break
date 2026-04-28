import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  var selectedLanguage = 'English'.obs;
  var isDarkMode = true.obs;
  var selectedTextSize = 'Medium'.obs;
  var isLocationVisible = true.obs;
  var isFeedbackLoading = false.obs;

  void toggleLocationVisible(bool value) => isLocationVisible.value = value;
  void toggleDarkMode(bool value) => isDarkMode.value = value;
  void changeTextSize(String size) => selectedTextSize.value = size;


  String get currentLanguageName {
    if (selectedLanguage.value == 'English') {
      return 'English (US)';
    } else {
      return 'Bangla (BD)';
    }
  }


  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
    if (lang == 'English') {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('bn', 'BD'));
    }
  }


  Future<void> sendFeedback({required String comment, required int rating}) async {
    if (comment.isEmpty) {
      AppSnackbar.error(message: "Please write something first!");
      return;
    }
    try {
      isFeedbackLoading.value = true;
      Get.back();
      AppSnackbar.success(message: "Thank you for your feedback!");
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Try again.");
    } finally {
      isFeedbackLoading.value = false;
    }
  }

  void showLanguagePicker() {
    showDialog(
      context: Get.context!,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF282828),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Text('Language',
                      style: AppTextStyles.displaySmall
                          .copyWith(fontWeight: FontWeight.w500)),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              _buildLanguageButton('English'),
              const SizedBox(height: 12),
              _buildLanguageButton('Bangla'),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String lang) {
    return GestureDetector(
      onTap: () {
        changeLanguage(lang);
        Get.back();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.linkColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(lang, style: AppTextStyles.bodySmall),
        ),
      ),
    );
  }
}