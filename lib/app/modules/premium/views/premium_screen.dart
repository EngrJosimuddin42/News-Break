import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../controllers/premium_controller.dart';
import 'payment_method_screen.dart';

class PremiumScreen extends GetView<PremiumController> {
  const PremiumScreen({super.key});

  static const _features = [
    {'icon': 'assets/icons/ad_free.png', 'title': 'Ad-free in NewsBreak App', 'subtitle': 'Millions of articles, videos, local Tvs, etc'},
    {'icon': 'assets/icons/recommend.png', 'title': 'Personalized recommendations', 'subtitle': 'see more stories that match your interest'},
    {'icon': 'assets/icons/comment1.png', 'title': 'Comment Boost', 'subtitle': 'Receive enhances visibility for your comments'},
    {'icon': 'assets/icons/avatar.png', 'title': 'Avatar ring', 'subtitle': 'Make your premium membership shine'},
    {'icon': 'assets/icons/support.png', 'title': 'Priority support', 'subtitle': 'Email: premium-support@newsbreak.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/newsbreak_logo.png', width: 60, height: 60),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Newsbreak ', style: AppTextStyles.displaySmall),
                        TextSpan(text: 'Premium', style: AppTextStyles.displaySmall.copyWith(color:AppColors.linkColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration:BoxDecoration(
                      shape: BoxShape.circle,
                     color: AppColors.textPrimary,
                      border: Border.all(color: AppColors.linkColor)
                    ),
                    child: Center(
                      child: Text(controller.userInitial,
                        style: AppTextStyles.displayMedium.copyWith(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFD5F5C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.star, color: Colors.white, size: 12),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Become a Premium Member', style: AppTextStyles.headlineMedium),
              const SizedBox(height: 32),
              ..._features.map((f) => Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color:AppColors.linkColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        f['icon']!,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f['title']!, style: AppTextStyles.buttonOutline),
                          Text(f['subtitle']!, style: AppTextStyles.display),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 8),
              Center(
                  child:Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                children: [
                  _pricingCard(
                    isSelected: controller.isYearly.value,
                    badge: 'Save \$12',
                    plan: 'Yearly',
                    price: '\$47.99',
                    period: '/year',
                    original: '\$59.99',
                    onTap: () => controller.selectPlan(true),
                  ),
                  const SizedBox(width: 300),
                   _pricingCard(
                    isSelected: !controller.isYearly.value,
                    plan: 'Monthly',
                    price: '\$29.99',
                    period: '/month',
                    original: '\$29.99',
                    onTap: () => controller.selectPlan(false),
                  ),
                ],
              ))),
              const SizedBox(height: 32),
              SizedBox(
                width: 311,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const PaymentMethodScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:AppColors.linkColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Start 7day Free Trial',
                      style: AppTextStyles.bodySmall),
                ),
              ),
              const SizedBox(height: 16),
              Text('Lorem ipsum dolor sit amet consectetur. Sapien netus sed turpis euismod tortor. Consequat arcu commodo non habitant sit cras aliquam elementum commodo. Proin viverra pharetra etiam nibh nunc.',
                style:AppTextStyles.display,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pricingCard({
    required bool isSelected,
    String? badge,
    required String plan,
    required String price,
    required String period,
    required String original,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
      Container(
      width: 160,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1A) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.linkColor : Colors.black,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (badge != null) const SizedBox(height: 10),
            Text(plan, style: AppTextStyles.bodyMedium),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(children: [
                TextSpan(text: price, style: AppTextStyles.headlineMedium),
                TextSpan(text: period, style: AppTextStyles.small),
              ]),
            ),
            Text(original,
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.linkColor,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.linkColor)),
          ],
        ),
      ),
          if (badge != null)
            Positioned(
              top: 0,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.linkColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(badge, style: AppTextStyles.small),
              ),
            ),
        ],
      ),
    );
  }
}