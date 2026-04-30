import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../controllers/notification/notification_controller.dart';
import '../controllers/social_interaction_controller.dart';
import '../models/news_model.dart';
import '../models/reel_model.dart';
import '../models/socials_model.dart';
import 'bottom_sheet_handle.dart';

class OptionsBottomSheet {
  static void show(BuildContext context, {
    required dynamic news,
    required Widget reportSheet,
  }) {
    final controller = Get.find<NotificationController>();
    final socialCtrl = Get.find<SocialInteractionController>();

    String author = 'Author';
    String category = 'Category';
    String publisher = 'Source';

    if (news is NewsModel) {
      author = news.author;
      category = news.category;
      publisher = news.publisherName;
    } else if (news is ReelModel) {
      author = news.userName;
      category = 'Reels';
      publisher = news.userName;
    } else if (news is SocialsModel) {
      author = news.userName;
      category = news.category;
      publisher = news.userName;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF252525),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHandle(),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color(0xFF444444),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  _optionTile(
                    icon: Icons.thumb_down_outlined,
                    iconColor: Colors.white,
                    title: 'Show less about: $author',
                    onTap: () {
                      Get.back();
                      socialCtrl.showLessAbout(author);
                    },
                  ),

                  _optionTile(
                    icon: Icons.thumb_down_outlined,
                    iconColor: Colors.white,
                    title: 'Show less about: $category',
                    onTap: () {
                      Get.back();
                      socialCtrl.showLessAbout(category);
                    },
                  ),


                  _optionTile(
                    icon: Icons.block,
                    iconColor: Colors.white,
                    title: 'Block source: $publisher',
                    onTap: () {
                      Get.back();
                      socialCtrl.blockSource(publisher);
                    },
                  ),

                  _optionTile(
                    icon: Icons.error_outline,
                    iconColor: Colors.red,
                    title: 'Report',
                    titleColor: Colors.red,
                    onTap: () {
                      Get.back();
                      _showReportSheet(context, reportSheet);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Support/AI Request Container
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color(0xFF000000),
                  borderRadius: BorderRadius.circular(12)),
              child: _optionTile(
                icon: 'assets/icons/add.png',
                iconColor: Colors.blueAccent,
                title: 'Ask/request/report anything',
                onTap: () {
                  Get.back();
                  controller.openSupportChat();
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  static void _showReportSheet(BuildContext context, Widget reportSheet) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        builder: (_) => reportSheet);
  }

  static Widget _optionTile({
    required dynamic icon,
    required Color iconColor,
    required String title,
    Color titleColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            if (icon is String)
              Image.asset(icon, width: 20, height: 20, color: iconColor)
            else
              Icon(icon as IconData, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
                child: Text(title, style: AppTextStyles.caption.copyWith(color: titleColor),
                    overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}