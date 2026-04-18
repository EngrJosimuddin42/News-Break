import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/reels/create_reel_controller.dart';

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
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ),

          const Spacer(),

          // Title
          Text('Create on NewsBreak',
              style:AppTextStyles.displaySmall),
          const SizedBox(height: 8),
          Text('To create videos, allow access to your\ncamera and microphone',
            textAlign: TextAlign.center,
            style: AppTextStyles.overline.copyWith(color: Color(0xFFC4C4C4))),

              const SizedBox(height: 32),

              // Access camera Button
              _accessButton(Icons.camera_alt_outlined, 'Access camera', () {}),
              const SizedBox(height: 12),

           // Access microphone Button
              _accessButton(Icons.mic_outlined, 'Access Microphone', () {}),

              const Spacer(),

              // Record button
              GestureDetector(
                onTap: () => controller.startRecording(),
                child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFC4C4C4).withValues(alpha: 0.5)),
                    child: Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
                  ),

          const SizedBox(height: 16),

          // Upload / Video tabs
               Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25, bottom: 40, left: 40, right: 140),
                decoration: const BoxDecoration(
                  color: Color(0xFF222222)),
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

  Widget _accessButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 195,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0x99989797),
          borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(label, style: AppTextStyles.buttonOutline),
          ],
        ),
      ),
    );
  }

  Widget _tab(IconData? icon, String label, int index) {
    return Obx(() {
      final isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon, color: Colors.white, size: 30)
          else
            const SizedBox(height: 40),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(color: isSelected ? Colors.white : Colors.white60)
          ),
        ],
      ),
    );
    });
  }
}
