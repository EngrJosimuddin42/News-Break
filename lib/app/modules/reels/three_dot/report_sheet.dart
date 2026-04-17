import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';
import 'report_video_sheet.dart';

class ReportSheet extends StatefulWidget {
  final int reelId;
  const ReportSheet({super.key, required this.reelId});

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  final ReelsController controller = Get.find<ReelsController>();
  // 0=select reason, 1=success
  int _step = 0;
  String? _selectedReason;

  static const List<String> _reasons = [
    'Abusive or hateful',
    'Misleading or spam',
    'Violence or gory',
    'Sexual Content',
    'Minor safety',
    'Dangerous or criminal',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: _step == 0 ? _buildSelectReason() : _buildSuccess(),
    );
  }

  Widget _buildSelectReason() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  },
                child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
              ),
              Expanded(
                child: Text('Report',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.close,color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        const Divider(color: Colors.white12, height: 1),

        // Reasons
        ..._reasons.map((reason) => RadioListTile<String>(
          value: reason,
          groupValue: _selectedReason,
          onChanged: (val) => setState(() => _selectedReason = val),
          title: Text(reason,
              style:AppTextStyles.caption),
          activeColor: Colors.white,
          dense: true,
        )),

        // Infringing my rights
        ListTile(
          title: Text('Infringing my rights',
              style:AppTextStyles.caption),
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
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(140, 48),
                    side:BorderSide(color:AppColors.textOnDark),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: Text('Cancel',
                      style: AppTextStyles.bodySmall.copyWith(color: Color(0xFFC4C4C4))),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedReason != null) {
                       controller.submitReport(reelId: widget.reelId, reason: _selectedReason!);
                      setState(() => _step = 1);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:AppColors.surface,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Submit',
                    style:AppTextStyles.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 30, height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: const Icon(Icons.check, color: Colors.green, size: 20),
          ),
          const SizedBox(height: 16),
          Text('Thanx for reporting this',
              style: AppTextStyles.caption),
          const SizedBox(height: 24),
          SizedBox(
            width: 311,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child:Text('Done', style: AppTextStyles.bodySmall.copyWith(color: Color(0xFF242424)),),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}