import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../models/reel_model.dart';
import '../share_sheet.dart';

class ProfileOptionSheet {
  static void showOptions(BuildContext context, {
    required dynamic user,
    VoidCallback? onBlockConfirm,
    Function(String reason)? onReportSubmit,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      builder: (_) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
            color: Color(0xFF252525),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              _buildHandle(),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF444444),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    ListTile(
                        leading: Image.asset('assets/icons/share.png', height: 20, width: 20),
                        title: Text('Share this profile', style: AppTextStyles.caption),
                        onTap: () {
                          Get.back();
                          final reelDataForProfile = ReelModel(
                              id: user?.id ?? 0,
                              userName: user?.userName ?? "Unknown",
                              userProfileImage: user?.userProfileImage ?? "",
                              imageUrl: user?.userProfileImage ?? "");

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                            builder: (_) => ShareSheet(reel: reelDataForProfile, isProfileShare: true),
                          );
                        },
                        dense: true),
                    const Divider(color: Colors.white10, height: 1, indent: 16, endIndent: 16),
                    ListTile(
                        leading: const Icon(Icons.block_flipped, color: Colors.white, size: 20),
                        title: Text('Block', style: AppTextStyles.caption),
                        onTap: () {
                          Get.back();
                          _showBlockConfirm(context, onBlockConfirm);
                        },
                        dense: true),
                    const Divider(color: Colors.white10, height: 1, indent: 16, endIndent: 16),
                    ListTile(
                        leading: Icon(Icons.report_gmailerrorred_outlined, color: AppColors.linkColor, size: 20),
                        title: Text('Report user', style: AppTextStyles.caption.copyWith(color: AppColors.linkColor)),
                        onTap: () {
                          Get.back();
                          _showReportSheet(context, onReportSubmit);
                        },
                        dense: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static void _showBlockConfirm(BuildContext context, VoidCallback? onBlock) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF333333),
        title: Text('Are you sure?', style: AppTextStyles.caption),
        content: Text('If you block this user, you\'ll not see any content from this user.', style: AppTextStyles.caption),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel', style: AppTextStyles.headlineMedium)),
          TextButton(
              onPressed: () {
                Get.back();
                if (onBlock != null) onBlock();
              },
              child: Text('Block', style: AppTextStyles.headlineMedium.copyWith(color: Colors.red))),
        ],
      ),
    );
  }

  static void _showReportSheet(BuildContext context, Function(String reason)? onReport) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      builder: (_) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
            color: Color(0xFF252525),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              _buildHandle(),
              const SizedBox(height: 24),
              Text('Report User', style: AppTextStyles.caption),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(color: const Color(0xFF444444), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    _buildReportItem(context, 'Report user name', onReport),
                    const Divider(color: Colors.white10, height: 1, indent: 16, endIndent: 16),
                    _buildReportItem(context, 'Report user avatar', onReport),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildReportItem(BuildContext context, String title, Function(String reason)? onReport) {
    return ListTile(
        title: Text(title, style: AppTextStyles.caption),
        onTap: () {
          Get.back();
          if (onReport != null) {
            onReport(title);
            _showSuccessSheet(context);
          }
        });
  }

  static void _showSuccessSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
            color: Color(0xFF252525),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _buildHandle()),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  Text('Thanks for letting us know', style: AppTextStyles.caption),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text('your feedback is important in helping us keep our community safe', style: AppTextStyles.overline)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isBottomSheetOpen ?? false) Get.back();
    });
  }

  static Widget _buildHandle() {
    return Container(width: 40, height: 5,
      decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(20)),
    );
  }
}