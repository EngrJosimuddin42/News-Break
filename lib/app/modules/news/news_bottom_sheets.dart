import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/reels/reels_controller.dart';
import '../../models/news_model.dart';
import '../../models/reel_model.dart';
import '../reels/share_sheet.dart';

class NewsBottomSheets {
  static void showCreateAccountSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.newspaper, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 12),
            const Text('Create an account',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Log in or sign up to comment',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 24),
            _socialBtn(icon: Icons.facebook, iconColor: const Color(0xFF1877F2), label: 'Continue with Facebook', onTap: () => Navigator.pop(context)),
            const SizedBox(height: 12),
            _socialBtn(icon: Icons.g_mobiledata, iconColor: Colors.red, label: 'Continue with Google', onTap: () => Navigator.pop(context)),
            const SizedBox(height: 16),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }

  static void showMoreSheet(BuildContext context, NewsModel news) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _iconAction(Icons.bookmark_border, 'Save', () {}),
                    _iconAction(Icons.share_outlined, 'Share', () {
                      Get.back();
                      if (!Get.isRegistered<ReelsController>()) {
                        Get.put(ReelsController());
                      }
                      Get.bottomSheet(
                        ShareSheet(
                          reel: ReelModel(
                            id: news.id,
                            imageUrl: news.imageUrl,
                            userProfileImage: news.publisherImageUrl,
                            userName: news.publisherName,
                            description: news.title,
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    }),
                    _iconAction(Icons.edit_outlined, 'Short Post', () {}),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _optionTile(
                      icon: Icons.block,
                      label: 'Block source: ${news.publisherName}',
                      onTap: () => Navigator.pop(context),
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    _optionTile(icon: Icons.flag_outlined, iconColor: Colors.red, label: 'Report', labelColor: Colors.red, onTap: () => Navigator.pop(context)),
                    const Divider(color: Colors.white12, height: 1),
                    _optionTile(icon: Icons.flag_circle_outlined, iconColor: Colors.red, label: 'Report Ad', labelColor: Colors.red, onTap: () => Navigator.pop(context)),
                    const Divider(color: Colors.white12, height: 1),
                    _optionTile(icon: Icons.block_outlined, iconColor: Colors.red, label: 'Try Ad-free', labelColor: Colors.red, onTap: () => Navigator.pop(context)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: _optionTile(
                  icon: Icons.auto_fix_high,
                  iconColor: Colors.blueAccent,
                  label: 'Ask/request/report anything',
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _socialBtn({required IconData icon, required Color iconColor, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  static Widget _iconAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }

  static Widget _optionTile({required IconData icon, Color iconColor = Colors.white, required String label, Color labelColor = Colors.white, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(label, style: TextStyle(color: labelColor, fontSize: 14)),
      onTap: onTap,
      dense: true,
    );
  }
}