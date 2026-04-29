import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/premium_controller.dart';
import 'payment_method_screen.dart';

class PremiumScreen extends GetView<PremiumController> {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios, color: AppColors.textOnDark, size: 20)),
                ],
              ),
            ),

            // Title
            Text('Choose Your Plan', style: AppTextStyles.displaySmall),
            const SizedBox(height: 12),
            Text('Become a Premium Member', style: AppTextStyles.bodyLarge),
            const SizedBox(height: 24),

            // Scrollable body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => Column(
                  children: [
                    // Yearly Card
                    _planCard(
                      isSelected: controller.isYearly.value,
                      badge: 'Best Value',
                      plan: 'Yearly',
                        price: controller.yearlyPrice.value,
                      period: '/year',
                      onTap: () => controller.selectPlan(true)),

                    const SizedBox(height: 16),

                    // Monthly Card
                    _planCard(
                      isSelected: !controller.isYearly.value,
                      plan: 'Monthly',
                        price: controller.monthlyPrice.value,
                      period: '/Month',
                      onTap: () => controller.selectPlan(false)),

                    const SizedBox(height: 24),

                    // CTA Button
                    SizedBox(
                      width: double.infinity, height: 48,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const PaymentMethodScreen()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.linkColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 0),
                        child: Text(controller.freeTrialText.value, style: AppTextStyles.bodySmall))),

                    const SizedBox(height: 12),

                    // Disclaimer
                    Text(controller.disclaimerText.value, style: AppTextStyles.display, textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Plan Card
  Widget _planCard({
    required bool isSelected,
    String? badge,
    required String plan,
    required String price,
    required String period,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xFF535353) : const Color(0xFF2A2A2A),
            width: isSelected ? 2 : 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Badge (optional)
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFAA0000),
                  borderRadius: BorderRadius.circular(50)),
                child: Text(badge, style: AppTextStyles.textSmall.copyWith(color: Colors.white))),
              const SizedBox(height: 12),
            ],

            // Plan name + Price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plan, style: AppTextStyles.bodyMedium),
                RichText(
                  text: TextSpan(
                    children: [
                    TextSpan( text: price, style: AppTextStyles.heading.copyWith( color: AppColors.linkColor)),
                    TextSpan( text: period, style: AppTextStyles.small.copyWith(color: AppColors.linkColor)),
                  ]),
                ),
              ],
            ),

            const SizedBox(height: 16),
          
            // Feature list
            ...controller.features.map((f) => _featureRow(f['title']!, f['subtitle']!)),
          ],
        ),
      ),
    );
  }

  // Single feature row
  Widget _featureRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox icon
         Image.asset('assets/icons/premium.png',height: 20,width: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.textSmall.copyWith(color: Colors.white)),
                const SizedBox(height: 8),
                Text(subtitle, style: AppTextStyles.display.copyWith(color: Color(0xFFC4C4C4))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}