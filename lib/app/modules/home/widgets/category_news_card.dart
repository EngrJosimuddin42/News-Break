import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/news_model.dart';
import '../../../routes/app_pages.dart';


class CategoryNewsCard extends StatelessWidget {
  final NewsModel news;

  const CategoryNewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.NEWS_DETAIL, arguments: news);
      },
      child:  Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Publisher Header
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    news.publisherImageUrl,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => CircleAvatar(
                      radius: 21,
                      backgroundColor: Colors.grey[800],
                      child: Text(
                        news.publisherName[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            news.publisherName,
                            style: AppTextStyles.bodyMedium,
                          ),
                          if (news.isVerified) ...[
                            const SizedBox(width: 6),
                            Image.asset('assets/icons/verified.png', width: 20, height: 20),
                          ],
                        ],
                      ),
                      Text(
                        '${news.publisherType ?? ""} · ${news.totalFollowers ?? "0"} followers',
                        style: AppTextStyles.overline.copyWith(
                            color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Follow',
                    style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textGreen),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.close,
                      color: Color(0xFF6C6C6C), size: 20),
                ),
              ],
            ),
          ),

          // Media (Video or Image)
          _buildMedia(),

          // Label + time
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
            child: Row(
              children: [
                Text(news.category,
                  style: AppTextStyles.overline,
                ),
                Text(' · ${news.timeAgo}',
                  style: AppTextStyles.labelSmall,
                ),
              ],
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Text(news.title,
              style: AppTextStyles.buttonOutline,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Engagement Row
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Image.asset('assets/icons/reactions.png',
                    width: 50, height: 20),
                const SizedBox(width: 4),
                Text(news.reactions,
                    style: AppTextStyles.labelMedium),
                const SizedBox(width: 60),
                Row(children: [
                  Image.asset('assets/icons/like.png',
                      width: 20, height: 20),
                  const SizedBox(width: 4),
                  Text(news.likes,
                      style: AppTextStyles.labelMedium),
                ]),
                const SizedBox(width: 16),
                Row(children: [
                  Image.asset('assets/icons/comment.png',
                      width: 20, height: 20),
                  const SizedBox(width: 4),
                  Text(news.comments,
                      style: AppTextStyles.labelMedium),
                ]),
                const SizedBox(width: 16),
                Row(children: [
                  Image.asset('assets/icons/share.png',
                      width: 20, height: 20),
                  const SizedBox(width: 4),
                  Text('Share',
                      style: AppTextStyles.labelMedium),
                ]),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  // ── Media widget ─────────────────────────────
  Widget _buildMedia() {
    if (news.videoUrl != null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            // Thumbnail image
            Image.network(
              news.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: Icon(Icons.image, color: Colors.grey, size: 48),
                    ),
                  ),
            ),

            // Play/Pause overlay
            if (news.videoUrl != null)
              Positioned.fill(
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(news.videoUrl!);
                      if (!await launchUrl(url)) {

                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:AppColors.background,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.play_arrow_rounded,
                        color: AppColors.surface,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    // Normal image
    return ClipRRect(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: news.imageUrl.startsWith('http')
            ? Image.network(
          news.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Container(
                color: Colors.grey.shade800,
                child: const Center(
                  child: Icon(Icons.image, color: Colors.grey, size: 48),
                ),
              ),
        )
            : Container(
          color: Colors.grey.shade800,
          child: const Center(
            child: Icon(Icons.image, color: Colors.grey, size: 48),
          ),
        ),
      ),
    );
  }
}