import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../../controllers/me/settings/blog_controller.dart';
import '../../../../../models/blog_model.dart';
import '../../../../../widgets/help_widgets.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BlogController());
    return Scaffold(
      backgroundColor: const Color(0xFF252F39),
      appBar: HelpWidgets.helpAppBar('Help Center'),
      body: Column(
        children: [
          const HelpTabBar(),
          Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: controller.posts.map((post) => _buildCard(post)).toList())),
                  HelpWidgets.helpFooter(),
                ],
              ),
                );
              }),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BlogPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color:AppColors.surface,
        borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
             Image.network( post.imageUrl,
              width: double.infinity,
               fit: BoxFit.fitWidth,
                 errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image, color: Colors.grey, size: 48))),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Text(post.tag, style:AppTextStyles.overline.copyWith(color: AppColors.background)),
                const SizedBox(height: 6),

                // Title
                Text(post.title, style:AppTextStyles.bodySmall),
                const SizedBox(height: 8),

                // Body
                Text(post.body, style: AppTextStyles.overline.copyWith(color: AppColors.background)),
                const SizedBox(height: 12),

                // Author + date
                Row(
                  children: [
                    Text(post.author, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textOnDark)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('|', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textOnDark)),
                    ),
                    Text(post.date, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textOnDark)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}