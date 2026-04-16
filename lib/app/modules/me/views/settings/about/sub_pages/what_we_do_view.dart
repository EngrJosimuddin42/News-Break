import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../../../controllers/what_we_do_controller.dart';
import 'creator_page_view.dart';
import 'help_widgets.dart';

class WhatWeDoView extends StatelessWidget {
   WhatWeDoView({super.key});

  final WhatWeDoController controller = Get.put(WhatWeDoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelpWidgets.helpAppBar('Help Center'),
      body: Column(
        children: [
          const HelpTabBar(),
          Expanded(
            child: ListView(
              children: [
                // Hero section
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(controller.userStats,
                          style: AppTextStyles.caption.copyWith(color: AppColors.linkColor)),
                      const SizedBox(height: 8),
                      Text(controller.welcomeHeadline,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.chart.copyWith(color: Colors.black)),
                      const SizedBox(height: 16),
                      Image.asset(controller.heroImagePath)
                    ],
                  ),
                ),

                // Stay alert section
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(controller.safetyTitle,
                          textAlign: TextAlign.center,
                          style:AppTextStyles.headlineLarge.copyWith(fontWeight: FontWeight.w400)),
                      const SizedBox(height: 12),
                       Text(controller.safetyDesc,
                        textAlign: TextAlign.center,
                        style:AppTextStyles.caption.copyWith(color: Color(0xFF525C5E)),
                      ),
                      const SizedBox(height: 16),
                      Image.asset(controller.safetyImagePath)                    ],
                  ),
                ),

                // CTA Sections (Contributors, Publishers, Advertisers)
                ...controller.ctaSections.map((section) => _ctaSection(
                  tag: section.tag,
                  title: section.title,
                  subtitle: section.subtitle,
                  buttonLabel: section.buttonLabel,
                  onTap: () => Get.to(() => CreatorPageView(pageKey: section.pageKey)),
                )),
                HelpWidgets.helpFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _ctaSection({
    required String tag,
    required String title,
    required String subtitle,
    required String buttonLabel,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(tag,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.linkColor)),
          const SizedBox(height: 8),
          Text(title,
              style: AppTextStyles.title),
          const SizedBox(height: 8),
          Text(subtitle,
              style:AppTextStyles.overline.copyWith(color: Color(0xFF525C5E))),
          const SizedBox(height: 24),
          SizedBox(
            width: 190,
            height: 48,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.linkColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(68)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(buttonLabel,
                  style:AppTextStyles.buttonOutline),
            ),
          ),
        ],
      ),
    );
  }
}
