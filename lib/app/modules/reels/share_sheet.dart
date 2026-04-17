import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/reels/reels_controller.dart';
import '../../models/reel_model.dart';

class ShareSheet extends GetView<ReelsController> {
  final ReelModel reel;

  const ShareSheet({super.key, required this.reel});

  static const List<Map<String, dynamic>> _shareOptions = [
    {'label': 'Instagram', 'icon': Icons.camera_alt, 'isAsset': false},
    {'label': 'Share by Image', 'icon': Icons.image_outlined, 'isAsset': false},
    {'label': 'Copy link', 'icon': Icons.link, 'isAsset': false},
    {'label': 'Facebook', 'icon': Icons.facebook, 'isAsset': false},
    {'label': 'Email', 'icon': Icons.email_outlined, 'isAsset': false},
    {'label': 'Text message', 'icon': 'assets/icons/message.png', 'isAsset':true},
    {'label': 'WhatsApp', 'icon': 'assets/icons/whatsup.png', 'isAsset': true},
    {'label': 'Facebook messenger', 'icon': 'assets/icons/messenger.png', 'isAsset': true},
    {'label': 'X', 'icon': 'assets/icons/x_logo.png', 'isAsset': true},
    {'label': 'Facebook groups', 'icon': 'assets/icons/facebook_group.png', 'isAsset': true},
    {'label': 'More', 'icon': Icons.more_horiz, 'isAsset': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          // Drag Handle
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(controller.sendStoryLabel, style: AppTextStyles.caption),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),

          // Preview Card
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    reel.imageUrl,
                    width: 100, height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(width: 100, height: 100, color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (reel.description.isEmpty) ...[
                        Text(controller.mediaAccountLabel, style: AppTextStyles.overline),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: controller.checkOutPrefix, style: AppTextStyles.small),
                              TextSpan(text: reel.userName, style: AppTextStyles.labelMedium),
                            ],
                          ),
                        ),
                      ] else ...[
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 10,
                                backgroundImage: NetworkImage(reel.userProfileImage),
                                backgroundColor: Colors.grey[800]),
                            const SizedBox(width: 8),
                            Text(reel.userName, style: AppTextStyles.labelSmall),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(reel.description, style: AppTextStyles.small, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Share Options Box
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color:Color(0xFF333333),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _shareOptions.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1, indent: 16, endIndent: 16),
                itemBuilder: (context, index) {
                  final option = _shareOptions[index];
                  return ListTile(
                    title: Text(option['label'], style: AppTextStyles.caption),
                    trailing: option['isAsset']
                        ? Image.asset(
                      option['icon'],
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    )
                        : Icon(
                      option['icon'],
                      color: Colors.white,
                      size: 20,
                    ),
                    onTap: () {
                      controller.onShareOptionTap(reel.id ?? 0, option['label']);
                    },
                    dense: true,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}