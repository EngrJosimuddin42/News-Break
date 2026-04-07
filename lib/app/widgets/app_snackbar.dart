import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppSnackbar {
  AppSnackbar._();

  static void show({
    required String title,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    SnackPosition position = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    SnackStyle snackStyle = SnackStyle.FLOATING,
    Widget? icon,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor ?? AppColors.surface,
      colorText: textColor ?? AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: duration,
      snackStyle: snackStyle,
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 24,
      ),
      maxWidth: 311,
      borderRadius: 12,
      titleText: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: textColor ?? AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Text(
        message,
        style: AppTextStyles.bodySmall.copyWith(
          color: textColor ?? AppColors.white,
        ),
      ),
      icon: icon,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }

  //  Preset types

  static void success({required String title, required String message}) {
    show(
      title: title,
      message: message,
      backgroundColor: const Color(0xFF2E7D32),
      icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 28),
    );
  }

  static void error({required String title, required String message}) {
    show(
      title: title,
      message: message,
      backgroundColor: const Color(0xFFC62828),
      icon: const Icon(Icons.error_outline, color: Colors.white, size: 28),
    );
  }

  static void warning({required String title, required String message}) {
    show(
      title: title,
      message: message,
      backgroundColor: const Color(0xFFE65100),
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
    );
  }

  static void facebook({required String message}) {
    show(
      title: 'Facebook',
      message: message,
      backgroundColor: const Color(0xFF1877F2),
      icon: const Icon(Icons.facebook_rounded, color: Colors.white, size: 28),
    );
  }

  static void google({required String message}) {
    show(
      title: 'Google',
      message: message,
      backgroundColor: const Color(0xFF4285F4),
      icon: const Icon(Icons.g_mobiledata_rounded, color: Colors.white, size: 28),
    );
  }

  static void email({required String message}) {
    show(
      title: 'Email',
      message: message,
      backgroundColor: const Color(0xFF4285F4),
      icon: const Icon(Icons.email_outlined, color: Colors.white, size: 28),
    );
  }
}