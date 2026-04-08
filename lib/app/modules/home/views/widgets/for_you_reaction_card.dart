import 'package:flutter/material.dart';

class ForYouReactionCard extends StatelessWidget {
  final String publisherName;
  final String timeAgo;
  final String title;
  final String imageAsset;
  final VoidCallback onFollow;
  final VoidCallback onDismiss;

  const ForYouReactionCard({
    super.key,
    required this.publisherName,
    required this.timeAgo,
    required this.title,
    required this.imageAsset,
    required this.onFollow,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Row(
              children: [
                Text(publisherName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(width: 4),
                const Icon(Icons.check_circle, color: Colors.amber, size: 14),
              ],
            ),
            subtitle: Text('Partner publisher . $timeAgo', style: const TextStyle(color: Colors.white54, fontSize: 11)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: onFollow,
                  child: const Text('Follow', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54, size: 18),
                  onPressed: onDismiss,
                ),
              ],
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
          ),

          const SizedBox(height: 8),

          // News Image
          Image.asset(imageAsset, width: double.infinity, height: 220, fit: BoxFit.cover),

          // Interaction Bar (Reactions, Comments, Share)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Reaction icons
                const Icon(Icons.thumb_up, color: Colors.blue, size: 16),
                const Icon(Icons.sentiment_very_satisfied, color: Colors.amber, size: 16),
                const Icon(Icons.sentiment_very_dissatisfied, color: Colors.orange, size: 16),
                const SizedBox(width: 6),
                const Text('1.4K', style: const TextStyle(color: Colors.white70, fontSize: 12)),

                const Spacer(),

                _buildAction(Icons.thumb_up_alt_outlined, '1.4K'),
                const SizedBox(width: 12),
                _buildAction(Icons.chat_bubble_outline, '4K'),
                const SizedBox(width: 12),
                _buildAction(Icons.share_outlined, 'Share'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}