import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/news_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class FollowButton extends StatelessWidget {
  final NewsModel news;

  const FollowButton({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return TextButton(
          onPressed: () => controller.toggleFollow(news),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            news.isFollowing ? 'Following' : 'Follow',
            style: AppTextStyles.bodyMedium.copyWith(
              color: news.isFollowing ? Colors.grey : AppColors.textGreen)),
        );
      },
    );
  }
}