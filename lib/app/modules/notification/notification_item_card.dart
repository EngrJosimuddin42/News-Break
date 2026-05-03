import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/social_interaction_controller.dart';
import '../../models/comment_source.dart';
import '../../models/news_model.dart';
import '../../models/reel_model.dart';
import '../../models/socials_model.dart';
import '../../routes/app_pages.dart';
import '../reels/comments/write_comment_sheet.dart';
import '../reels/player/full_screen_video_player.dart';
import '../../widgets/options_bottom_sheet.dart';
import '../socials/socials_report_sheet.dart';
import 'notification_report_sheet.dart';

class NotificationItemCard extends StatelessWidget {
  final dynamic item;

  const NotificationItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final socialCtrl = SocialInteractionController.to;


    String type = 'news';
    String title = '';
    String category = 'Trending';
    String publisher = 'Unknown';
    String time = '';
    String imageUrl = '';
    String videoUrl = '';
    dynamic id = 0;
    String shares = '0';
    String subtitle = '';

    if (item is NewsModel) {
      type = 'news';
      id = item.id;
      title = item.title;
      category = item.category;
      publisher = item.publisherName;
      time = item.formattedTime;
      imageUrl = item.imageUrl;
      videoUrl = item.videoUrl ?? '';
      shares = item.shares;
      subtitle = item.subtitle;
    } else if (item is ReelModel) {
      type = 'reel';
      id = item.id ?? 0;
      title = item.description;
      category = 'Reel';
      publisher = item.userName;
      time = item.formattedTime;
      imageUrl = item.imageUrl;
      videoUrl = item.videoUrl ?? '';
      shares = item.shares.toString();
    } else if (item is SocialsModel) {
      type = 'post';
      id = item.id;
      title = item.text;
      category = item.category;
      publisher = item.userName;
      time = item.formattedTime;
      imageUrl = item.imageUrls.isNotEmpty ? item.imageUrls[0] : '';
      shares = item.shares;
    }

    final bool hasVideo = videoUrl.isNotEmpty;

    return GestureDetector(
      onTap: () {
        if (hasVideo) {
          Get.to(() => FullScreenVideoPlayer(url: videoUrl));
        } else if (type == 'news') {
          Get.toNamed(Routes.NEWS_DETAIL, arguments: item);
        }
      },
      child: Container(
        color: const Color(0xFF2C3C53),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category, style: AppTextStyles.labelMedium),
                  const SizedBox(height: 4),
                  Text(title, style: AppTextStyles.buttonOutline, maxLines: 3, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text(subtitle, style: AppTextStyles.overline.copyWith(color: const Color(0xFF8EA0BC))),
                  const SizedBox(height: 6),
                  Row(children: [
                    Image.asset('assets/icons/type.png'),
                    const SizedBox(width: 6),
                    Text(publisher, style: AppTextStyles.buttonOutline.copyWith(color: AppColors.dot)),
                    const SizedBox(width: 16),
                    Image.asset('assets/icons/time.png'),
                    const SizedBox(width: 6),
                    Text(time, style: AppTextStyles.buttonOutline.copyWith(color: AppColors.dot)),
                  ]),
                  const SizedBox(height: 8),

                  _buildEngagementRow(context, socialCtrl, id, type, shares),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _buildRightSection(context, imageUrl, hasVideo, item),
          ],
        ),
      ),
    );
  }

  Widget _buildRightSection(BuildContext context, String imageUrl, bool hasVideo, dynamic currentItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Widget selectedReportSheet;

            if (currentItem is NewsModel) {
              selectedReportSheet = NotificationReportSheet(
                contentId: currentItem.id,
                contentType: 'news',
              );
            } else if (currentItem is SocialsModel) {
              selectedReportSheet = SocialsReportSheet(
                contentId: currentItem.id,
                contentType: 'post',
              );
            } else if (currentItem is ReelModel) {
              selectedReportSheet = NotificationReportSheet(
                contentId: currentItem.id ?? 0,
                contentType: 'reel',
              );
            } else {
              selectedReportSheet = const SocialsReportSheet();
            }

            OptionsBottomSheet.show(
              context,
              news: currentItem,
              reportSheet: selectedReportSheet,
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(Icons.more_vert, color: Colors.grey, size: 20),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl.startsWith('http')
                  ? Image.network(imageUrl, width: 100, height: 70, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _errorPlaceholder())
                  : _errorPlaceholder(),
            ),
            if (hasVideo)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
              ),
          ],
        ),
      ],
    );
  }

  Widget _errorPlaceholder() => Container(width: 100, height: 70, color: Colors.grey[800], child: const Icon(Icons.image, color: Colors.grey, size: 20));

  Widget _buildEngagementRow(BuildContext context, SocialInteractionController socialCtrl, dynamic id, String type, String shareCount) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [

          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => WriteCommentSheet(
                  reelId: item,
                  type: type,
                  onlyEmoji: true,
                ),
              );
            },
            child: Obx(() {
              final reactionCount = (item is NewsModel) ? socialCtrl.getReactionCount(item, source: type).value : 0;

              return Row(
                children: [
                  Image.asset('assets/icons/reactions.png', width: 50, height: 20),
                  const SizedBox(width: 6),
                  Text(socialCtrl.formatCount(reactionCount), style: AppTextStyles.button.copyWith(color: AppColors.dot)),
                ],
              );
            }),
          ),
          const SizedBox(width: 16),
          _buildDot(AppColors.dot),
          const SizedBox(width: 8),


          GestureDetector(
            onTap: () => socialCtrl.openComments(
              id,
              type == 'reel' ? CommentSource.reel : CommentSource.news,
              tabType: type,
              author: (item is NewsModel) ? item.author : null,
            ),
            child: Obx(() {

              final commentCount = (item is NewsModel) ? socialCtrl.getCommentCount(item, source: type).value : 0;
              return Text('${socialCtrl.formatCount(commentCount)} comments', style: AppTextStyles.button.copyWith(color: AppColors.dot));
            }),
          ),
          const SizedBox(width: 16),
          _buildDot(AppColors.dot),
          const SizedBox(width: 8),


          GestureDetector(
            onTap: () => socialCtrl.share(id: id, title: 'Check this out!', type: type),
            child: Text('$shareCount shares', style: AppTextStyles.button.copyWith(color: AppColors.dot)),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Text('•', style: AppTextStyles.button.copyWith(color: color));
  }
}