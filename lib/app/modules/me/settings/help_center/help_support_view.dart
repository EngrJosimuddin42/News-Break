import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../controllers/me/help_center_controller.dart';
import '../../../../widgets/help_widgets.dart';
import 'help_detail_view.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpCenterController());

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: AppColors.textOnDark, size: 20)),
        title: Text('Help & Support', style: AppTextStyles.displaySmall),
        centerTitle: true),

      body: Column(
        children: [
          // Header bar
          Container( height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.surface,
            child: Row(
              children: [
                Image.asset('assets/images/newsbreak_logo.png', width: 30, height: 30),
                const SizedBox(width: 8),
                Text('Newsbreak', style: AppTextStyles.medium),
                const SizedBox(width: 30),
                Text('Help Center', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.background)),
              ],
            ),
          ),
          Expanded(child: _buildBody(controller)),
        ],
      ),
    );
  }

  Widget _buildBody(HelpCenterController controller) {
    return ListView(
      children: [
        _buildHeroBanner(controller),
        _buildCategories(controller),
        const SizedBox(height: 16),
        _buildPromotedArticlesHeader(),
        _buildPromotedArticles(controller),
        const SizedBox(height: 16),
        HelpWidgets.helpFooter(),
        const SizedBox(height: 24),
      ],
    );
  }

  //  Hero Banner with Search
  Widget _buildHeroBanner(HelpCenterController controller) {
    return Stack(
      children: [
        Image.asset('assets/images/banar_bg.png',
            width: double.infinity, height: 150,
          fit: BoxFit.cover),
        Positioned.fill(child: Container(color: Colors.black38)),
        Positioned( left: 20, right: 20, top: 30,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hi, How Can We Help You?', textAlign: TextAlign.center,
                style: AppTextStyles.displaySmall.copyWith(fontWeight: FontWeight.w400)),
              const SizedBox(height: 20),
              Container(width: 306, height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8)),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.runSearch,
                  textAlignVertical: TextAlignVertical.center,
                  style: AppTextStyles.caption.copyWith(color: Colors.black),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'search issue keywords',
                    hintStyle: AppTextStyles.overline.copyWith(fontSize: 14),
                    prefixIcon: Icon(Icons.search, color:AppColors.textOnDark, size: 22),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //  Categories
  Widget _buildCategories(HelpCenterController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Obx(() => Column(
            children: controller.displayCategories.map((cat) {
              return GestureDetector(
                onTap: cat.isClickable
                    ? () => Get.to(() => HelpDetailView(title: cat.name))
                    : null,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x40888787),
                        blurRadius: 32,
                        offset: Offset.zero),
                    ],
                  ),
                  child: Center(
                    child: Text( cat.name, style: AppTextStyles.caption.copyWith(color: AppColors.linkColor)))),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  // Promoted Articles Header
  Widget _buildPromotedArticlesHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text('Promoted Articles', style: AppTextStyles.displaySmall.copyWith(color: Colors.black)),
    );
  }

  // Promoted Articles List
  Widget _buildPromotedArticles(HelpCenterController controller) {
    return Obx(() => Column(
      children: controller.displayArticles.map((article) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text( article.title, style: AppTextStyles.overline.copyWith(fontSize: 14)))),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
          ],
        );
      }).toList(),
    ));
  }
}