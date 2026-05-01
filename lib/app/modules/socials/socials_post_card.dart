import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/social_interaction_controller.dart';
import '../../models/comment_source.dart';
import '../../models/socials_model.dart';
import '../../models/news_model.dart';
import '../../routes/app_pages.dart';
import '../../widgets/network_or_file_image.dart';
import '../../widgets/options_bottom_sheet.dart';
import '../../widgets/publisher_avatar.dart';
import 'socials_report_sheet.dart';

class SocialsPostCard extends StatelessWidget {
  final SocialsModel post;

  const SocialsPostCard({
    super.key,
    required this.post,
  });

  //  Helper: tempNews from post
  NewsModel _buildTempNews() {
    return NewsModel(
      id: post.id,
      category: post.category,
      title: post.text,
      author: post.userName,
      publisherName: post.userRole,
      timeAgo: post.timeAgo,
      imageUrl: post.imageUrls.isNotEmpty ? post.imageUrls[0] : '',
      body: post.text,
      publisherMeta: post.userRole,
      likes: post.likes,
      comments: post.comments,
    );
  }

  void _navigateToDetail() {
    Get.toNamed(Routes.NEWS_DETAIL, arguments: {
      'news': NewsModel(
        id: post.id,
        category: post.category,
        title: post.text,
        author: post.userName,
        publisherName: post.userRole,
        timeAgo: post.timeAgo,
        imageUrl: post.imageUrls.isNotEmpty ? post.imageUrls[0] : '',
        body: post.text,
        publisherMeta: post.userRole,
        likes: post.likes,
        comments: post.comments,
      ),
      'tabType': 'post',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PublisherAvatar.fromUrl(
                  imageUrl: post.userImageUrl,
                  name: post.userName,
                  size: 42),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(post.userName, style: AppTextStyles.bodyMedium)),

              GestureDetector(
                onTap: () {
                  OptionsBottomSheet.show(
                    context,
                    news: post,
                    reportSheet: SocialsReportSheet(
                      contentId: post.id,
                      contentType: 'post',
                    ),
                    onReportClick: () {

                      Get.find<SocialInteractionController>().openReport(post.id, 'post');
                    },
                  );
                },
                child: const Icon(Icons.more_vert, color: Color(0xFF959595), size: 24),
              ),
            ],
          ),

          // Post Text + Images
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _navigateToDetail,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.text,
                  style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis),

                const SizedBox(height: 10),

                if (post.imageUrls.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: post.imageUrls.map((url) => NetworkOrFileImage(
                        url: url,
                        width: double.infinity,
                      )).toList(),
                    ),
                  ),
              ],
            ),
          ),

          // Engagement
          const SizedBox(height: 10),
          Row(
            children: [

              // Like
              Obx(() {
                final tempNews = _buildTempNews();
                final ctrl = SocialInteractionController.to;
                final isLiked = ctrl.isLiked(tempNews, type: 'post');

                return GestureDetector(
                  onTap: () => ctrl.toggleLike(tempNews, type: 'post'),
                  child: Row(
                    children: [
                      Image.asset( 'assets/icons/heart.png', width: 20, height: 20,
                        color: isLiked ? Colors.red : AppColors.surface),
                      const SizedBox(width: 4),
                      Text(
                        ctrl.getAdjustedNewsLikes(tempNews, type: 'post'),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: isLiked ? Colors.red : AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(width: 20),

              // Comment
              GestureDetector(
                onTap: () => SocialInteractionController.to
                    .openComments(post.id, CommentSource.social, tabType: 'post', author: post.userName),
                child: Row(
                  children: [
                    Image.asset('assets/icons/comment.png', width: 20, height: 20),
                    const SizedBox(width: 4),
                    Obx(() {
                      final tempNews = _buildTempNews();
                      final count = SocialInteractionController.to
                          .getCommentCount(tempNews, source: 'post');

                      return Text(
                        SocialInteractionController.to.formatCount(count.value),
                        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.surface),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Share
              GestureDetector(
                onTap: () => SocialInteractionController.to
                    .share(id: post.id, title: post.text, type: 'post'),
                child: Row(
                  children: [
                    Image.asset('assets/icons/share.png', width: 20, height: 20),
                    const SizedBox(width: 4),
                    Text( post.shares,
                      style: AppTextStyles.bodyLarge.copyWith(color: AppColors.surface),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(color: Colors.white12, height: 1),
        ],
      ),
    );
  }
}