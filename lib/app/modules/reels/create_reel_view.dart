import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/create_post_controller.dart';
import '../../controllers/reels/create_reel_controller.dart';
import '../create_post/create_post_view.dart';

class CreateReelView extends StatefulWidget {
  const CreateReelView({super.key});

  @override
  State<CreateReelView> createState() => _CreateReelViewState();
}

class _CreateReelViewState extends State<CreateReelView> {
  final CreateReelController controller = Get.put(CreateReelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0232, 0.6799],
            colors: [Color(0xFF583658), Color(0xFF657BC3)],
          ),
        ),
        child: Column(
          children: [
            // Close Button
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close, color: Colors.white, size: 24)),
                ],
              ),
            ),

            const Spacer(),

            // Header Section
            Text('Create on NewsBreak', style: AppTextStyles.displaySmall),
            const SizedBox(height: 8),
            Text(
              'To create videos, allow access to your\ncamera and microphone',
              textAlign: TextAlign.center,
              style: AppTextStyles.overline.copyWith(color: const Color(0xFFC4C4C4))),

            const SizedBox(height: 32),


            Obx(() => _accessButton(
              Icons.camera_alt_outlined,
              'Access camera', () => controller.requestCameraPermission(),
              controller.isCameraBtnPressed.value)),

            const SizedBox(height: 12),

            Obx(() => _accessButton(
              Icons.mic_outlined,
              'Access Microphone',
                  () => controller.requestMicPermission(),
              controller.isMicBtnPressed.value)),

            const Spacer(),

            const SizedBox(height: 87),

            // Record Button
            GestureDetector(
                onTap: () => controller.startRecording(),
                child: ClipOval(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(width: 64, height: 64,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFC4C4C4)),
                            child: Center(
                                child: Container(width: 48, height: 48,
                                    margin: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        shape: BoxShape.circle))))))),

            const SizedBox(height: 16),

            // Bottom Tabs
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 25, bottom: 40, left: 20, right: 160),
              decoration: const BoxDecoration(color: Color(0xFF222222)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tab(Icons.image, 'Upload', 0),
                  _tab(null, 'Video', 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Permission Action Button
  Widget _accessButton(IconData icon, String label, VoidCallback onTap, bool isPressed) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 195,
        height: 44,
        decoration: BoxDecoration(
          color: isPressed
              ? Colors.green.withValues(alpha: 0.7)
              : const Color(0x99989797),
          borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                isPressed ? Icons.check_circle : icon,
                color: Colors.white,
                size: 18),
            const SizedBox(width: 8),
            Text(
              isPressed ? 'Allowed' : label, style: AppTextStyles.buttonOutline),
          ],
        ),
      ),
    );
  }

  // Navigation Tab Item
  Widget _tab(IconData? icon, String label, int index) {
    return Obx(() {
      final isSelected = controller.selectedTab.value == index;
      return GestureDetector(
        onTap: () async {
          controller.changeTab(index);
          if (index == 0) {
            await controller.onAddMedia();
            if (controller.selectedMedia.value != null) {
              await Get.delete<CreatePostController>();
              Get.put(CreatePostController());
              Get.to(() => const CreatePostView(), arguments: controller.selectedMedia.value);
            }
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(icon, color: isSelected ? Colors.white : Colors.white60, size: 30)
            else
              const SizedBox(height: 40),
            Text(label, style: AppTextStyles.bodyMedium.copyWith(color: isSelected ? Colors.white : Colors.white60)),
          ],
        ),
      );
    });
  }
}