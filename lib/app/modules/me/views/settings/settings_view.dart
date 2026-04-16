import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/me/views/settings/about/about_view.dart';
import 'package:news_break/app/modules/me/views/settings/discover_app_view.dart';
import 'package:news_break/app/modules/me/views/settings/help_center/help_support_view.dart';
import 'package:news_break/app/modules/me/views/settings/location_view.dart';
import 'package:news_break/app/modules/me/views/settings/privacy_view.dart';
import 'package:news_break/app/modules/me/views/settings/send_feedback_sheet.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../notification/controllers/notification_controller.dart';
import '../../../notification/views/notification_settings_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NotificationController());
    return Obx(() {
      bool isDark = AuthController.to.isDarkMode.value;
      String lang = AuthController.to.selectedLanguage.value;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: AppColors.textOnDark, size: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 8),

                // Manage Location
                _settingsTile(
                  iconPath: 'assets/icons/location1.png',
                  title: 'Manage Location',
                  subtitle: 'Manage your primary and followed location',
                  onTap: () => Get.to(() => const LocationView()),
                ),

                // Notification
                _settingsTile(
                  iconPath: 'assets/icons/notification.png',
                  title: 'Notification',
                  subtitle: 'Choose what and how often to get alerted',
                  trailing: Obx(() {
                    final notificationCtrl = Get.find<NotificationController>();
                    return Text( notificationCtrl.allowNotification.value ? 'on' : 'off',
                      style: AppTextStyles.overline,
                    );
                  }),
                  onTap: () => Get.to(() => const NotificationSettingsView()),
                ),

                // Privacy
                _settingsTile(
                  iconPath: 'assets/icons/privacy.png',
                  title: 'Privacy',
                  subtitle: 'Choose your privacy settings',
                  onTap: () => Get.to(() => const PrivacyView()),
                ),

                // Dark mode
                    _settingsTile(
                      iconPath: 'assets/icons/dark_mode.png',
                      title: 'Dark mode',
                      trailing: Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          value: AuthController.to.isDarkMode.value,
                          onChanged: (bool newValue) {
                            AuthController.to.toggleDarkMode(newValue);
                          },
                          activeColor: AppColors.textGreen,
                          thumbColor: const WidgetStatePropertyAll(
                              Colors.black),
                        ),
                      ),
                      onTap: () {
                        AuthController.to.toggleDarkMode(
                            !AuthController.to.isDarkMode.value);
                      },
                    ),

                // Language
                    _settingsTile(
                      iconPath: 'assets/icons/language.png',
                      title: 'Language',
                      trailing: Text(lang, style: AppTextStyles.overline),
                      onTap: () => _showLanguagePicker(),
                    ),

                // Text size
                _settingsTile(
                  iconPath: 'assets/icons/text.png',
                  title: 'Text size',
                  trailing: Obx(() => Text(AuthController.to.selectedTextSize.value, style: AppTextStyles.overline)),
                  onTap: () => _showTextSizePicker(),
                ),

                const SizedBox(height: 8),

                // Help center
                _plainTile(
                    'Help center', () => Get.to(() => const HelpSupportView())),

                // Send feedback — bottom sheet
                _plainTile('Send feedback', () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    constraints: const BoxConstraints(
                        maxWidth: double.infinity),
                    builder: (_) => const SendFeedbackSheet(),
                  );
                }),

                // Discover app
                _plainTile('Discover app', () =>
                    Get.to(() => const DiscoverAppView())),

                // About us
                _plainTile('About us', () => Get.to(() => const AboutView())),

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
                child: Container(
                  width: 335,
                  height: 70,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.linkColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text('Log out',
                        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w400)
                      ),
                      const SizedBox(height: 2),
                      Text(user.email,
                        style:AppTextStyles.labelSmall.copyWith(color:AppColors.background),
                      ),
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

  // ── Settings tile ────────────────────────────
  Widget _settingsTile({
    required String iconPath,
    required String title,
    String? subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              width: 14,
              height: 14,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTextStyles.large),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: AppTextStyles.overline),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  // ── Plain tile ───────────────────────────────
  Widget _plainTile(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Text(title,
            style: AppTextStyles.large),
      ),
    );
  }

  // ── Language picker ──────────────────────────
  void _showLanguagePicker() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF282828),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  Text('Language',
                      style: AppTextStyles.displaySmall.copyWith(fontWeight: FontWeight.w500)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      },
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              _buildLanguageButton('English'),

              const SizedBox(height: 12),

              _buildLanguageButton('Bangla'),

              const SizedBox(height: 12)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String lang) {
    return GestureDetector(
    onTap: () {
      AuthController.to.changeLanguage(lang);
      Get.back();
    },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.linkColor,
          borderRadius: BorderRadius.circular(70),
        ),
        child: Center(
          child: Text(lang,
            style:AppTextStyles.bodySmall),
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
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),

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
      bool isSelected = AuthController.to.selectedTextSize.value == size;
      return ListTile(
        title: Text(size,
          style: AppTextStyles.caption,
        ),
        trailing: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Color(0xFF257A5D): Color(0xFFA6A7AC),
              width: 2,
            ),
          ),
          child: isSelected
              ? Icon(Icons.check, size: 14, color: Color(0xFF257A5D))
              : const SizedBox(width: 14, height: 14),
        ),
        onTap: () {
          AuthController.to.changeTextSize(size);
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
              Text('Log out',
                style: AppTextStyles.caption.copyWith(fontSize: 18)),
              const SizedBox(height: 12),
              Text('Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelMedium),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child:Text('Cancel',
                      style: AppTextStyles.headlineMedium),
                  ),
                  // Logout Button
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      AuthController.to.logout();
                    },
                    child:Text('Logout',
                      style:  AppTextStyles.headlineMedium.copyWith(color: AppColors.linkColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}