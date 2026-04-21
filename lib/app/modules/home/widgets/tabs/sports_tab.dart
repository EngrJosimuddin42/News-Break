import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../ad_video_card.dart';
import '../category_news_card.dart';

class SportsTab extends GetView<HomeController> {
  const SportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        padding: const EdgeInsets.only(top: 4, bottom: 16),
        itemCount: controller.sportsNews.length,
        itemBuilder: (context, index) {
          final news = controller.sportsNews[index];

          if (news.publisherType == 'Ad') {
            return controller.isLoggedIn
                ? AdVideoCard(news: news)
                : const SizedBox.shrink();
          }
          return CategoryNewsCard(news: news);
        },
      );
    });
  }
}