import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';
import '../../models/news_model.dart';
import '../../models/user_model.dart';
import '../../modules/ai/nbot_sheet.dart';

class NotificationController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  var allowNotification = true.obs;
  var soundVibration = true.obs;
  var localNews = true.obs;
  var breakingNews = true.obs;
  var recommendedReactions = true.obs;
  var followedReactions = true.obs;
  var forYou = true.obs;
  var localDeals = true.obs;
  var commentReplies = true.obs;
  var doNotDisturb = true.obs;
  var frequency = 0.5.obs;
  var isLockScreenEnabled = false.obs;


  static const List<String> tabs = ['News', 'Likes', 'Replies', 'Follows', 'Others'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  void updateSwitch(String key, bool value) {}

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void updateFrequency(double value) {
    frequency.value = value;
  }

  void toggleLockScreen() {
    isLockScreenEnabled.value = !isLockScreenEnabled.value;
  }

  void showLessAbout(String topic) {
    AppSnackbar.success(message:
      "We'll show you fewer stories about $topic.");
  }

  void blockSource(String sourceName) {
    AppSnackbar.error(message:
      "You won't see stories from $sourceName anymore.");
  }

  void openSupportChat() {
    Get.bottomSheet(
      const NBotSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }


  final RxList<NewsModel> newsItems = <NewsModel>[
    NewsModel(
      id: 1,
      category: 'Breaking News',
      title: 'FCC chair threatens over Iran war coverage',
      publisherName: 'USA TODAY',
      author: 'Hary',
      publisherMeta: 'Partner publisher',
      timeAgo: '9h',
      imageUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=200',
      body: 'Full news content goes here...',
      likes: '1.4K',
      reactions: '1.4K',
      comments: '4.3k',
      shares: '2.8k',
    ),
    NewsModel(
      id: 2,
      category: 'Breaking News',
      title: 'FCC chair threatens over Iran war coverage',
      publisherName: 'USA TODAY',
      author: 'Hary',
      publisherMeta: 'Partner publisher',
      timeAgo: '9h',
      imageUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=200',
      videoUrl: 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
      body: 'Full news content goes here...',
      likes: '1.4K',
      reactions: '1.4K',
      comments: '4.3k',
      shares: '2.8k',
    ),
    NewsModel(
      id: 3,
      category: 'Breaking News',
      title: 'FCC chair threatens over Iran war coverage',
      author: 'John Doe',
      publisherName: 'BBC News',
      publisherMeta: 'Global News Network',
      timeAgo: '9h',
      imageUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=200',
      body: 'Detailed report on trade policies...',
      reactions: '900',
      likes: '1K',
      comments: '1.2k',
      shares: '2.8k',
    ),
  ].obs;

  final RxList<UserModel> followItems = <UserModel>[
    UserModel(
      name: 'Banny',
      email: 'banny@example.com',
      profileImageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=100',
      timeAgo: '1h',
      isHighlighted: true,
    ),
    UserModel(
      name: 'James K.',
      email: 'james@example.com',
      profileImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      timeAgo: '3h',
      isHighlighted: false,
    ),
    UserModel(
      name: 'Sophia Lee',
      email: 'sophia@example.com',
      profileImageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      timeAgo: '5h',
      isHighlighted: false,
    ),
    UserModel(
      name: 'Marcus T.',
      email: 'marcus@example.com',
      profileImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      timeAgo: '1d',
      isHighlighted: false,
    ),
  ].obs;

}