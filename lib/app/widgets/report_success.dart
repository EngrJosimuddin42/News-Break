import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class ReportSuccess extends StatelessWidget {
  final String message;
  final VoidCallback? onDone;

  const ReportSuccess({
    super.key,
    this.message = 'Thanks for reporting this',
    this.onDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(width: 30, height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2)),
            child: const Icon(Icons.check, color: Colors.green, size: 20)),
          const SizedBox(height: 16),
          Text(message, style: AppTextStyles.caption),
          const SizedBox(height: 24),
          SizedBox(width: 311, height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (onDone != null) {
                  onDone!();
                } else {
                  Get.back();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 20)),
              child:Text('Done', style: AppTextStyles.bodySmall.copyWith(color: Color(0xFF242424))))),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}