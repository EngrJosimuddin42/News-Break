import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../news_card.dart';

class ReactionsTab extends GetView<HomeController> {
  const ReactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: controller.reactionsNews.length,
        itemBuilder: (context, index) {
          final news = controller.reactionsNews[index];

          return NewsCard(
            news: news,
            onFollow: () => controller.onFollow(news.publisherName),
            onDismiss: () => controller.onDismiss(news.publisherName),
          );
        },
      );
    });
  }
}