import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'auth_controller.dart';

class AuthHelper {
  static bool checkLogin() {
    final authController = Get.find<AuthController>();

    if (authController.user.value == null) {
      Get.snackbar(
        "Login Required",
        "Please login to use this feature",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE53935),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.lock_outline, color: Colors.white),
      );
      return false;
    }
    return true;
  }
}