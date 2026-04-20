import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../models/news_model.dart';
import '../../routes/app_pages.dart';
import '../../widgets/options_bottom_sheet.dart';
import 'notification_report_sheet.dart';

class NotificationNewsItem extends StatelessWidget {
  final NewsModel news;


  const NotificationNewsItem({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.NEWS_DETAIL, arguments: news);
      },

      child: Container(
      color: const Color(0xFF2C3C53),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(news.category,
                  style: AppTextStyles.labelMedium),
                const SizedBox(height: 4),
                Text(news.title,
                 style: AppTextStyles.buttonOutline,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '${news.publisherName} · ${news.timeAgo}',
                  style: AppTextStyles.labelMedium,
                ),
                const SizedBox(height: 8),
                // Engagement row
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/reactions.png',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 4),
                    Text(news.reactions,
                    style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                    const SizedBox(width: 8),
                     Text('•',
                        style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                    const SizedBox(width: 8),
                    Text('${news.comments} comments',
                        style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                    const SizedBox(width: 8),
                    Text('•',
                        style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                    const SizedBox(width: 8),
                    Text('${news.shares} shares',
                        style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                  ],
                ),
          ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Right image + menu
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  news.imageUrl,
                  width: 100,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 70,
                    color: Colors.grey[800],
                    child: const Icon(Icons.image, color: Colors.grey, size: 20),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => OptionsBottomSheet.show(context, reportSheet: const NotificationReportSheet()),
                child: const Icon(Icons.more_vert,
                    color: Colors.grey, size: 20),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
  }