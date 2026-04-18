import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';

class ThreeDotSheet extends StatelessWidget {
  final int reelId;
  final String authorName;
  final VoidCallback onShare;
  final VoidCallback onSave;
  final VoidCallback onReport;

  const ThreeDotSheet({
    super.key,
    required this.reelId,
    required this.authorName,
    required this.onShare,
    required this.onSave,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReelsController>();
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Handle Bar
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600], borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF444444),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _optionTile(
                          icon: 'assets/icons/share.png',
                          iconColor: AppColors.surface,
                          label: 'Share',
                          onTap: onShare,
                        ),
                        const Divider(color: Colors.white12, height: 1),

                        Obx(() {
                          bool isSaved = controller.savedReels.contains(reelId);
                          return _optionTile(
                            icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                            iconColor: isSaved ? Colors.blueAccent : AppColors.surface,
                            label: isSaved ? 'Saved' : 'Save',
                            onTap: () => controller.saveReel(reelId),
                          );
                        }),

                        const Divider(color: Colors.white12, height: 1),
                        _optionTile(
                          icon: Icons.not_interested,
                          iconColor: AppColors.surface,
                          label: 'Show less from author: $authorName',
                          onTap: () => controller.hideAuthorContent(authorName),
                        ),
                        const Divider(color: Colors.white12, height: 1),
                        _optionTile(
                          icon: Icons.report_gmailerrorred_outlined,
                          iconColor: AppColors.linkColor,
                          label: 'Report',
                          labelColor: AppColors.linkColor,
                          trailing: Icon(Icons.chevron_right, color: AppColors.surface, size: 20),
                          onTap: onReport,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _optionTile(
                      icon: 'assets/icons/add.png',
                      iconColor: Colors.blueAccent,
                      label: 'Ask/request/report anything',
                      onTap: () => controller.openHelpCenter(),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionTile({
    dynamic icon,
    required Color iconColor,
    required String label,
    Color labelColor = Colors.white,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: icon is IconData
          ? Icon(icon, color: iconColor, size: 20)
          : Image.asset(icon, color: iconColor, width: 20, height: 20),
      title: Text(label,
          style: AppTextStyles.caption.copyWith(color: labelColor)),
      trailing: trailing,
      onTap: onTap,
      dense: true,
    );
  }
}