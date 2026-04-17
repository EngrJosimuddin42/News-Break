import 'package:flutter/material.dart';

class ShareSheet extends StatelessWidget {
  final Map<String, dynamic> reel;

  const ShareSheet({super.key, required this.reel});


  static const List<Map<String, dynamic>> _shareOptions = [
    {'label': 'Instagram', 'icon': Icons.camera_alt, 'color': Color(0xFFE1306C)},
    {'label': 'Share by Image', 'icon': Icons.image_outlined, 'color': Colors.grey},
    {'label': 'Copy link', 'icon': Icons.link, 'color': Colors.grey},
    {'label': 'Facebook', 'icon': Icons.facebook, 'color': Color(0xFF1877F2)},
    {'label': 'Email', 'icon': Icons.email_outlined, 'color': Colors.grey},
    {'label': 'Text message', 'icon': Icons.message_outlined, 'color': Colors.green},
    {'label': 'WhatsApp', 'icon': Icons.chat_outlined, 'color': Color(0xFF25D366)},
    {'label': 'Facebook messenger', 'icon': Icons.messenger_outline, 'color': Color(0xFF0099FF)},
    {'label': 'X', 'icon': Icons.close, 'color': Colors.black},
    {'label': 'Facebook groups', 'icon': Icons.group_outlined, 'color': Color(0xFF1877F2)},
    {'label': 'More', 'icon': Icons.more_horiz, 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 36, height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 12),

        // Preview
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  reel['imageUrl'],
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(width: 48, height: 48, color: Colors.grey[800]),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reel['userName'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                  Text(reel['description'],
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 11)),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.grey, size: 18),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        const Divider(color: Colors.white12, height: 1),

        // Share options
        ..._shareOptions.map((option) => ListTile(
          leading: Icon(option['icon'] as IconData,
              color: option['color'] as Color, size: 22),
          title: Text(option['label'] as String,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          onTap: () => Navigator.pop(context),
          dense: true,
        )),

        const SizedBox(height: 16),
      ],
    );
  }
}