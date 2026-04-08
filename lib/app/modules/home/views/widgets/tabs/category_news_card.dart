import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_colors.dart';

class CategoryNewsItem {
  final String publisherName;
  final String publisherType;
  final String followerCount;
  final String imageUrl;
  final String label;
  final String timeAgo;
  final String title;
  final String reactions;
  final String likes;
  final String comments;
  final bool isVerified;

  const CategoryNewsItem({
    required this.publisherName,
    required this.publisherType,
    required this.followerCount,
    required this.imageUrl,
    required this.label,
    required this.timeAgo,
    required this.title,
    required this.reactions,
    required this.likes,
    required this.comments,
    this.isVerified = true,
  });
}

class CategoryNewsCard extends StatelessWidget {
  final CategoryNewsItem item;

  const CategoryNewsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'assets/images/publisher.png',
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => CircleAvatar(
                      radius: 21,
                      backgroundColor: Colors.grey[800],
                      child: Text(
                        item.publisherName[0].toUpperCase(),
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
                            item.publisherName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (item.isVerified) ...[
                            const SizedBox(width: 4),
                            Image.asset(
                              'assets/icons/verified.png',
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '${item.publisherType} · ${item.followerCount} followers',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Follow',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.close, color: Colors.grey.shade400, size: 18),
                ),
              ],
            ),
          ),

          // News Image
          ClipRRect(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: item.imageUrl.startsWith('http')
                  ? Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
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
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
            child: Row(
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  ' · ${item.timeAgo}',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
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
                  width: 50,
                  height: 20,
                ),
                const SizedBox(width: 4),
                Text(item.reactions,
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                const SizedBox(width: 60),
                // Like
                Row(children: [
                  Image.asset('assets/icons/like.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(item.likes, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                ]),
                const SizedBox(width: 16),
                // Comment
                Row(children: [
                  Image.asset('assets/icons/comment.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(item.comments, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                ]),
                const SizedBox(width: 16),
                // Share
                Row(children: [
                  Image.asset('assets/icons/share.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 4),
                  Text('Share', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}