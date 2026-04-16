import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/newsbreak_logo.png',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 16),
             Text('Newsbreak',
            style: AppTextStyles.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}