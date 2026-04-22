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

            // Media picker section
            Obx(() => GestureDetector(
              onTap: controller.onAddMedia,
              child: controller.selectedImage.value != null
                  ? Container(
                width: 75, height: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: FileImage(controller.selectedImage.value!),
                    fit: BoxFit.cover)),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => controller.selectedImage.value = null,
                    child: const Icon(Icons.cancel, color: Colors.white, size: 20))))
                  : Container(
                width: 75, height: 67,
                decoration: BoxDecoration(
                    color: const Color(0xFF444444),
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.add, color: AppColors.white, size: 28),
              ),
            )),

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