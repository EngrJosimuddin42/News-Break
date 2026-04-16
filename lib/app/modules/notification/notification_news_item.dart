import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../widgets/options_bottom_sheet.dart';
import 'notification_report_sheet.dart';

class NotificationNewsItem extends StatelessWidget {
  final String category;
  final String title;
  final String source;
  final String timeAgo;
  final String imageUrl;
  final String reactions;
  final String comments;
  final String shares;

  const NotificationNewsItem({
    super.key,
    required this.category,
    required this.title,
    required this.source,
    required this.timeAgo,
    required this.imageUrl,
    required this.reactions,
    required this.comments,
    required this.shares,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(category,
                  style: AppTextStyles.labelMedium),
                const SizedBox(height: 4),
                Text(title,
                 style: AppTextStyles.buttonOutline,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '$source · $timeAgo',
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
                    Text(reactions,
                    style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                    const SizedBox(width: 8),
                     Text('•',
                        style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                    const SizedBox(width: 8),
                    Text('$comments comments',
                        style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                    const SizedBox(width: 8),
                    Text('•',
                        style: AppTextStyles.labelSmall.copyWith(color: Color(0xFFAAB6C6))),
                    const SizedBox(width: 8),
                    Text('$shares shares',
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
                  imageUrl,
                  width: 100,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 70,
                    color: Colors.grey[800],
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
    );
  }
  }