import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../theme/app_colors.dart';
import '../ad_video_card.dart';
import '../category_news_card.dart';


class LocalTvTab extends GetView<HomeController> {
  final String message;

  const LocalTvTab({
    super.key,
    this.message = 'No relevant articles',
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final hasLocation = controller.selectedLocation.value != null;
      return hasLocation ? _buildWithLocation() : _buildWithoutLocation();
    });
  }

  Widget _buildWithoutLocation() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/socket.png',
            width: 130,
            height: 130,
          ),
          const SizedBox(height: 16),
          Text(message,
            style:AppTextStyles.caption.copyWith(color: Color(0xFF9B9B9B)),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: controller.onTryAgain,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(20),
              minimumSize: const Size(90, 50),
              side: const BorderSide(color: AppColors.linkColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
            ),
            child:Text('Try Again',
              style:AppTextStyles.caption.copyWith(color: AppColors.linkColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithLocation() {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 4, bottom: 16),
        itemCount: controller.localTvNews.length,
        itemBuilder: (context, index) {
          final news = controller.localTvNews[index];
          if (news.publisherType == 'Ad') {
            return AdVideoCard(news: news);
          }
          return CategoryNewsCard(news: news);
        },
      );
  }
}