import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../controllers/social_interaction_controller.dart';

class OptionsSheet extends StatelessWidget {
  final dynamic reelId;
  final String authorName;

  const OptionsSheet({
    super.key,
    required this.reelId,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    final reelsController = Get.find<ReelsController>();
    final socialCtrl = Get.find<SocialInteractionController>();

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          Container(width: 40, height: 5,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20))),
          const SizedBox(height: 24),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 20),
            decoration: BoxDecoration(
                color: const Color(0xFF444444),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                _optionTile(
                    icon: Icons.copy_all_outlined,
                    label: 'Copy link',
                    onTap: () => reelsController.onShareOptionTap(reelId, 'Copy link')),
                _divider(),
                _optionTile(
                    icon: Icons.share_outlined,
                    label: 'Share this content',
                    onTap: () => reelsController.onShareOptionTap(reelId, 'More')),
                _divider(),
                _optionTile(
                    icon: Icons.block_flipped,
                    label: 'Block : $authorName',
                    onTap: () => socialCtrl.blockUser(authorName)),
                _divider(),
                _optionTile(
                    icon: Icons.report_gmailerrorred_outlined,
                    iconColor: Colors.redAccent,
                    label: 'Report content',
                    labelColor: Colors.redAccent,
                    showChevron: true,
                    onTap: () => reelsController.reportComment(reelId, context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(
        color: Colors.white10, height: 1, indent: 52, endIndent: 16);
  }

  Widget _optionTile({
    required IconData icon,
    Color iconColor = Colors.white,
    required String label,
    Color labelColor = Colors.white,
    bool showChevron = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(label,
          style: AppTextStyles.caption.copyWith(color: labelColor)),
      trailing: showChevron
          ? Icon(Icons.chevron_right, color: AppColors.surface, size: 20)
          : null,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}