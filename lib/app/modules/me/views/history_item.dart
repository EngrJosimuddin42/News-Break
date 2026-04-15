import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/me_controller.dart';

class HistoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String source;
  final String timeAgo;
  final String videoUrl;
  final String thumbnailUrl;

  const HistoryItem({
    super.key,
    required this.id,
    required this.title,
    required this.source,
    required this.timeAgo,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(title,
                  style: AppTextStyles.buttonOutline,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
               ),
                const SizedBox(width: 12),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        thumbnailUrl,
                        width: 100,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 100,
                          height: 80,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    // Play icon overlay
                    Positioned.fill(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(videoUrl);
                            if (!await launchUrl(url)) {

                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.white, 
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [Text('$source · $timeAgo',
            style: AppTextStyles.overline.copyWith(color: Color(0xFFAAB6C6))),
             GestureDetector(
               onTap: () => _showRemoveBottomSheet(context),
               child: const Icon(Icons.more_vert, color: Colors.white, size: 30),
             ),
           ],
          ),
        ],
      ),
    );
  }

  void _showRemoveBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0xFF282828),
      constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Get.find<MeController>().deleteSingleHistoryItem(id);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF444444),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/delete.png',
                        width: 20, height: 20,
                      ),
                      const SizedBox(width: 12),
                      Text( 'Remove from history',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}