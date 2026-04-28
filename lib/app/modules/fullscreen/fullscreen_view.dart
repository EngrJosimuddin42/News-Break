import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../controllers/fullscreen_controller.dart';

class FullscreenView extends GetView<FullscreenController> {
  const FullscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Skip
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.onSkip,
                  child:Text('Skip', style: AppTextStyles.bodyMedium))),
              const SizedBox(height: 100),
              // Title
               Text('Enable full screen now', style:AppTextStyles.headlineLarge),
              const SizedBox(height: 32),
              // Phone mockup
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/phone_mockup.png', height: 320,
                    fit: BoxFit.contain))),
              const Spacer(),
              // Allow button
              SizedBox( width: 311, height: 48,
                child: ElevatedButton(
                  onPressed: controller.onAllow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    foregroundColor:AppColors.background,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  child: Text('Allow', style: AppTextStyles.bodySmall))),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}