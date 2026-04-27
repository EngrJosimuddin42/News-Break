import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/social_interaction_controller.dart';
import '../../../models/comment_source.dart';
import '../../../models/news_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/about_profile_sheet.dart';
import '../../../widgets/follow_button.dart';
import '../../../widgets/network_or_file_image.dart';
import '../../../widgets/publisher_avatar.dart';
import '../../reels/comments/write_comment_sheet.dart';
import '../../reels/full_screen_video_player.dart';

class CategoryNewsCard extends StatelessWidget {
  final NewsModel news;
  const CategoryNewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final bool hasVideo = news.videoUrl != null && news.videoUrl!.isNotEmpty;
    final controller = Get.find<HomeController>();
    final socialCtrl = Get.find<SocialInteractionController>();

    return Container(
      color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Publisher Header
            _buildHeader(controller, context),
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
              padding: const EdgeInsets.fromLTRB(20, 12, 12, 4),
              child: Row(
                children: [
                  Image.asset('assets/icons/person.png', height: 14, width: 14),
                  const SizedBox(width: 3),
                  Text(news.category, style: AppTextStyles.overline),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/location1.png', height: 14, width: 14),
                  const SizedBox(width: 3),
                  Flexible(
                      child: Text(news.publisherMeta, style: AppTextStyles.overline.copyWith(color: AppColors.info,fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1)),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/time.png', height: 14, width: 14),
                  const SizedBox(width: 3),
                  Text(news.timeAgo, style: AppTextStyles.overline.copyWith(color: AppColors.info)),
                ],
              ),
            ),

            //  Title
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 12, 10),
              child: Text(news.title, style: AppTextStyles.button, maxLines: 1, overflow: TextOverflow.ellipsis)),

            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 12, 12),
                child: Text(news.subtitle, style: AppTextStyles.labelMedium, maxLines: 3, overflow: TextOverflow.ellipsis)),

          ],
        ),
      ),
            // Engagement Row
            _buildEngagementRow(socialCtrl, context),

            SizedBox(height:4),
            const Divider(color: Colors.white12, height: 2, thickness: 3),
            SizedBox(height:4),
          ],
        ),
      );
    }

  // Header Widget
  Widget _buildHeader(HomeController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      child: Row(
        children: [
          PublisherAvatar.fromNews(news: news),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                        child: GestureDetector(
                            onTap: () => AboutProfileSheet.showFromNews(context, news),
                            child: Text(news.publisherName, style: AppTextStyles.bodyMedium))),
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          NetworkOrFileImage(url: news.imageUrl),
          if (hasVideo)
            Center(
              child: Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2)),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 35),
              ),
            ),
        ],
      ),
    );
  }

  // Engagement Row Widget
  Widget _buildEngagementRow(SocialInteractionController socialCtrl, BuildContext context) {    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 12, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => WriteCommentSheet(
                      reelId: news.id,
                      onlyEmoji: true,
                    ),
                  );
                },
                child: Obx(() {
                  final String myEmoji = socialCtrl.getSelectedReaction(news.id, type: 'news');

                  return Row(
                    children: [
                      if (myEmoji.isNotEmpty) ...[
                        Text(myEmoji, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 4),
                      ],
                      Image.asset('assets/icons/reactions.png', width: 50, height: 20),
                      const SizedBox(width: 4),
                      Text(news.reactions, style: AppTextStyles.labelMedium),
                    ],
                  );
                }),
              ),
            ],
          ),

          Row(
            children: [
              Obx(() {
                final isLiked = socialCtrl.isLiked(news.id, type: 'news');
                return _engagementItem(
                  isLiked ? 'assets/icons/like_filled.png' : 'assets/icons/like.png',
                  news.likes,
                  onTap: () => socialCtrl.toggleLike(news.id, type: 'news'),
                  color: isLiked ? Colors.blue : Colors.white,
                );
              }),

              const SizedBox(width: 16),
              _engagementItem('assets/icons/comment.png', news.comments,
                  onTap: () => socialCtrl.openComments(news.id, CommentSource.news)),
              const SizedBox(width: 16),
              _engagementItem('assets/icons/share.png', 'Share',
                  onTap: () => socialCtrl.share(id: news.id, title: news.title, type: 'news')),            ],
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