import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/notification/notification_controller.dart';
import '../../models/news_model.dart';
import '../../widgets/bottom_sheet_handle.dart';

class OptionsBottomSheet {
  static void show(BuildContext context, {
    required NewsModel news,
    required Widget reportSheet,
  }) {
    final controller = Get.find<NotificationController>();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF252525),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetHandle(),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF444444),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                _optionTile(
                  icon: Icons.thumb_down_outlined,
                  iconColor: Colors.white,
                  title: 'Show less about: ${news.author}',
                  onTap: () {
                    // আগে শিট ক্লোজ করুন যাতে Snackbar সামনে দেখা যায়
                    Get.back();
                    // তারপর লজিক কল করুন
                    controller.showLessAbout(news.author);
                  },
                ),

                _optionTile(
                  icon: Icons.thumb_down_outlined,
                  iconColor: Colors.white,
                  title: 'Show less about: ${news.category}',
                  onTap: () {
                    Get.back();
                    controller.showLessAbout(news.category);
                  },
                ),

                _optionTile(
                  icon: Icons.block,
                  iconColor: Colors.white,
                  title: 'Block source: ${news.publisherName}',
                  onTap: () {
                    Get.back();
                    controller.blockSource(news.publisherName);
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
              borderRadius: BorderRadius.circular(12),
            ),
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
          const SizedBox(height: 24),
        ],
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
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}