import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/signin_controller.dart';
import '../../models/news_model.dart';
import '../../widgets/about_profile_sheet.dart';
import '../../widgets/follow_button.dart';
import '../../widgets/publisher_avatar.dart';
import '../signin/signin_view.dart';
import 'show_more_sheets.dart';

class NewsDetailView extends GetView<HomeController> {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsModel news = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color:AppColors.textOnDark, size: 20),
        ),
        title: GestureDetector(
          onTap: () {},
          child: Container(
            height: 36,
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
          IconButton(
            icon: Icon(Icons.bookmark_border, color:AppColors.textOnDark,size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color:AppColors.textOnDark,size: 24,),
    onPressed: () => NewsBottomSheets.showMoreSheet(context, news)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                // category
                Text(news.category.toUpperCase(), style: AppTextStyles.small.copyWith(color:AppColors.accentLight)),
                const SizedBox(height: 8),
                // Title
                Text(news.title,
                  style:AppTextStyles.heading),
                const SizedBox(height: 12),

                // Author + time
                Text('By ${news.author.toUpperCase()} · ${news.timeAgo}',
                    style: AppTextStyles.overline.copyWith(color: Color(0xFF9C9C9C))),
                const SizedBox(height: 12),

                // Publisher row
                // Publisher row
                Row(
                  children: [
                    PublisherAvatar(news: news),
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
                                      maxLines: 1),
                                ),
                              ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    news.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[800],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                if (news.imageCaption != null && news.imageCaption.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(news.imageCaption, style: AppTextStyles.overline.copyWith(color: const Color(0xFF9C9C9C)))),
                const SizedBox(height: 16),

                // Body text
                if (news.secondaryImageUrl != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(news.secondaryImageUrl!),
                    ),
                  ),
                Text( news.body,style: AppTextStyles.caption),
              ],
            ),
          ),

          // Bottom bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
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
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width),
                          builder: (context) => const SignInView(isSheet: true),
                        );
                      },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child:Text('Write a comment', style:AppTextStyles.overline)))),
                       const SizedBox(width: 16),

                  // Like, Comment, Share Action Buttons
                Obx(() {
                  final isLiked = controller.isLiked(news.id);
                  return _actionItem(
                    isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    news.likes, () => controller.onLikePressed(news),
                    color: isLiked ? Colors.blue : Colors.white);
                }),
                const SizedBox(width: 16),
                  _actionItem(null, news.comments, () => controller.onCommentPressed(news), asset: 'assets/icons/comment.png'),
                  const SizedBox(width: 16),
                   _actionItem(null, 'Share', () => controller.onSharePressed(news), asset: 'assets/icons/share.png'),
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
  }}