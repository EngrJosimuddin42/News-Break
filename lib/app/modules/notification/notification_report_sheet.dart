import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/report_success.dart';

import '../../controllers/notification/notification_controller.dart';

class NotificationReportSheet extends StatefulWidget {
  const NotificationReportSheet({super.key});

  @override
  State<NotificationReportSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<NotificationReportSheet> {
  final controller = Get.find<NotificationController>();
  // Steps: 0 = select reason, 1 = sub-reason, 2 = confirm, 3 = success
  int _step = 0;
  String? _selectedReason;
  String? _selectedSubReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom),
      child: _buildStep(),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _buildSelectReason();
      case 1:
        return _buildSubReason();
      case 2:
        return _buildConfirm();
      case 3:
        return ReportSuccess();
      default:
        return _buildSelectReason();
    }
  }

  // Step 0 — Select a reason
  Widget _buildSelectReason() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader('Select a reason'),
        const Divider(color: Colors.white12, height: 1),
        Obx(() => ListView.builder(
            shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.reportReasons.length,
            itemBuilder: (_, i) {
              final reason = controller.reportReasons[i];
              return RadioListTile<String>(
                  value: reason,
                  groupValue: _selectedReason,
                  onChanged: (val) => setState(() => _selectedReason = val),
                  title: Text(reason, style: AppTextStyles.caption),
                  activeColor: Colors.white,
                  dense: true);
            })),
        _buildButtons(
          onCancel: () => Navigator.pop(context),
          onNext: () { if (_selectedReason != null) setState(() => _step = 1);},
          nextLabel: 'Submit'),
        const SizedBox(height: 30),
      ],
    );
  }

  // Step 1 — Sub reason
  Widget _buildSubReason() {
    final subs = controller.reportSubReasons[_selectedReason] ?? ['Other'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader('How is it $_selectedReason',onBack: () => setState(() => _step = 0)),
        const Divider(color: Colors.white12, height: 1),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subs.length,
          itemBuilder: (_, i) => RadioListTile<String>(
            value: subs[i],
            groupValue: _selectedSubReason,
            onChanged: (val) => setState(() => _selectedSubReason = val),
            title: Text(subs[i],
              style: AppTextStyles.caption),
            activeColor: Colors.white,
            dense: true)),
        _buildButtons(
          onCancel: () => Navigator.pop(context),
          onNext: () {
            if (_selectedSubReason != null) setState(() => _step = 2);
          },
          nextLabel: 'Next'),
        const SizedBox(height: 30),
      ],
    );
  }

  // Step 2 — Confirm
  Widget _buildConfirm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader('You are about to submit a report',onBack: () => setState(() => _step = 1)),
        const Divider(color: Colors.white12, height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('We only remove content that goes against our socials standard. Review your report details below.',
                style: AppTextStyles.caption),
              const SizedBox(height: 16),
              _infoField('Why are you reporting this?', _selectedReason ?? ''),
              const SizedBox(height: 12),
              const Divider(color: Colors.white12, height: 1),
              const SizedBox(height: 12),
              _infoField('How is it $_selectedReason?', _selectedSubReason ?? ''),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(width: 311, height: 48,
            child: ElevatedButton(
             onPressed: () async {
                  await controller.submitReport(_selectedReason!, _selectedSubReason!);
                  setState(() => _step = 3);},
              style: ElevatedButton.styleFrom(
                backgroundColor:AppColors.surface,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 8)),
              child:Text('Submit', style:AppTextStyles.bodySmall)))),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildHeader(String title, {VoidCallback? onBack}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(title, style: AppTextStyles.caption, textAlign: TextAlign.center)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: Colors.white, size: 20)),
        ],
      ),
    );
  }

  Widget _buildButtons({
    required VoidCallback onCancel,
    required VoidCallback onNext,
    required String nextLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF959595)),
                minimumSize: const Size(140, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 20)),
              child: Text('Cancel', style: AppTextStyles.bodySmall.copyWith(color: Color(0xFFC4C4C4))))),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () { onNext();},
              style: ElevatedButton.styleFrom(
                backgroundColor:AppColors.surface,
                minimumSize: const Size(140, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 20)),
              child: Text(nextLabel, style:AppTextStyles.bodySmall))),
        ],
      ),
    );
  }

  Widget _infoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelSmall.copyWith(color: Color(0xFF6C6C6C))),
        const SizedBox(height: 6),
        Text(value, style: AppTextStyles.textSmall.copyWith(color: Color(0xFFD9D9D9))),
      ],
    );
  }
}