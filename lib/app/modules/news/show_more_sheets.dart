import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/reels/reels_controller.dart';
import '../../models/news_model.dart';
import '../../models/reel_model.dart';
import '../../routes/app_pages.dart';
import '../../widgets/bottom_sheet_handle.dart';
import '../reels/share_sheet.dart';

class NewsBottomSheets {
  static void showMoreSheet(BuildContext context, NewsModel news) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width),
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetHandle(),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [

                    _topActionCard(icon:Icons.bookmark_border, label: 'Save', onTap: () {}),
                    const SizedBox(width: 10),

                    _topActionCard( assetPath: 'assets/icons/share.png', label: 'Share', onTap: (){
                      Get.back();
                      if (!Get.isRegistered<ReelsController>()) {
                        Get.put(ReelsController());
                      }
                      Get.bottomSheet(
                        ShareSheet(
                            isProfileShare: true,
                          reel: ReelModel(
                            id: news.id,
                            userName: news.publisherName,
                            description: news.title,
                            userProfileImage: news.imageUrl ?? "",
                              )),
                          isScrollControlled: true);
                    }),
                    const SizedBox(width: 10),


                    _topActionCard(assetPath: 'assets/icons/plump_feather_pen.png', label: 'Short Post',onTap: () {
                      Get.back();
                      Get.toNamed(Routes.CREATE_POST);
                    },),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF444444),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _optionTile(icon: Icons.block_flipped,
                        label: 'Block source: ${news.publisherName}',
                        onTap: () => Navigator.pop(context),
                      ),
                      const Divider(color: Colors.white12, height: 1, indent: 16, endIndent: 16),
                      _optionTile(icon: Icons.report_gmailerrorred, iconColor:AppColors.linkColor, label: 'Report', labelColor: AppColors.linkColor, onTap: () {}),
                      const Divider(color: Colors.white12, height: 1, indent: 16, endIndent: 16),
                      _optionTile(icon: Icons.report_gmailerrorred, iconColor:AppColors.linkColor, label: 'Report Ad', labelColor: AppColors.linkColor, onTap: () {}),
                      const Divider(color: Colors.white12, height: 1, indent: 16, endIndent: 16),
                      _optionTile(icon: Icons.report_gmailerrorred, iconColor: AppColors.linkColor, label: 'Try Ad-free', labelColor:AppColors.linkColor, onTap: () {}),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _optionTile(
                    assetPath: 'assets/icons/add.png',
                    iconColor: Color(0xFF8FBFFA),
                    label: 'Ask/request/report anything',labelColor:AppColors.textOnDark,
                    onTap: () => Navigator.pop(context)))),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  static Widget _topActionCard({
    IconData? icon,
    String? assetPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF444444),
            borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          assetPath != null
          ? Image.asset(assetPath, width: 28, height: 28, color: Colors.white)
                : Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
              Text(label, style:AppTextStyles.labelMedium),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _optionTile({
    IconData? icon,
    String? assetPath,
    Color iconColor = Colors.white,
    required String label,
    Color labelColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: assetPath != null
          ? Image.asset(
        assetPath,
        width: 20,
        height: 20,
        color: iconColor)
          : Icon(icon, color: iconColor, size: 20),
      title: Text(label, style: AppTextStyles.caption.copyWith(color: labelColor)),
      onTap: onTap,
      dense: false,
    );
  }
}