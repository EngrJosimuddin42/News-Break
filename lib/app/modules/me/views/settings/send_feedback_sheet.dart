import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class SendFeedbackSheet extends StatefulWidget {
  const SendFeedbackSheet({super.key});

  @override
  State<SendFeedbackSheet> createState() => _SendFeedbackSheetState();
}

class _SendFeedbackSheetState extends State<SendFeedbackSheet> {
  final TextEditingController _feedbackController = TextEditingController();
  int _rating = 3;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF282828),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 30, top: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Color(0xFF444444),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Center(
            child: Text('Share your feedback',
              style: AppTextStyles.displaySmall.copyWith(fontWeight: FontWeight.w700))),
          const SizedBox(height: 16),

          // Star rating
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Image.asset(
                      i < _rating
                          ? 'assets/icons/star.png'
                          : 'assets/icons/star1.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label
                Text('Write your feedback',
                  style: AppTextStyles.overline.copyWith(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 12),

                // Text area
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE5E5E5)),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.surface
                  ),
                  child: TextField(
                    controller: _feedbackController,
                    maxLines: null,
                    expands: true,
                    style:AppTextStyles.overline.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Write your feedback here...',
                      hintStyle: AppTextStyles.overline.copyWith(color: Color(0xFFB7B7B7)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Send button
          Center(
            child: SizedBox(
            width: 335,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:AppColors.linkColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              child: Text('Send Feedback',
                  style:AppTextStyles.bodyMedium.copyWith(color: AppColors.background)),
            ),
          ),
    )
        ],
      ),
    );
  }
}