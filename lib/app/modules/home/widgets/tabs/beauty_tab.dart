import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../category_news_card.dart';

class BeautyTab extends GetView<HomeController> {
  const BeautyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        padding: const EdgeInsets.only(top: 4, bottom: 16),
        itemCount: controller.beautyNews.length,
        itemBuilder: (context, index) {
          final news = controller.beautyNews[index];
          return CategoryNewsCard(news: news);
        },
      );
    });
  }
}