import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/modules/premium/premium_screen.dart';
import 'package:news_break/app/bindings/premium_binding.dart';

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 100,
          width: 335,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
                image: AssetImage('assets/images/premium_bg.jpg'),
                fit: BoxFit.cover),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Try Premium for FREE',
                      style: AppTextStyles.buttonOutline,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ad-free reading, boosted comments,\nsmarter recommendations and more.',
                      style: AppTextStyles.textSmall.copyWith(color: Color(0xFFF3DAD5)),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => Get.to(
                      () => const PremiumScreen(),
                  binding: PremiumBinding(),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD5F5C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
                child: Text('Upgrade',
                  style: AppTextStyles.bodySmall.copyWith(color:AppColors.surface),
                ),
              ),
            ],
          ),
        );
  }
  }