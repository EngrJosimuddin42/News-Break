import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/social_interaction_controller.dart';
import '../../../models/comment_source.dart';
import '../../../models/news_model.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../widgets/about_profile_sheet.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/network_or_file_image.dart';
import '../../../widgets/publisher_avatar.dart';
import '../../reels/player/full_screen_video_player.dart';

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

          SizedBox(height:24),

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
                // Media Section (Image/Video)
                _buildMediaSection(news, hasVideo),

                SizedBox(height:16),

                // News Title (Text)
                _buildTitleSection(news),
              ],
            ),
          ),

          // Action Row (Like/Comment)
          _buildActionRow(news),

          SizedBox(height:16),
          const Divider(color: Colors.white12, height: 2, thickness: 3),
          SizedBox(height:4),
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
          PublisherAvatar.fromNews(news: news),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                        child: GestureDetector(
                            onTap: () => AboutProfileSheet.showFromNews(context, news),
                      child: Text(news.publisherName, style: AppTextStyles.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1))),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset('assets/icons/location1.png', height: 14, width: 14),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(news.publisherMeta, style: AppTextStyles.overline.copyWith(color: AppColors.info,fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1)),
                    const SizedBox(width: 2),
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                    Image.asset('assets/icons/time.png', height: 14, width: 14),
                    const SizedBox(width: 3),
                    Text(news.timeAgo, style: AppTextStyles.overline.copyWith(color: AppColors.info))]),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FollowButton(news: news),
        ],
      ),
    );
  }

  // Title Section with "See more"
  Widget _buildTitleSection(NewsModel news) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 16, 10),
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
              overflow: TextOverflow.ellipsis),
          );
        },
      ),
    );
  }

  // Media Section
  Widget _buildMediaSection(NewsModel news, bool hasVideo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          NetworkOrFileImage(
            url: news.imageUrl, height: 220, width: double.infinity),
          if (hasVideo)
            Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40)),
        ],
      ),
    );
  }

  // Action Row
  Widget _buildActionRow(NewsModel news) {
    final socialCtrl = Get.find<SocialInteractionController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Obx(() {
            final isLiked = socialCtrl.isLiked(news.id, type: 'news');
            return _engagementItem(
              isLiked ? 'assets/icons/like_filled.png' : 'assets/icons/like.png',
              news.likes,
                  () => socialCtrl.toggleLike(news.id, type: 'news'),
              color: isLiked ? Colors.blue : Colors.white,
            );
          }),
          const SizedBox(width: 80),
          _engagementItem('assets/icons/comment.png', news.comments,
                  () => socialCtrl.openComments(news.id, CommentSource.news)),
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