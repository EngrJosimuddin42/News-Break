import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/me/widgets/me_action_buttons.dart';
import 'package:news_break/app/modules/me/widgets/me_profile_header.dart';
import 'package:news_break/app/modules/me/widgets/me_tabs_view.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/auth/auth_controller.dart';
import '../premium/widgets/premium_banner.dart';
import '../../controllers/me/me_controller.dart';

class MeBody extends GetView<MeController> {
  const MeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loggedIn = AuthController.to.user.value != null;
      return loggedIn
          ? _buildLoggedIn(context)
          : _buildLoggedOut(context);
    });
  }

  // Logged Out
  Widget _buildLoggedOut(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              // Login button
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: ElevatedButton(
                      onPressed: controller.onLogin,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          minimumSize: const Size(335, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: Text('Log in or sign up',
                          style: AppTextStyles.bodySmall))),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                      'Keep your preferences, articles, and topics saved in your NewsBreak account.',
                      style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.info))),

              const SizedBox(height: 20),

              // Premium banner
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: PremiumBanner()),

              const SizedBox(height: 16),
              const Divider(color: Colors.white12, height: 1),
              const SizedBox(height: 16),

              // Tabs
              const MeTabsView(isLoggedIn: false),
            ],
          ),
        ),
      ],
    );
  }

  //  Logged In
  Widget _buildLoggedIn(BuildContext context) {
    return ListView(
      children: [
        // Profile header
        const MeProfileHeader(),

        SizedBox(height: 16),

        // Action buttons
        const MeActionButtons(),

        const SizedBox(height: 16),

        // Premium banner
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: PremiumBanner()),


        const SizedBox(height: 16),
        const Divider(color: Colors.white12, height: 1),
        const SizedBox(height: 16),

        // Tabs
        const MeTabsView(isLoggedIn: true),
      ],
    );
  }
}
