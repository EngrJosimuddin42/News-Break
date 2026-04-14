import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/me/views/settings/about/about_view.dart';
import 'package:news_break/app/modules/me/views/settings/discover_app_view.dart';
import 'package:news_break/app/modules/me/views/settings/help_support_view.dart';
import 'package:news_break/app/modules/me/views/settings/location_view.dart';
import 'package:news_break/app/modules/me/views/settings/privacy_view.dart';
import 'package:news_break/app/modules/me/views/settings/send_feedback_sheet.dart';
import '../../../../core/controllers/auth_controller.dart';
import '../../../notification/views/notification_settings_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.white, size: 18),
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
                  icon: Icons.location_on_outlined,
                  title: 'Manage Location',
                  subtitle: 'Manage your primary and followed location',
                  onTap: () => Get.to(() => const LocationView()),
                ),

                // Notification
                _settingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notification',
                  subtitle: 'Choose what and how often to get alerted',
                  trailing: const Text('on',
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  onTap: () =>
                      Get.to(() => const NotificationSettingsView()),
                ),

                // Privacy
                _settingsTile(
                  icon: Icons.shield_outlined,
                  title: 'Privacy',
                  subtitle: 'Choose your privacy settings',
                  onTap: () => Get.to(() => const PrivacyView()),
                ),

                // Dark mode
                _settingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark mode',
                  trailing: Switch(
                    value: _darkMode,
                    onChanged: (val) => setState(() => _darkMode = val),
                    activeColor: Colors.blue,
                  ),
                  onTap: () => setState(() => _darkMode = !_darkMode),
                ),

                // Language
                _settingsTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  trailing: const Text('English',
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  onTap: () => _showLanguagePicker(),
                ),

                // Text size
                _settingsTile(
                  icon: Icons.text_fields,
                  title: 'Text size',
                  trailing: const Text('Medium',
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  onTap: () => _showTextSizePicker(),
                ),

                const SizedBox(height: 8),

                // Help center
                _plainTile('Help center', () => Get.to(() => const HelpSupportView())),

                // Send feedback — bottom sheet
                _plainTile('Send feedback', () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const SendFeedbackSheet(),
                  );
                }),

                // Discover app
                _plainTile('Discover app', () => Get.to(() => const DiscoverAppView())),

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
                onTap: () => AuthController.to.logout(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE57373),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.email,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
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

  // ── Settings tile ────────────────────────────
  Widget _settingsTile({
    required IconData icon,
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
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12)),
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
            style: const TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }

  // ── Language picker ──────────────────────────
  void _showLanguagePicker() {
    final languages = ['English', 'Spanish', 'French', 'German', 'Chinese'];
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text('Language',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...languages.map((lang) => ListTile(
            title: Text(lang,
                style: const TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Text size picker ─────────────────────────
  void _showTextSizePicker() {
    final sizes = ['Small', 'Medium', 'Large'];
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text('Text size',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...sizes.map((size) => ListTile(
            title: Text(size,
                style: const TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}