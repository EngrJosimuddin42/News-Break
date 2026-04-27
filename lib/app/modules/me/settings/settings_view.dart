import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/location/choose_location_sheet.dart';
import 'package:news_break/app/modules/me/settings/privacy_view.dart';
import 'package:news_break/app/modules/me/settings/send_feedback_sheet.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../controllers/me/settings/settings_controller.dart';
import '../../../controllers/notification/notification_controller.dart';
import '../../notification/notification_settings_view.dart';
import 'about/about_view.dart';
import 'discover_app_view.dart';
import 'help_center/help_support_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController(), permanent: true);
    final settings = Get.put(SettingsController(), permanent: true);

    return Obx(() {
      bool isDark = settings.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.blueGrey,
        appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: Text('Settings', style: AppTextStyles.displaySmall),
            centerTitle: true,
            leading: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back_ios, color: AppColors.textOnDark, size: 20))),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 16),

                  // Manage Location
                  _settingsTile(
                      iconPath: 'assets/icons/location1.png',
                      title: 'Manage Location',
                      onTap: () => Get.to(() => const ChooseLocationSheet())),

                  // Notification
                  _settingsTile(
                      iconPath: 'assets/icons/notification.png',
                      title: 'Notification',
                      onTap: () => Get.to(() => const NotificationSettingsView())),

                  // Privacy
                  _settingsTile(
                      iconPath: 'assets/icons/privacy.png',
                      title: 'Privacy',
                      onTap: () => Get.to(() => const PrivacyView())),

                  // Dark mode
                  _settingsTile(
                    iconPath: 'assets/icons/dark_mode.png',
                    title: 'Dark mode',
                    showArrow: false,
                    trailing: SizedBox(
                        height: 12,
                        child: Transform.scale(
                            scale: 0.7,
                            alignment: Alignment.centerRight,
                        child:Switch(
                            value: SettingsController.to.isDarkMode.value,
                            onChanged: (bool newValue) { SettingsController.to.toggleDarkMode(newValue);},
                            activeColor: AppColors.textGreen,
                            thumbColor: const WidgetStatePropertyAll(Colors.black)))),
                    onTap: () { SettingsController.to.toggleDarkMode(
                        !SettingsController.to.isDarkMode.value);
                    },
                  ),

                  // Language
                  _settingsTile(
                      iconPath: 'assets/icons/language.png',
                      title: 'Language',
                      onTap: () => SettingsController.to.showLanguagePicker()),

                  // Text size
                  _settingsTile(
                      iconPath: 'assets/icons/text.png',
                      title: 'Text size',
                      onTap: () => _showTextSizePicker()),

                  const SizedBox(height: 8),

                  // Help center
                  _settingsTile(
                      iconPath: 'assets/icons/help.png',
                      title: 'Help center',
                      onTap: () => Get.to(() => const HelpSupportView())),

                  // Send feedback — bottom sheet
                  _settingsTile(
                      iconPath: 'assets/icons/feedback.png',
                      title: 'Send feedback',
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            constraints: const BoxConstraints(maxWidth: double.infinity),
                            builder: (_) => const SendFeedbackSheet());
                      }),

                  // Discover app
                  _settingsTile(
                      iconPath: 'assets/icons/discovery.png',
                      title: 'Discover app',
                      onTap: () => Get.to(() => const DiscoverAppView())),

                  // About us
                  _settingsTile(
                      iconPath: 'assets/icons/about.png',
                      title: 'About us',
                      onTap: () => Get.to(() => const AboutView())),

                ],
              ),
            ),

            // Log out button
            Obx(() {
              final user = AuthController.to.user.value;
              if (user == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                child: GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: Container(width: 335, height: 48,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        color: AppColors.linkColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Text('Log out', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      );
    }
    );
  }

  // Settings tile
  Widget _settingsTile({
    required String iconPath,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF26272D))),
        child: Row(
          children: [
            Image.asset( iconPath, width: 16, height: 16),
            const SizedBox(width: 10),
            Expanded(
                child: Text(title, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white))),
            if (trailing != null) trailing,
            if (trailing == null && showArrow)
              const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
          ],
        ),
      ),
    );
  }

  void _showTextSizePicker() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF282828),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close, color: Colors.white, size: 20))),

              _buildTextSizeOption('Small'),
              const Divider(color: Color(0xFFDEDEE8), height: 1),
              _buildTextSizeOption('Medium'),
              const Divider(color: Color(0xFFDEDEE8), height: 1),
              _buildTextSizeOption('Large'),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextSizeOption(String size) {
    return Obx(() {
      bool isSelected = SettingsController.to.selectedTextSize.value == size;
      return ListTile(
        title: Text(size, style: AppTextStyles.caption),
        trailing: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? Color(0xFF257A5D): Color(0xFFA6A7AC), width: 2)),
            child: isSelected
                ? Icon(Icons.check, size: 14, color: Color(0xFF257A5D))
                : const SizedBox(width: 14, height: 14)),
        onTap: () {
          SettingsController.to.changeTextSize(size);
          Get.back();
        },
      );
    });
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF282828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Log out', style: AppTextStyles.caption.copyWith(fontSize: 18)),
              const SizedBox(height: 12),
              Text('Are you sure you want to log out?', textAlign: TextAlign.center,
                  style: AppTextStyles.labelMedium),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  GestureDetector(
                      onTap: () => Get.back(),
                      child:Text('Cancel', style: AppTextStyles.headlineMedium)),
                  // Logout Button
                  GestureDetector(
                      onTap: () {
                        Get.back();
                        AuthController.to.logout();
                      },
                      child:Text('Logout', style:  AppTextStyles.headlineMedium.copyWith(color: AppColors.linkColor))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}