import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../core/controllers/auth_controller.dart';
import '../../ai/views/nbot_sheet.dart';
import '../views/creator_onboard_view.dart';

class MeController extends GetxController {


  // AuthController থেকে check
  bool get isLoggedIn => AuthController.to.user.value != null;
  String get userName => AuthController.to.user.value?.name ?? '';
  String get userEmail => AuthController.to.user.value?.email ?? '';

  final selectedTab = 0.obs;
  final hasHistory = true.obs;

  var historyItems = [
    {
      'id': '101',
      'title': 'FCC chair threatens over Iran war coverage',
      'source': 'Robblyn',
      'timeAgo': '1d',
      'videoUrl': 'https://www.w3schools.com/html/mov_bbb.mp4',
      'thumbnailUrl': 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=400',
    },
    {
      'id': '102',
      'title': 'The future of Artificial Intelligence in 2026: What to expect',
      'source': 'TechRadar',
      'timeAgo': '5h',
      'videoUrl': 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4',
      'thumbnailUrl': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
    },
    {
      'id': '103',
      'title': 'SpaceX Starship mission reaches new milestone in Mars journey',
      'source': 'SpaceNews',
      'timeAgo': '12h',
      'videoUrl': 'https://www.w3schools.com/html/movie.mp4',
      'thumbnailUrl': 'https://images.unsplash.com/photo-1517976487492-5750f3195933?w=400',
    },
  ].obs;

  var selectedChipIndex = 0.obs;

  void updateChip(int index) => selectedChipIndex.value = index;

  void deleteSingleHistoryItem(String id) {
    historyItems.removeWhere((item) => item['id'] == id);
    if (historyItems.isEmpty) hasHistory.value = false;
  }

  void clearFullHistory() {
    historyItems.clear();
    hasHistory.value = false;
  }

  final loggedInTabs = ['Content', 'Reactions', 'Saved', 'History'];
  final loggedOutTabs = ['Saved', 'History'];

  List<String> get tabs => isLoggedIn ? loggedInTabs : loggedOutTabs;

  void onLogin() => Get.toNamed('/signin');

  void onLogout() => AuthController.to.logout();

  void onSettings() {}

  void onAI() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NBotSheet(),
    );
  }

  void onCreatorDashboard() => Get.to(() => const CreatorOnboardView());
  void onCompleteProfile() {}

  void onClearAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: Text('Clear history?', style: AppTextStyles.labelLarge),
        content: Text(
          'Are you sure you want to clear your browsing history? This action cannot be undone.',
          style: AppTextStyles.labelLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: AppTextStyles.bodyMedium),
          ),
          TextButton(
            onPressed: () {
              clearFullHistory();
              Get.back();
            },
            child: Text('Clear', style: AppTextStyles.bodyMedium),
          ),
        ],
      ),
    );
  }
}