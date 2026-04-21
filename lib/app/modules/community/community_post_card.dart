import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../notification/options_bottom_sheet.dart';
import 'community_report_sheet.dart';

class CommunityPostCard extends StatelessWidget {
  final String userName;
  final String userImageUrl;
  final String text;
  final List<String> imageUrls;
  final String likes;
  final String comments;
  final String shares;

  const CommunityPostCard({
    super.key,
    required this.userName,
    required this.userImageUrl,
    required this.text,
    this.imageUrls = const [],
    this.likes = '1.4K',
    this.comments = '4K',
    this.shares = '67',
  });

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
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(userImageUrl),
                backgroundColor: Colors.grey[800],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 2),
                    Text(text,
                      style: AppTextStyles.bodyLarge.copyWith(
                          color: Color(0xFF929292)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => OptionsBottomSheet.show(context, reportSheet: const CommunityReportSheet()),
                child: const Icon(
                    Icons.more_vert, color: Color(0xFF959595), size: 24),
              ),
            ],
          ),

          // Images
          if (imageUrls.isNotEmpty) ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: imageUrls.map((url) =>
                      Image.network(
                        url,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(
                              height: 160, color: Colors.grey[900],
                            ),
                      )).toList(),
                ),
              ),
            ),
          ],

          // Engagement
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65),
            child: Row(
              children: [
                Image.asset('assets/icons/heart.png', width: 20, height: 20),
                const SizedBox(width: 4),
                Text(likes, style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.surface)),
                const SizedBox(width: 20),
                Image.asset('assets/icons/comment.png', width: 20, height: 20),
                const SizedBox(width: 4),
                Text(comments, style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.surface)),
                const SizedBox(width: 20),
                Image.asset('assets/icons/share.png', width: 20, height: 20),
                const SizedBox(width: 4),
                Text(shares, style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.surface)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white12, height: 1),
        ],
      ),
    );
  }
  }
