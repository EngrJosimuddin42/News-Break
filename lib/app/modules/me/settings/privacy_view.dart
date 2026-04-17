import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../../../controllers/me/settings_controller.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:Icon(Icons.arrow_back_ios, color:AppColors.textOnDark, size: 20),
        ),
        title:Text('Privacy',
          style:AppTextStyles.displaySmall),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // Location toggle
          Obx(() => Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location',
                          style:AppTextStyles.large),
                      const SizedBox(height: 4),
                      Text('Allow others to see your general location in comments, profile, and follower list',
                        style:AppTextStyles.overline,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: SettingsController.to.isLocationVisible.value,
                    onChanged: (val) => SettingsController.to.toggleLocationVisible(val),
                    thumbColor: const WidgetStatePropertyAll(Colors.black),
                ),
    )
              ],
            ),
          ),
    ),

          // Blocked
          GestureDetector(
            onTap: () => Get.to(() => const BlockedView()),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                children: [
                  Text('Blocked',
                      style:AppTextStyles.bodyMedium),
                  const Spacer(),
                  Icon(Icons.chevron_right,color:AppColors.surface, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Blocked View ─────────────────────────────
class BlockedView extends StatelessWidget {
  const BlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:Icon(Icons.arrow_back_ios, color:AppColors.textOnDark, size: 20),
        ),
        title:Text('Blocked',
          style: AppTextStyles.displaySmall),
        centerTitle: true,
      ),
      body: Center(
        child: Text('No user are blocked',
          style: AppTextStyles.overline,
        ),
      ),
    );
  }
}