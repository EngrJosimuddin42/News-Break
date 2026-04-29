import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../controllers/social_interaction_controller.dart';
import '../ad_video_card.dart';
import '../clip_card.dart';
import '../people_card.dart';
import '../category_news_card.dart';

class ForYouTab extends GetView<HomeController> {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    final socialController = Get.find<SocialInteractionController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

    return ListView(
      children: [
        // People section
        _buildSectionHeader('People You May Like'),

      Obx(() {
        if (socialController.suggestedPeople.isEmpty) {
      return const SizedBox.shrink();
      }
      return Column(
        children: [
        SizedBox( height: 175,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: socialController.suggestedPeople.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final person = socialController.suggestedPeople[i];

            return PeopleCard(
              name: person['name'],
              subtitle: person['subtitle'],
              isFollowing: person['isFollowing'],
              onDismiss: () => socialController.onDismissPeople(i),
              onFollow: () => socialController.onFollowPeople(i),
            );
          },
        ),
      ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white12, height: 2, thickness: 3),

        ],
        );
      }),
        const SizedBox(height: 6),

        // Local clips section
        _buildSectionHeader('Local clips'),
        SizedBox(
          height: 160,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: controller.forYouClips.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final reel = controller.forYouClips[i];
              return GestureDetector(
                  onTap: () {
                    controller.customReelsForNavigation.assignAll(controller.forYouClips);
                    controller.customReelsInitialIndex.value = i;
                    controller.selectedNavIndex.value = 1;
                  },
                  child: ClipCard(
                    title: reel.userName,
                    subtitle: reel.description,
                    imageUrl: reel.imageUrl)
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        const Divider(color: Colors.white12, height: 2, thickness: 3),
        const SizedBox(height: 12),

        // News Section
        ...controller.forYouNews.map((news) {
          if (news.publisherType == 'Ad') {
            return controller.isLoggedIn
                ? AdVideoCard(news: news)
                : const SizedBox.shrink();
          }
          return CategoryNewsCard(news: news, tabType: 'news_foryou');
        }),

        const SizedBox(height: 16),
      ],
    );
    });
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Text( title,
        style:AppTextStyles.headlineMedium),
    );
  }
}