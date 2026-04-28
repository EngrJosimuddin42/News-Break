import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/premium_controller.dart';
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
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                   _pricingCard(
                    isSelected: !controller.isYearly.value,
                    plan: 'Monthly',
                    price: '\$29.99',
                    period: '/month',
                    original: '\$29.99',
                    onTap: () => controller.selectPlan(false),
                  ),
                ],
              )),
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
              left: 45,
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

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/premium_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class PremiumView extends GetView<PremiumController> {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ── AppBar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 20),
                ),
              ),
            ),

            // ── Body ────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Title
                    Text('Choose Your Plan',
                        style: AppTextStyles.displaySmall.copyWith(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text('Become a Premium Member',
                        style: AppTextStyles.overline
                            .copyWith(color: Colors.grey)),
                    const SizedBox(height: 24),

                    // ✅ Yearly Plan
                    Obx(() => _buildPlanCard(
                      isSelected: controller.selectedPlan.value == 'yearly',
                      onTap: () => controller.selectPlan('yearly'),
                      badge: 'Best Value',
                      title: 'Yearly',
                      price: '\$59.99',
                      period: '/year',
                      features: controller.features,
                    )),

                    const SizedBox(height: 16),

                    // ✅ Monthly Plan
                    Obx(() => _buildPlanCard(
                      isSelected: controller.selectedPlan.value == 'monthly',
                      onTap: () => controller.selectPlan('monthly'),
                      title: 'Monthly',
                      price: '\$19.99',
                      period: '/Month',
                      features: controller.features,
                    )),

                    const SizedBox(height: 24),

                    // ✅ CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.onStartTrial,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4C6A),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Text('Start 7day Free Trial',
                            style: AppTextStyles.bodyMedium
                                .copyWith(fontSize: 16)),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ✅ Footer text
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Sapien netus sed turpis euismod tortor. Consequat arcu commodo non habitant sit cras aliquam elementum commodo. Proin viverra pharetra etiam nibh nunc.',
                      style: AppTextStyles.overline
                          .copyWith(color: Colors.grey, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required bool isSelected,
    required VoidCallback onTap,
    String? badge,
    required String title,
    required String price,
    required String period,
    required List<Map<String, String>> features,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF4C6A)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4C6A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(badge,
                    style: AppTextStyles.overline.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
            ],

            // Title + Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: price,
                        style: AppTextStyles.displaySmall.copyWith(
                          color: const Color(0xFFFF4C6A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: period,
                        style: AppTextStyles.overline.copyWith(
                            color: const Color(0xFFFF4C6A)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Features
            ...features.map((f) => _buildFeatureItem(
                  title: f['title']!,
                  subtitle: f['subtitle']!,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.caption),
                Text(subtitle,
                    style: AppTextStyles.overline
                        .copyWith(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 */

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/premium_controller.dart';
import 'payment_method_screen.dart';

class PremiumScreen extends GetView<PremiumController> {
  const PremiumScreen({super.key});

  static const _features = [
    {'icon': 'assets/icons/ad_free.png',    'title': 'Ad-free in App',                 'subtitle': 'Millions of articles, videos, local Tvs, etc'},
    {'icon': 'assets/icons/recommend.png',  'title': 'Personalized recommendations',   'subtitle': 'See more stories that match your interest'},
    {'icon': 'assets/icons/comment1.png',   'title': 'Comment Boost',                  'subtitle': 'Receive enhances visibility for your comments'},
    {'icon': 'assets/icons/avatar.png',     'title': 'Avatar ring',                    'subtitle': 'Make your premium membership shine'},
    {'icon': 'assets/icons/support.png',    'title': 'Priority support',               'subtitle': 'Email: premium-support@news.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ── AppBar row ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),

            // ── Title ──────────────────────────────────────────────────────
            Text('Choose Your Plan',
                style: AppTextStyles.displaySmall
                    .copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Become a Premium Member',
                style: AppTextStyles.display
                    .copyWith(color: Colors.white54)),
            const SizedBox(height: 20),

            // ── Scrollable body ────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => Column(
                  children: [
                    // Yearly Card
                    _planCard(
                      isSelected: controller.isYearly.value,
                      badge: 'Best Value',
                      plan: 'Yearly',
                      price: '\$59.99',
                      period: '/year',
                      onTap: () => controller.selectPlan(true),
                    ),
                    const SizedBox(height: 16),

                    // Monthly Card
                    _planCard(
                      isSelected: !controller.isYearly.value,
                      plan: 'Monthly',
                      price: '\$19.99',
                      period: '/Month',
                      onTap: () => controller.selectPlan(false),
                    ),

                    const SizedBox(height: 24),

                    // ── CTA Button ─────────────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const PaymentMethodScreen()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.linkColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: Text('Start 7day Free Trial',
                            style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Disclaimer ─────────────────────────────────────────
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Sapien netus sed turpis euismod tortor. Consequat arcu commodo non habitant sit cras aliquam elementum commodo. Proin viverra pharetra etiam nibh nunc.',
                      style: AppTextStyles.display
                          .copyWith(color: Colors.white38),
                      textAlign: TextAlign.center,
                    ),
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

  // ── Plan Card ───────────────────────────────────────────────────────────────
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.linkColor : const Color(0xFF2A2A2A),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Badge (optional) ──────────────────────────────────────────
            if (badge != null) ...[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.linkColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(badge,
                    style: AppTextStyles.small.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10),
            ],

            // ── Plan name + Price row ─────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plan,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: Colors.white, fontSize: 16)),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: price,
                        style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.linkColor, fontSize: 20)),
                    TextSpan(
                        text: period,
                        style: AppTextStyles.small
                            .copyWith(color: AppColors.linkColor)),
                  ]),
                ),
              ],
            ),

            const SizedBox(height: 14),
            const Divider(color: Color(0xFF2A2A2A), height: 1),
            const SizedBox(height: 12),

            // ── Feature list ──────────────────────────────────────────────
            ..._features.map((f) => _featureRow(f['title']!, f['subtitle']!)),
          ],
        ),
      ),
    );
  }

  // ── Single feature row ──────────────────────────────────────────────────────
  Widget _featureRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox icon
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white38, width: 1.5),
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.buttonOutline
                        .copyWith(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: AppTextStyles.display
                        .copyWith(color: Colors.white54, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 */