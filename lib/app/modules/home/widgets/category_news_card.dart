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
import '../../reels/player/full_screen_video_player.dart';


class CategoryNewsCard extends StatefulWidget {
  final NewsModel news;
  final String tabType;

  const CategoryNewsCard({
    super.key,
    required this.news,
    required this.tabType,
  });

  @override
  State<CategoryNewsCard> createState() => _CategoryNewsCardState();
}

class _CategoryNewsCardState extends State<CategoryNewsCard> {
  late final SocialInteractionController _socialCtrl;
  late final HomeController _controller;
  late final RxInt _commentCount;

  // initState
  @override
  void initState() {
    super.initState();
    _socialCtrl = Get.find<SocialInteractionController>();
    _controller = Get.find<HomeController>();
    _commentCount = _socialCtrl.getCommentCount(widget.news, source: widget.tabType);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _socialCtrl.initFollowerCount(widget.news);
    });
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;
    final bool hasVideo = news.videoUrl != null && news.videoUrl!.isNotEmpty;

    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _buildHeader(context),

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

                _buildMedia(hasVideo),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 12, 4),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/person.png', height: 14, width: 14),
                      const SizedBox(width: 3),
                      Flexible(
                          child: Text(news.category, style: AppTextStyles.overline,
                              overflow: TextOverflow.ellipsis, maxLines: 1)),
                      const SizedBox(width: 8),
                      Image.asset('assets/icons/location1.png', height: 14, width: 14),
                      const SizedBox(width: 3),
                      Flexible(
                          child: Text(news.publisherMeta,
                              style: AppTextStyles.overline.copyWith(
                                  color: AppColors.info, fontSize: 10),
                              overflow: TextOverflow.ellipsis, maxLines: 1)),
                      const SizedBox(width: 8),
                      Image.asset('assets/icons/time.png', height: 14, width: 14),
                      const SizedBox(width: 3),
                      Flexible(
                          child: Text(news.timeAgo,
                              style: AppTextStyles.overline.copyWith(color: AppColors.info),
                              overflow: TextOverflow.ellipsis, maxLines: 1)),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 12, 10),
                    child: Text(news.title, style: AppTextStyles.button,
                        maxLines: 1, overflow: TextOverflow.ellipsis)),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 12, 12),
                    child: Text(news.subtitle, style: AppTextStyles.labelMedium,
                        maxLines: 3, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),

          _buildEngagementRow(context),

          const SizedBox(height: 4),
          const Divider(color: Colors.white12, height: 2, thickness: 3),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final news = widget.news;
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
                        child: Text(news.publisherName,
                            style: AppTextStyles.bodyMedium,
                            overflow: TextOverflow.ellipsis, maxLines: 1),
                      ),
                    ),
                    if (news.isVerified) ...[
                      const SizedBox(width: 6),
                      Image.asset('assets/icons/verified.png', width: 20, height: 20),
                    ],
                  ],
                ),
                Obx(() {
                  final count = _socialCtrl.followerCounts[news.id]
                      ?? news.totalFollowers
                      ?? '0';
                  return Text(
                    '${news.publisherType ?? ""} · $count followers',
                    style: AppTextStyles.overline
                        .copyWith(color: AppColors.textTertiary),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              ],
            ),
          ),

          FollowButton(news: news),

          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => _controller.hideNews(news),
            child: const Icon(Icons.close, color: Color(0xFF6C6C6C), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildMedia(bool hasVideo) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          NetworkOrFileImage(url: widget.news.imageUrl),
          if (hasVideo)
            Center(
              child: Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.play_arrow_rounded,
                    color: Colors.white, size: 35),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEngagementRow(BuildContext context) {
    final news = widget.news;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 12, 16),
      child: Row(
        children: [

          Expanded(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) =>
                      WriteCommentSheet(reelId: news.id, onlyEmoji: true,type: widget.tabType),
                );
              },
              child: Obx(() {
                final int liveReactionCount =
                    _socialCtrl.getReactionCount(news, source: widget.tabType).value;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/icons/reactions.png', width: 50, height: 20),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(_socialCtrl.formatCount(liveReactionCount),
                          style: AppTextStyles.labelMedium,
                          overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                  ],
                );
              }),
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 60,
                child: Obx(() {
                  final isLiked = _socialCtrl.isLiked(news.id, type: widget.tabType);
                  return GestureDetector(
                    onTap: () => _socialCtrl.toggleLike(news.id, type: widget.tabType),
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          isLiked ? 'assets/icons/like_filled.png' : 'assets/icons/like.png',
                          width: 20, height: 20,
                          color: isLiked ? Colors.blue : Colors.white),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            _socialCtrl.getAdjustedNewsLikes(news, type: widget.tabType),
                            style: AppTextStyles.labelMedium.copyWith(
                                color: isLiked ? Colors.blue : Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(width: 16),

              SizedBox(
                width: 55,
                child: GestureDetector(
                  onTap: () => _socialCtrl.openComments(
                      news.id, CommentSource.news, tabType: widget.tabType),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/icons/comment.png',
                          width: 20, height: 20, color: Colors.white),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Obx(() => Text(
                          _socialCtrl.formatCount(_commentCount.value),
                          style: AppTextStyles.labelMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 16),

              GestureDetector(
                onTap: () => _socialCtrl.share(
                    id: news.id, title: news.title, type: 'news'),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/icons/share.png',
                        width: 20, height: 20, color: Colors.white),
                    const SizedBox(width: 4),
                    Text('Share', style: AppTextStyles.labelMedium),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}