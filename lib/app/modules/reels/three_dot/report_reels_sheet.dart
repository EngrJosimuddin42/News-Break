import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/comment_controller.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../widgets/report_success.dart';
import 'report_video_sheet.dart';

class ReportReelsSheet extends StatefulWidget {
  final int reelId;
  const ReportReelsSheet({super.key, required this.reelId});

  @override
  State<ReportReelsSheet> createState() => _ReportReelsSheetState();
}

class _ReportReelsSheetState extends State<ReportReelsSheet> {
  final reelsController = Get.find<ReelsController>();
  final commentController = Get.find<CommentController>();
  int _step = 0;
  String? _selectedReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: _step == 0
          ? _buildSelectReason(context)
          : ReportSuccess(onDone: () => Get.back()),
    );
  }

  Widget _buildSelectReason(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 20)),
              Expanded(
                  child: Text('Report',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption)),
              GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.white, size: 20)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Divider(color: Colors.white12, height: 1),

        // ✅ reportReasons CommentController থেকে
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

        // Infringing my rights
        ListTile(
          title: Text('Infringing my rights', style: AppTextStyles.caption),
          trailing: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
          onTap: () {
            Get.back();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width),
              builder: (_) => const ReportVideoSheet(),
            );
          },
          dense: true,
        ),

        // Buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(140, 48),
                      side: BorderSide(color: AppColors.textOnDark),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: Text('Cancel',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: const Color(0xFFC4C4C4))),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedReason != null) {
                      commentController.submitReport(
                        id: widget.reelId,
                        reason: _selectedReason!,
                        type: 'reel',
                      );
                      setState(() => _step = 1);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: Text('Submit', style: AppTextStyles.bodySmall),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}