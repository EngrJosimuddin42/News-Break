import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/me/settings/settings_controller.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('Privacy', style: AppTextStyles.displaySmall),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textOnDark, size: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // Location Toggle Section
          Obx(() => Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location', style: AppTextStyles.large.copyWith(color: Colors.white)),
                      const SizedBox(height: 6),
                      Text(
                        'Allow others to see your general location in comments, profile, and follower list',
                        style: AppTextStyles.overline.copyWith(color: Colors.white60),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox( height: 30,
                  child: Transform.scale(
                    scale: 0.7,
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: SettingsController.to.isLocationVisible.value,
                      onChanged: (val) => SettingsController.to.toggleLocationVisible(val),
                      activeColor: AppColors.textGreen,
                      thumbColor: const WidgetStatePropertyAll(Colors.black))))
              ],
            ),
          )),

          const SizedBox(height: 12),

          // Blocked Users Navigation
          _buildNavigationTile(
            title: 'Blocked',
            onTap: () => Get.to(() => const BlockedView()),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Text(title, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
          ],
        ),
      ),
    );
  }
}


class BlockedView extends StatelessWidget {
  const BlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('Blocked', style: AppTextStyles.displaySmall),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textOnDark, size: 20))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No users are blocked', style: AppTextStyles.overline.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}