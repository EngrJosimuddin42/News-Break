import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/social_interaction_controller.dart';
import '../../controllers/socials/socials_controller.dart';

class CommunityInsightView extends GetView<SocialsController> {
  const CommunityInsightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Color(0xFF959595), size: 20)),
          title: Text('Community insight center', style: AppTextStyles.displaySmall),
          centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Obx(() {
                  if (controller.communityInsights.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: controller.communityInsights.length,
                    itemBuilder: (_, i) {
                      final item = controller.communityInsights[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                    item['imageUrl']!,
                                    width: 72, height: 72,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(width: 72, height: 72, color: Colors.grey[200]))),
                            const SizedBox(width: 12),

                            // Title & Subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['title']!, style: AppTextStyles.bodySmall),
                                  const SizedBox(height: 4),
                                  Text(item['subtitle']!, style: AppTextStyles.labelSmall, maxLines: 3,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Join/Joined button
                            Obx(() {
                              final bool joined = SocialInteractionController.to
                                  .isJoined(i);
                              return OutlinedButton(
                                onPressed: () => SocialInteractionController.to.toggleJoin(i),
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide( color: joined
                                            ? Colors.blue
                                            : const Color(0xFFA9A9A9)),
                                    backgroundColor: joined
                                        ? Colors.blue
                                        : Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(44)),
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                child: Text(joined ? 'Joined' : 'Join', style: AppTextStyles.bodySmall.copyWith( color: joined ? Colors.white : Colors.black)),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  );
                }
                )
            ),
          ),
          Container(height: 40, color: Colors.black, width: double.infinity),
        ],
      ),
    );
  }
}