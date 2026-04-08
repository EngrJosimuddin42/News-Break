import 'package:flutter/material.dart';
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
                radius: 20,
                backgroundImage: NetworkImage(userImageUrl),
                backgroundColor: Colors.grey[800],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(text,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13, height: 1.4)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showOptionsSheet(context),
                child: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
              ),
            ],
          ),

          // Images
          if (imageUrls.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: imageUrls.map((url) => Image.network(
                  url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160, color: Colors.grey[900],
                  ),
                )).toList(),
              ),
            ),
          ],

          // Engagement
          const SizedBox(height: 10),
          Row(
            children: [
              _engagementItem(Icons.favorite_border, likes),
              const SizedBox(width: 16),
              _engagementItem(Icons.chat_bubble_outline, comments),
              const SizedBox(width: 16),
              _engagementItem(Icons.share_outlined, shares),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white12, height: 1),
        ],
      ),
    );
  }

  Widget _engagementItem(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 18),
        const SizedBox(width: 4),
        Text(count, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          _optionTile(Icons.thumb_down_outlined, Colors.white,
              'Show less about: Donald Trump', Colors.white,
                  () => Navigator.pop(context)),
          _optionTile(Icons.thumb_down_outlined, Colors.white,
              'Show less about: Iran', Colors.white,
                  () => Navigator.pop(context)),
          _optionTile(Icons.block, Colors.white,
              'Block source: The guardian', Colors.white,
                  () => Navigator.pop(context)),
          _optionTile(Icons.flag_outlined, Colors.red,
              'Report', Colors.red, () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const CommunityReportSheet(),
                );
              }),
          const Divider(color: Colors.white12),
          _optionTile(Icons.auto_fix_high, Colors.blueAccent,
              'Ask/request/report anything', Colors.white,
                  () => Navigator.pop(context)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _optionTile(IconData icon, Color iconColor, String text,
      Color textColor, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(text, style: TextStyle(color: textColor, fontSize: 14)),
      onTap: onTap,
      dense: true,
    );
  }
}