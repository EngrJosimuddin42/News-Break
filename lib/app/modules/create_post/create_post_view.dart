import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../controllers/create_post_controller.dart';

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
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white, size: 18)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.onPost,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: controller.isLoading.value
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text('Post', style: AppTextStyles.bodyMedium)))),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.textController,
                maxLines: null,
                minLines: 2,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: "Share your thoughts",
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,contentPadding: EdgeInsets.only(bottom: 2),)),

            Obx(() {
              final mediaFile = controller.selectedMedia.value;
              final thumbFile = controller.videoThumbnail.value;
              final bool isReel = controller.isReel.value;

              if (mediaFile == null) {
                return GestureDetector(
                  onTap: controller.onAddMedia,
                  child: Container(
                    width: 75, height: 67,
                    decoration: BoxDecoration(
                        color: const Color(0xFF444444),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                );
              }

              return Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                  image: isReel
                      ? (thumbFile != null
                      ? DecorationImage(image: FileImage(thumbFile), fit: BoxFit.cover)
                      : null)
                      : DecorationImage(image: FileImage(mediaFile), fit: BoxFit.cover),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isReel && thumbFile == null)
                      const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),

                    if (isReel && thumbFile != null)
                      const Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
                    Positioned(
                      right: 0, top: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.selectedMedia.value = null;
                          controller.videoThumbnail.value = null;
                          controller.isReel.value = false;
                        },
                        child: const Icon(Icons.cancel, color: Colors.red, size: 20),
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 32),

            // Tag location
            InkWell(
              onTap: controller.onTagLocation,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color:Color(0xFF333333)),
                    bottom: BorderSide(color:Color(0xFF333333)))),
                child: Row(
                  children: [
                    Image.asset('assets/icons/tag_location.png', width: 20, height: 20),
                    const SizedBox(width: 10),
                    Obx(() =>Text(controller.selectedLocation.isEmpty
                            ? 'Tag Location'
                            : controller.selectedLocation.value,
                      style: AppTextStyles.bodyMedium.copyWith( color: controller.selectedLocation.isEmpty
                              ? AppColors.textSecondary
                              : AppColors.surface))),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
    )
    );
  }
}