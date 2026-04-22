import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class PeopleCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool isFollowing;
  final VoidCallback onDismiss;
  final VoidCallback onFollow;

  const PeopleCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.isFollowing,
    required this.onDismiss,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 160,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF434447)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(Icons.close, color: Colors.white54, size: 20)),
            ],
          ),
          CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFF7A1CA4),
            child: Text(name[0],
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
          SizedBox(height: 12),
          SizedBox(
            width: 125,
            height: 36,
            child: OutlinedButton(
                onPressed: onFollow,
                style: OutlinedButton.styleFrom(
                  backgroundColor: isFollowing ? Colors.grey[800] : const Color(0xFF3498FA),
                  side: BorderSide(color: isFollowing ? Colors.white24 : const Color(0xFF3498FA)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: Text(isFollowing ? 'Following' : '+ Follow',
                  style: AppTextStyles.buttonOutline),
              ),
            ),
            ],
          ),
    );
  }
}





