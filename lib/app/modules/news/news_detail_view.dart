import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/nbot_controller.dart';
import '../../controllers/signin_controller.dart';
import '../../controllers/social_interaction_controller.dart';
import '../../models/comment_source.dart';
import '../../models/news_model.dart';
import '../../widgets/about_profile_sheet.dart';
import '../../widgets/follow_button.dart';
import '../../widgets/network_or_file_image.dart';
import '../../widgets/publisher_avatar.dart';
import '../ai/nbot_sheet.dart';
import '../signin/signin_view.dart';
import 'show_more_sheets.dart';

class NewsDetailView extends GetView<HomeController> {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final socialCtrl = Get.find<SocialInteractionController>();
    final dynamic args = Get.arguments;
    final NewsModel news = (args is Map) ? args['news'] : args;
    final String tabType = (args is Map) ? (args['tabType'] ?? 'news') : 'news';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color:AppColors.textOnDark, size: 20)),
        title: GestureDetector(
          onTap: () {
            if (!Get.isRegistered<NBotController>()) {
              Get.lazyPut(() => NBotController());
            }
            Get.bottomSheet(
              const NBotSheet(),
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              ignoreSafeArea: false);
          },
          child: Container( height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                SizedBox(width: 12),
                Image.asset('assets/icons/add.png', width: 20, height: 20),
                SizedBox(width: 8),
                Text('Ask anything', style:AppTextStyles.overline),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            final saved = socialCtrl.isSaved(news.id, type: 'news');
            return IconButton(
              icon: Icon(
                saved ? Icons.bookmark : Icons.bookmark_border,
                color: saved ? Colors.blueAccent : AppColors.textOnDark,
                size: 20,
              ),
              onPressed: () => socialCtrl.onSaveNews(news),
            );
          }),
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.textOnDark, size: 24),
            onPressed: () => NewsBottomSheets.showMoreSheet(context, news),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(17),
              children: [
                // Title
                Text(news.title,
                  style:AppTextStyles.heading),
                const SizedBox(height: 12),

                // Category & Time
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 16),
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

                // Publisher row
                Row(
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1))),
                              if (news.isVerified) ...[
                                const SizedBox(width: 6),
                                Image.asset('assets/icons/verified.png', width: 20, height: 20),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    FollowButton(news: news),
                  ],
                ),
                const SizedBox(height: 12),

                // Main image
                NetworkOrFileImage( url: news.imageUrl,  height: 200,  width: double.infinity,
                  borderRadius: BorderRadius.circular(8)),

                const SizedBox(height: 8),
                if (news.imageCaption.isNotEmpty)
                  Padding( padding: const EdgeInsets.only(top: 8.0),
                    child: Text(news.imageCaption, style: AppTextStyles.overline.copyWith(color: const Color(0xFF9C9C9C)))),
                const SizedBox(height: 16),

                // Body text
                Text( news.body,style: AppTextStyles.caption),
                if (news.secondaryImageUrl != null && news.secondaryImageUrl!.isNotEmpty)
                  Padding( padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        news.secondaryImageUrl!,
                        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink()))),
                if (news.secondarySubtitle != null && news.secondarySubtitle!.isNotEmpty)
                  Padding( padding: const EdgeInsets.only(top: 16),
                    child: Text( news.secondarySubtitle!, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
              ],
            ),
          ),

          // Bottom bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.black),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Get.lazyPut(() => SignInController());
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
                          builder: (context) => const SignInView(isSheet: true),
                        );
                      },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(48)),
                      child: Text('Write a comment', style: AppTextStyles.overline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center)))),
                const SizedBox(width: 16),

                  // Like, Comment, Share Action Buttons
                Obx(() {

                  final isLiked = socialCtrl.isLiked(news, type: tabType);

                  final likeCount = socialCtrl.getAdjustedNewsLikes(news, type: tabType);

                  return _actionItem(
                    isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    likeCount,
                        () => socialCtrl.toggleLike(news, type: tabType),
                    color: isLiked ? Colors.blue : Colors.white,
                  );
                }),

                const SizedBox(width: 16),

                Obx(() {
                  final commentCount = socialCtrl.getCommentCount(news, source: tabType);
                  return _actionItem(
                      null,
                      socialCtrl.formatCount(commentCount.value),
                          () {
                        final source = (tabType == 'post')
                            ? CommentSource.social
                            : (tabType == 'reel' ? CommentSource.reel : CommentSource.news);
                        socialCtrl.openComments(
                            news.id,
                            source,
                            tabType: tabType,
                            author: news.author
                        );
                      },
                      asset: 'assets/icons/comment.png'
                  );
                }),

                  const SizedBox(width: 16),
                   _actionItem(null, 'Share', () => socialCtrl.onSharePressed(news), asset: 'assets/icons/share.png'),
               ],
            ),
          ),
          SizedBox(height: 32)
         ]
         ),
        );
       }

  Widget _actionItem(IconData? icon, String label, VoidCallback onTap, {String? asset, Color color = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          asset != null
              ? Image.asset(asset, width: 20, height: 20, color: color)
              : Icon(icon, color: color, size: 20),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.labelMedium.copyWith(color: color)),
        ],
      ),
    );
  }
}