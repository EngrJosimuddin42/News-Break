import 'package:flutter/material.dart';
import 'report_bottom_sheet.dart';

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
      color: const Color(0xFF1A1A2E),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '$source · $timeAgo',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                // Engagement row
                Row(
                  children: [
                    const Text('😮😢', style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 4),
                    Text(reactions,
                        style:
                        const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(width: 8),
                    const Text('•',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(width: 8),
                    Text('$comments comments',
                        style:
                        const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(width: 8),
                    const Text('•',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(width: 8),
                    Text('$shares shares',
                        style:
                        const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
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
                  width: 80,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 70,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _showOptionsSheet(context),
                child: const Icon(Icons.more_vert,
                    color: Colors.grey, size: 20),
              ),
            ],
          ),
        ],
      ),
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
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          _optionTile(
            icon: Icons.thumb_down_outlined,
            iconColor: Colors.white,
            text: 'Show less about: Donald Trump',
            onTap: () => Navigator.pop(context),
          ),
          _optionTile(
            icon: Icons.thumb_down_outlined,
            iconColor: Colors.white,
            text: 'Show less about: Iran',
            onTap: () => Navigator.pop(context),
          ),
          _optionTile(
            icon: Icons.block,
            iconColor: Colors.white,
            text: 'Block source: The guardian',
            onTap: () => Navigator.pop(context),
          ),
          _optionTile(
            icon: Icons.flag_outlined,
            iconColor: Colors.red,
            text: 'Report',
            textColor: Colors.red,
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const ReportBottomSheet(),
              );
            },
          ),
          const Divider(color: Colors.white12),
          _optionTile(
            icon: Icons.auto_fix_high,
            iconColor: Colors.blueAccent,
            text: 'Ask/request/report anything',
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    required Color iconColor,
    required String text,
    Color textColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(text, style: TextStyle(color: textColor, fontSize: 14)),
      onTap: onTap,
      dense: true,
    );
  }
}