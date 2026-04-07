import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../controllers/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: controller.onBack,
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white, size: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: controller.onPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A2A2A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Post', style: AppTextStyles.bodyMedium),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share your thoughts',
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary)),
            const SizedBox(height: 16),

            // Media picker
            GestureDetector(
              onTap: controller.onAddMedia,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: AppColors.white, size: 28),
              ),
            ),

            const Spacer(),

            // Tag location
            InkWell(
              onTap: controller.onTagLocation,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white12)),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/icons/ic_location.png',
                        width: 20, height: 20, color: AppColors.textSecondary),
                    const SizedBox(width: 10),
                    Text('Tag Location',
                        style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary)),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios,
                        color: AppColors.textSecondary, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}