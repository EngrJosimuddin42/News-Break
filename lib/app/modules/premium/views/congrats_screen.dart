import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Animated circle graphic
              SizedBox(
                width: 200, height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer ring
                    Container(
                      width: 200, height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF2A0A0A),
                      ),
                    ),
                    // Middle ring
                    Container(
                      width: 150, height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF3D0F0F),
                      ),
                    ),
                    // Inner circle
                    Container(
                      width: 90, height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFD5F5C),
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 40),
                    ),
                    // Sparkles
                    ..._sparkles(),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('Congratulations',
                  style: AppTextStyles.displaySmall.copyWith(fontSize: 24)),
              const SizedBox(height: 12),
              Text('Your payment is successfully done.',
                  style: AppTextStyles.textSmall.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Get.until((route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFD5F5C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Back',
                      style: AppTextStyles.labelLarge.copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  static List<Widget> _sparkles() {
    const positions = [
      {'top': 10.0, 'left': 30.0},
      {'top': 20.0, 'right': 20.0},
      {'bottom': 15.0, 'left': 20.0},
      {'bottom': 25.0, 'right': 30.0},
      {'top': 60.0, 'left': 5.0},
      {'top': 55.0, 'right': 5.0},
    ];
    return positions.map((pos) => Positioned(
      top: pos['top'],
      bottom: pos['bottom'],
      left: pos['left'],
      right: pos['right'],
      child: Icon(Icons.auto_awesome, color: Color(0xFFFD5F5C), size: 14),
    )).toList();
  }
}