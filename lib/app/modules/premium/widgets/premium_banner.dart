import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/modules/premium/premium_screen.dart';
import 'package:news_break/app/bindings/premium_binding.dart';

import '../../../controllers/premium_controller.dart';

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PremiumController>();
    return Container( height: 120, width: 335,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color:Color(0xFF282828)),
            borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.bannerTitle.value, style: AppTextStyles.buttonOutline),
                    SizedBox(height: 4),
                    Text(controller.bannerSubtitle.value, style: AppTextStyles.textSmall.copyWith(color: Color(0xFFF3DAD5))),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => Get.to(
                      () => const PremiumScreen(),
                  binding: PremiumBinding()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD5F5C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
                child: Text(controller.bannerButtonText.value, style: AppTextStyles.bodySmall.copyWith(color:AppColors.surface))),
            ],
          ),
        );
      }
  }