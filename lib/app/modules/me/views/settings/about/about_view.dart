import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/me/views/settings/about/shared_view.dart';

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
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.white, size: 18),
        ),
        title: const Text('About',
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Logo
            Image.asset(
              'assets/images/newsbreak_logo.png',
              width: 80,
              height: 80,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.newspaper,
                    color: Colors.white, size: 48),
              ),
            ),
            const SizedBox(height: 12),

            // App name
            const Text('Newsbreak',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),

            // Version
            const Text('Version 26.10.1.4',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 4),

            const Text('NewsBreak is your personalized news app.',
                style: TextStyle(color: Colors.grey, fontSize: 13)),

            const SizedBox(height: 32),

            // Buttons
            _actionButton('Terms of Use', () => Get.to(() => const TermsOfUseView())),
            const SizedBox(height: 12),
            _actionButton('Legal Notices', () => Get.to(() => const LegalNoticeView())),
            const SizedBox(height: 12),
            _actionButton('Privacy Policy', () => Get.to(() => const PrivacyPolicyView())),
            const SizedBox(height: 12),
            _actionButton('Check for Update', () {}),
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
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}