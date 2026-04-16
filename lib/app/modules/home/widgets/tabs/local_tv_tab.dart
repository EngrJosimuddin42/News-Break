import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../theme/app_colors.dart';
import 'category_news_card.dart';


class LocalTvTab extends GetView<HomeController> {
  final String message;

  const LocalTvTab({
    super.key,
    this.message = 'No relevant articles',
  });

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'Daily news',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800',
      videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      label: 'New York',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    CategoryNewsItem(
      publisherName: 'Daily news',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
      videoUrl: 'https://www.youtube.com/watch?v=Kjf7hlxfPn4',
      label: 'New York',
      timeAgo: '2h',
      title: 'Local TV Coverage: Major Event Unfolds Across the City...',
      reactions: '2.1K',
      likes: '3.4K',
      comments: '1.8K',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loggedIn = AuthController.to.user.value != null;
      return loggedIn ? _buildLoggedIn() : _buildLoggedOut();
    });
  }

  // ── Logged out — existing UI ─────────────────
  Widget _buildLoggedOut() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/socket.png',
            width: 130,
            height: 130,
          ),
          const SizedBox(height: 16),
          Text(message,
            style:AppTextStyles.caption.copyWith(color: Color(0xFF9B9B9B)),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: controller.onTryAgain,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(20),
              minimumSize: const Size(90, 50),
              side: const BorderSide(color: AppColors.linkColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
            ),
            child:Text('Try Again',
              style:AppTextStyles.caption.copyWith(color: AppColors.linkColor),
            ),
          ),
        ],
      ),
    );
  }

  // ── Logged in — video news cards ─────────────
  Widget _buildLoggedIn() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      itemCount: _items.length,
      itemBuilder: (context, index) =>
          CategoryNewsCard(item: _items[index]),
    );
  }
}