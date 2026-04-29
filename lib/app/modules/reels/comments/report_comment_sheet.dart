import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/comment_controller.dart';
import '../../../controllers/social_interaction_controller.dart';
import '../../../widgets/report_success.dart';

class ReportCommentSheet extends StatefulWidget {
  const ReportCommentSheet({super.key});

  @override
  State<ReportCommentSheet> createState() => _ReportCommentSheetState();
}

class _ReportCommentSheetState extends State<ReportCommentSheet> {
  String? _selectedReason;
  int _step = 0;

  final socialCtrl = Get.find<SocialInteractionController>();
  final commentController = Get.find<CommentController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: _step == 0
          ? _buildReportBody()
          : ReportSuccess(onDone: () => Get.back()),
    );
  }

  Widget _buildReportBody() {
    final commentController = Get.find<CommentController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 16, 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back_ios, color: AppColors.surface, size: 20)),
              Expanded(
                child: Text('Report Comment', textAlign: TextAlign.center, style: AppTextStyles.caption)),
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.close, color: AppColors.surface, size: 20)),
            ],
          ),
        ),
        const Divider(color: Colors.white12, height: 1),

        // Reasons
        Column(
          children: commentController.reportReasons.map((reason) {
            return RadioListTile<String>(
              value: reason,
              groupValue: _selectedReason,
              onChanged: (val) => setState(() => _selectedReason = val),
              title: Text(reason, style: AppTextStyles.caption),
              activeColor: Colors.white,
              dense: true,
            );
          }).toList(),
        ),

        // Submit button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: SizedBox(width: 311, height: 48,
            child: ElevatedButton(
                onPressed: () {
                  if (_selectedReason != null) {
                    socialCtrl.selectedReason.value = _selectedReason;
                    socialCtrl.reportContentId.value = 0;
                    socialCtrl.reportContentType.value = 'comment';
                    socialCtrl.submitReport();
                    setState(() => _step = 1);
                  }
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Text('Submit', style: AppTextStyles.buttonOutline.copyWith(color: AppColors.background))))),
        SizedBox(height: 6)
      ],
    );
  }
}