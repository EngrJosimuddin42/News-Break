import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:70),
              Center(
                child: Image.asset('assets/images/congrats_success.png', width: 200, height: 200, fit: BoxFit.contain)),

              const SizedBox(height: 32),
              Text('Congratulations', style: AppTextStyles.success),
              const SizedBox(height: 12),
              Text('Your payment is successfully done.', style: AppTextStyles.overline.copyWith(fontSize: 14), textAlign: TextAlign.center),
              const Spacer(),
              Center(
                child: SizedBox(width: 311, height: 48,
                  child: ElevatedButton(
                    onPressed: () => Get.until((route) => route.isFirst),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.linkColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: Text('Back', style: AppTextStyles.bodySmall)))),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}