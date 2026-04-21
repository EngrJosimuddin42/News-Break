import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/news_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/publisher_avatar.dart';
import '../../reels/full_screen_video_player.dart';

class CategoryNewsCard extends StatelessWidget {
  final NewsModel news;
  const CategoryNewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final bool hasVideo = news.videoUrl != null && news.videoUrl!.isNotEmpty;
    final controller = Get.find<HomeController>();

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Publisher Header
            _buildHeader(controller),
      GestureDetector(
        onTap: () {
          if (hasVideo) {
            Get.to(() => FullScreenVideoPlayer(url: news.videoUrl!));
          } else {
            Get.toNamed(Routes.NEWS_DETAIL, arguments: news);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Media Section (Image/Video Thumbnail)
            _buildMedia(hasVideo),

            // Category & Time
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: Row(
                children: [
                  Text(news.category, style: AppTextStyles.overline),
                  Text(' · ${news.timeAgo}', style: AppTextStyles.labelSmall),
                ],
              ),
            ),

            //  Title
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: Text(news.title, style: AppTextStyles.buttonOutline, maxLines: 3, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
            // Engagement Row
            _buildEngagementRow(controller),
          ],
        ),
      );
    }

  // Header Widget
  Widget _buildHeader(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Row(
        children: [
          PublisherAvatar(news: news),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(news.publisherName, style: AppTextStyles.bodyMedium),
                    if (news.isVerified) ...[
                      const SizedBox(width: 6),
                      Image.asset('assets/icons/verified.png', width: 20, height: 20),
                    ],
                  ],
                ),
                Text('${news.publisherType ?? ""} · ${news.totalFollowers ?? "0"} followers', style: AppTextStyles.overline.copyWith(color: AppColors.textTertiary)),
              ],
            ),
          ),
          FollowButton(news: news),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => controller.hideNews(news),
            child: const Icon(Icons.close, color: Color(0xFF6C6C6C), size: 20),
          ),
        ],
      ),
    );
  }

  // Media Widget
  Widget _buildMedia(bool hasVideo) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail Image
            Image.network(
              news.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade900,
                child: const Icon(Icons.image, color: Colors.white24, size: 48),
              ),
            ),

            // Play Icon Overlay for Videos
            if (hasVideo)
              Center(
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2)),
                   child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Engagement Row Widget
  Widget _buildEngagementRow(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/icons/reactions.png', width: 50, height: 20),
              const SizedBox(width: 4),
              Text(news.reactions, style: AppTextStyles.labelMedium),
            ],
          ),
          Row(
            children: [
              Obx(() {
                final isLiked = controller.isLiked(news.id);
                return _engagementItem(
                  isLiked ? 'assets/icons/like_filled.png' : 'assets/icons/like.png',
                  news.likes,
                  onTap: () => controller.onLikePressed(news),
                  color: isLiked ? Colors.blue : Colors.white,
                );
              }),
              const SizedBox(width: 16),
              _engagementItem('assets/icons/comment.png', news.comments,
                onTap: () => controller.onCommentPressed(news)),
              const SizedBox(width: 16),
              _engagementItem('assets/icons/share.png', 'Share',
                onTap: () => controller.onSharePressed(news)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _engagementItem(String asset, String label, {required VoidCallback onTap, Color color = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Image.asset(asset, width: 20, height: 20, color: color),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.labelMedium.copyWith(color: color)),
        ],
      ),
    );
  }
}