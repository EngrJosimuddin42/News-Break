import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/me/me_controller.dart';
import '../../../models/history_model.dart';
import '../../../theme/app_colors.dart';


class HistoryItem extends StatelessWidget {
  final HistoryModel model;
  const HistoryItem({
    super.key,
    required this.model,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(model.title, style: AppTextStyles.buttonOutline,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
               SizedBox(height: 6),
                    Text(model.subtitle,style: AppTextStyles.overline.copyWith(color: Color(0xFF8EA0BC)),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Row(children: [
                      Image.asset('assets/icons/type.png', width: 18, height: 18),
                      SizedBox(width: 6),
                      Text(model.source, style: AppTextStyles.buttonOutline.copyWith(color: AppColors.dot)),
                      SizedBox(width: 16),
                      Image.asset('assets/icons/time.png', width: 18, height: 18),
                      SizedBox(width: 6),
                      Text(model.timeAgo, style: AppTextStyles.buttonOutline.copyWith(color: AppColors.dot)),
                    ]),
                   ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => _showRemoveBottomSheet(context),
                      child: const Icon(Icons.more_vert, color: Colors.white70, size: 20)),
                SizedBox( height: 12),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                       model.thumbnailUrl, width: 100, height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container( width: 100, height: 80,
                          color: Colors.grey[800]))),
                    // Play icon overlay
                    Positioned.fill(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(model.videoUrl);
                            if (!await launchUrl(url)) {

                            }
                          },
                          child: Container( width: 30, height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.white, 
                              shape: BoxShape.circle),
                            child: const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 30))))),
                        ],
                  ),
                  ],
              ),
             ],
                )
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.find<MeController>().deleteSingleHistoryItem(model.id);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF444444),
                    borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/delete.png', width: 20, height: 20),
                      const SizedBox(width: 12),
                      Text( 'Remove from history', style: AppTextStyles.caption),
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