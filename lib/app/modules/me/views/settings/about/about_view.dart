import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/me/views/settings/about/legal_view.dart';
import 'package:news_break/app/modules/premium/views/premium_screen.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../../../../premium/bindings/premium_binding.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color:AppColors.textOnDark, size: 20),
        ),
        title:Text('About',
            style:AppTextStyles.displaySmall),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Logo
            Image.asset(
              'assets/images/newsbreak_logo.png',
              width: 100,
              height: 100,
              ),
            // App name
            Text('Newsbreak',
                style: AppTextStyles.displaySmall),
            const SizedBox(height: 6),

            // Version
            Text('Version 26.10.1.4',
                style:AppTextStyles.labelSmall),
            const SizedBox(height: 4),

            Text('NewsBreak is your personalized news app.',
                style:AppTextStyles.labelSmall),

            const SizedBox(height: 48),

            // Buttons
            _actionButton('Terms of Use', () => Get.to(() => const LegalView(type: LegalType.terms))),
            const SizedBox(height: 12),
            _actionButton('Legal Notices', () => Get.to(() => const LegalView(type: LegalType.notice))),
            const SizedBox(height: 12),
            _actionButton('Privacy Policy', () => Get.to(() => const LegalView(type: LegalType.privacy))),
            const SizedBox(height: 12),
            _actionButton('Check for Update', () => Get.to(() => const PremiumScreen(),binding: PremiumBinding())),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color:AppColors.surface),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(label,
              style: AppTextStyles.caption),
        ),
      ),
    );
  }
}