import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../ad_video_card.dart';
import '../clip_card.dart';
import '../people_card.dart';
import '../category_news_card.dart';

class ForYouTab extends GetView<HomeController> {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

    return ListView(
      children: [
        // People section
        _buildSectionHeader('People You May Like'),

      Obx(() {
      if (controller.suggestedPeople.isEmpty) {
      return const SizedBox.shrink();
      }
      return Column(
        children: [
        SizedBox(
        height: 175,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: controller.suggestedPeople.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final person = controller.suggestedPeople[i];

            return PeopleCard(
              name: person['name'],
              subtitle: person['subtitle'],
              isFollowing: person['isFollowing'],
              onDismiss: () => controller.onDismissPeople(i),
              onFollow: () => controller.onFollowPeople(i),
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
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final clip = controller.forYouClips[i];
              return GestureDetector(
                  onTap: () {
                    controller.selectedNavIndex.value = 1;
                  },
                  child: ClipCard(
                title: clip.title,
                subtitle: clip.subtitle,
                imageUrl: clip.imageUrl,
              )
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
          return CategoryNewsCard(news: news);
        }).toList(),

        const SizedBox(height: 16),
      ],
    );
    });
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}