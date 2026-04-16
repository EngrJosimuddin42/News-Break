import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class NewsCard extends StatefulWidget {
  final String publisherName;
  final String publisherMeta;
  final String timeAgo;
  final String title;
  final String imageUrl;
  final String likeCount;
  final String commentCount;
  final VoidCallback? onFollow;
  final VoidCallback? onDismiss;

  const NewsCard({
    super.key,
    required this.publisherName,
    required this.publisherMeta,
    required this.timeAgo,
    required this.title,
    required this.imageUrl,
    this.likeCount = '1.4K',
    this.commentCount = '4K',
    this.onFollow,
    this.onDismiss,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Publisher row ──────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                ClipOval(
                  child: Image.asset(
                    'assets/images/publisher.png',
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => CircleAvatar(
                      radius: 21,
                      backgroundColor: Colors.grey[800],
                      child: Text(
                        widget.publisherName[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Name + meta
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.publisherName,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '· ${widget.timeAgo}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                         Image.asset('assets/icons/person.png',height: 14,width: 14),
                          const SizedBox(width: 3),
                          Text(
                            widget.publisherMeta,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Follow button
                TextButton(
                  onPressed: widget.onFollow,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Follow',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── News text ──────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(68, 10, 16, 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final textStyle = AppTextStyles.bodyMedium.copyWith(
                  height: 1.5,
                  fontSize: 14,
                );

                // title overflow check
                final textPainter = TextPainter(
                  text: TextSpan(text: widget.title, style: textStyle),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: constraints.maxWidth);

                final isOverflowing = textPainter.didExceedMaxLines;

                if (!isOverflowing) {
                  return Text(widget.title, style: textStyle);
                }

                return GestureDetector(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  child: _isExpanded
                      ? Text(widget.title, style: textStyle)
                      : RichText(
                    text: TextSpan(
                      style: textStyle,
                      children: [
                        TextSpan(text: widget.title),
                        TextSpan(
                          text: ' See more',
                          style: textStyle.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),

          // ── News image ─────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 68),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imageUrl, // ← change
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  color: Colors.grey[900],
                ),
              ),
            ),
          ),

          // ── Action row ─────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 12),
            child: Row(
              children: [
                // Like
                Image.asset(
                  'assets/icons/like.png',
                  width: 20,
                  height: 20,
                  ),
                const SizedBox(width: 6),
                Text(
                  widget.likeCount,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(width: 80),

                // Comment
                Image.asset(
                  'assets/icons/comment.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.commentCount,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // ── Divider ────────────────────────────────
          const Divider(color: Colors.white12, height: 1, thickness: 1),
        ],
      ),
    );
  }
}