import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class CreateReelView extends StatefulWidget {
  const CreateReelView({super.key});

  @override
  State<CreateReelView> createState() => _CreateReelViewState();
}

class _CreateReelViewState extends State<CreateReelView> {
  int _selectedTab = 0; // 0=Upload, 1=Video

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

          // Access camera
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 195,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(0x99989797),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('Access camera',
                        style: AppTextStyles.buttonOutline),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Access microphone
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 195,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(0x99989797),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic_outlined, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('Access Microphone',
                        style: AppTextStyles.buttonOutline),
                  ],
                ),
              ),
            ),
          ),
              const Spacer(),

              // Record button
              GestureDetector(
                onTap: () {},
                child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFC4C4C4).withValues(alpha: 0.5),
                    ),
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
                  color: Color(0xFF222222), // স্ক্রিনশটের ডার্ক কালার
                ),
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

  Widget _accessButton(IconData icon, String label) {
    return Container(
      width: 220,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF).withOpacity(0.2), // গ্লাস ইফেক্ট
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(label, style: AppTextStyles.buttonOutline),
        ],
      ),
    );
  }

  Widget _tab(IconData? icon, String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon, color: Colors.white, size: 30)
          else
            const SizedBox(height: 30),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}