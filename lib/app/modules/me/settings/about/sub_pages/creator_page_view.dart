import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../../controllers/me/creator_page_controller.dart';
import '../../../../../models/creator_page_model.dart';
import '../../../../../widgets/help_widgets.dart';


class CreatorPageView extends StatelessWidget {
  final String pageKey;

  const CreatorPageView({super.key, required this.pageKey});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreatorPageController());

    controller.loadPageData(pageKey);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(backgroundColor: Colors.white,
          body: Center(
              child: CircularProgressIndicator(color: AppColors.linkColor)),
        );
      }
      final data = controller.currentPageData.value;

      if (data == null) return const SizedBox.shrink();

      return _buildCreatorPage(
        context: context,
        data: data,
        primaryOnTap: () {},
        secondaryOnTap: () {},
      );
    });
  }

  Widget _buildCreatorPage({
    required BuildContext context,
    required HelpPageData data,
    required VoidCallback primaryOnTap,
    VoidCallback? secondaryOnTap,
  }) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelpWidgets.helpAppBar('Help Center'),
      body: Column(
        children: [
          const HelpTabBar(),
          Expanded(
            child: ListView(
              children: [
                // Hero Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.heroTitle, style: AppTextStyles.chart.copyWith(color: Colors.black)),
                      const SizedBox(height: 8),
                      Text(data.heroDesc, style: AppTextStyles.overline.copyWith(color: Color(0xFF6C6C6C))),

                      // Primary Button Logic
                      if (data.primaryBtn != null) ...[
                        const SizedBox(height: 24),
                        Center(child: _customButton(data.primaryBtn!,
                            primaryOnTap, isPrimary: true)),
                      ],

                      // Secondary Button Logic
                      if (data.secondaryBtn != null) ...[
                        const SizedBox(height: 10),
                        Center(child: _customButton(data.secondaryBtn!,
                            secondaryOnTap ?? () {}, isPrimary: false)),
                      ],
                    ],
                  ),
                ),

                // Mission Section
                _buildMissionSection(data),

                // Stats Section
                Center(child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Text(data.statsTitle, style: AppTextStyles.head))),
                ...data.stats.map((stat) => _buildStatTile(stat)),

                const SizedBox(height: 8),
                HelpWidgets.helpFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customButton(String label, VoidCallback onTap,
      {required bool isPrimary}) {
    return SizedBox( width: 335, height: 48,
      child: isPrimary
          ? ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.linkColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(68))),
        child: Text(label, style: AppTextStyles.buttonOutline))
          : OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFFEDEDED),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(68))),
        child: Text(label, style: AppTextStyles.buttonOutline.copyWith(color: AppColors.linkColor))),
    );
  }

  Widget _buildMissionSection(HelpPageData data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HelpWidgets.redChip(data.chip),
          const SizedBox(height: 8),
          Text(data.missionTitle, style: AppTextStyles.chart.copyWith(color: Colors.black)),
          const SizedBox(height: 8),
          Text(data.missionDesc, style: AppTextStyles.overline.copyWith(color: Color(0xFF6C6C6C))),
          const SizedBox(height: 16),
          Center(
              child: SizedBox(
              width: double.infinity, height: 180,
              child: Image.asset('assets/images/help_person.png'))),
        ],
      ),
    );
  }

  Widget _buildStatTile(Map<String, String> stat) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stat['number']!, style: AppTextStyles.headlineLarge.copyWith(color: Colors.black)),
          const SizedBox(height: 4),
          Text(stat['label']!, style: AppTextStyles.label),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFFEDEDED), height: 1),
          const SizedBox(height: 8),
          Text(stat['desc']!, style: AppTextStyles.caption.copyWith(color: Colors.black)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}