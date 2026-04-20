import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../ad_video_card.dart';
import '../category_news_card.dart';

class EntertainmentTab extends GetView<HomeController> {
  const EntertainmentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      itemCount: controller.entertainmentNews.length + 1,// +1 for ad
      itemBuilder: (context, index) {
        if (index == 1) return const AdVideoCard(); // 2nd position এ ad
        final itemIndex = index > 1 ? index - 1 : index;
        final news = controller.entertainmentNews[itemIndex];
        return CategoryNewsCard(news: news);
      },
    );
    });
  }
}