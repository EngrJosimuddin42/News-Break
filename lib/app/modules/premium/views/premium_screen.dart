import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../controllers/premium_controller.dart';
import 'payment_method_screen.dart';

class PremiumScreen extends GetView<PremiumController> {
  const PremiumScreen({super.key});

  static const _features = [
    {'icon': 'assets/icons/ad_free.png', 'title': 'Ad-free in NewsBreak App', 'subtitle': 'Millions of articles, videos, local Tvs, etc'},
    {'icon': 'assets/icons/recommend.png', 'title': 'Personalized recommendations', 'subtitle': 'see more stories that match your interest'},
    {'icon': 'assets/icons/comment.png', 'title': 'Comment Boost', 'subtitle': 'Receive enhances visibility for your comments'},
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
                  Image.asset('assets/images/logo.png', width: 28, height: 28),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Newsbreak ', style: AppTextStyles.displaySmall),
                        TextSpan(
                          text: 'Premium',
                          style: AppTextStyles.displaySmall.copyWith(color: const Color(0xFFFD5F5C)),
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
                    width: 72, height: 72,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
                      ),
                    ),
                    child: const Center(
                      child: Text('A', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFD5F5C),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(Icons.star, color: Colors.white, size: 12),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Become a Premium Member', style: AppTextStyles.labelLarge),
              const SizedBox(height: 24),
              ..._features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFD5F5C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f['title']!, style: AppTextStyles.labelMedium),
                          Text(f['subtitle']!, style: AppTextStyles.textSmall.copyWith(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 8),
              // ✅ Obx দিয়ে reactive pricing cards
              Obx(() => Row(
                children: [
                  Expanded(child: _pricingCard(
                    isSelected: controller.isYearly.value,
                    badge: 'Save \$12',
                    plan: 'Yearly',
                    price: '\$59.99',
                    period: '/year',
                    original: '\$59.99',
                    onTap: () => controller.selectPlan(true),
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _pricingCard(
                    isSelected: !controller.isYearly.value,
                    plan: 'Monthly',
                    price: '\$59.99',
                    period: '/month',
                    original: '\$59.99',
                    onTap: () => controller.selectPlan(false),
                  )),
                ],
              )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const PaymentMethodScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFD5F5C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Start 7day Free Trial',
                      style: AppTextStyles.labelLarge.copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet consectetur. Sapien netus sed turpis euismod tortor. Consequat arcu commodo non habitant sit cras aliquam elementum commodo. Proin viverra pharetra etiam nibh nunc.',
                style: AppTextStyles.textSmall.copyWith(color: Colors.grey),
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
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1A) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFD5F5C) : Colors.grey.shade800,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFD5F5C),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 6),
            ] else
              const SizedBox(height: 22),
            Text(plan, style: AppTextStyles.caption),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(children: [
                TextSpan(text: price, style: AppTextStyles.labelLarge),
                TextSpan(text: period, style: AppTextStyles.textSmall.copyWith(color: Colors.grey)),
              ]),
            ),
            Text(original,
                style: AppTextStyles.textSmall.copyWith(
                    color: const Color(0xFFFD5F5C),
                    decoration: TextDecoration.lineThrough,
                    decorationColor: const Color(0xFFFD5F5C))),
          ],
        ),
      ),
    );
  }
}