import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/news_model.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/publisher_avatar.dart';
import '../../reels/full_screen_video_player.dart';

class NewsCard extends StatefulWidget {
  final NewsModel news;
  final VoidCallback? onFollow;
  final VoidCallback? onDismiss;

  const NewsCard({
    super.key,
    required this.news,
    this.onFollow,
    this.onDismiss,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final news = widget.news;
    final bool hasVideo = news.videoUrl != null && news.videoUrl!.isNotEmpty;

    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Publisher Row
          _buildPublisherRow(news),
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
                // News Title (Text)
                _buildTitleSection(news),

                // Media Section (Image/Video)
                _buildMediaSection(news, hasVideo),
              ],
            ),
          ),

          // Action Row (Like/Comment)
          _buildActionRow(news),
          const Divider(color: Colors.white12, height: 1, thickness: 1),
        ],
      ),
    );
  }

  // Publisher Header
  Widget _buildPublisherRow(NewsModel news) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PublisherAvatar(news: news),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(news.publisherName, style: AppTextStyles.bodyMedium),
                    const SizedBox(width: 6),
                    Text('· ${news.timeAgo}', style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Image.asset('assets/icons/person.png', height: 14, width: 14),
                    const SizedBox(width: 3),
                    Text(news.publisherMeta, style: AppTextStyles.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          FollowButton(news: news),
        ],
      ),
    );
  }

  // Title Section with "See more"
  Widget _buildTitleSection(NewsModel news) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(68, 10, 16, 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final textStyle = AppTextStyles.bodyMedium;
          final textPainter = TextPainter(
            text: TextSpan(text: news.title, style: textStyle),
            maxLines: 1,
            textDirection: TextDirection.ltr)
            ..layout(maxWidth: constraints.maxWidth);

          if (!textPainter.didExceedMaxLines) {
            return Text(news.title, style: textStyle);
          }

          return GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: _isExpanded
                ? Text(news.title, style: textStyle)
                : RichText(
              text: TextSpan(style: textStyle,
                children: [
                  TextSpan(text: news.title),
                  TextSpan(text: ' See more', style: textStyle.copyWith(color: AppColors.textSecondary)),
                ],
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }

  // Media Section
  Widget _buildMediaSection(NewsModel news, bool hasVideo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 68),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
                news.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(height: 220,
                        color: Colors.grey[900],
                        child: const Icon(Icons.image, color: Colors.white10))),
            if (hasVideo)
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle),
                  child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40)),
          ],
        ),
      ),
    );
  }

  // Action Row
  Widget _buildActionRow(NewsModel news) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 12),
      child: Row(
        children: [
          Obx(() {
            final isLiked = controller.isLiked(news.id);
            return _engagementItem(
              isLiked
                  ? 'assets/icons/like_filled.png'
                  : 'assets/icons/like.png',
              news.likes, () => controller.onLikePressed(news),
              color: isLiked ? Colors.blue : Colors.white);
          }),
          const SizedBox(width: 80),
          _engagementItem('assets/icons/comment.png',
              news.comments, () => controller.onCommentPressed(news)
          ),
        ],
      ),
    );
  }

  Widget _engagementItem(String asset, String count, VoidCallback onTap,
      {Color color = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Image.asset(asset, width: 20, height: 20, color: color),
          const SizedBox(width: 6),
          Text(count, style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}