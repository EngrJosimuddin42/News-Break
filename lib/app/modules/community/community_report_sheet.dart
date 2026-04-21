import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/report_success.dart';

class CommunityReportSheet extends StatefulWidget {
  const CommunityReportSheet({super.key});

  @override
  State<CommunityReportSheet> createState() => _CommunityReportSheetState();
}

class _CommunityReportSheetState extends State<CommunityReportSheet> {
  int _step = 0; // 0 = select reason, 1 = success
  String? _selectedReason;

  static const List<String> _reasons = [
    'Abusive or hateful',
    'Misleading or spam',
    'Violence or gory',
    'Sexual Content',
    'Minor safety',
    'Dangerous or criminal',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: _step == 0 ? _buildSelectReason() :ReportSuccess(),
    );
  }

  Widget _buildSelectReason() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 36, height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              ),
              Expanded(
                child: Text('Select a reason',
                 style:AppTextStyles.caption ,
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white12, height: 1),

        // Reasons
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _reasons.length,
          itemBuilder: (_, i) => RadioListTile<String>(
            value: _reasons[i],
            groupValue: _selectedReason,
            onChanged: (val) => setState(() => _selectedReason = val),
            title: Text(_reasons[i],
                style:AppTextStyles.caption),
            activeColor: Colors.white,
            dense: true,
          ),
        ),

        // Buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(140, 48),
                    side: const BorderSide(color: Color(0xFF959595)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child:Text('Cancel', style: AppTextStyles.bodySmall.copyWith(color: Color(0xFFC4C4C4)),),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedReason != null) {
                      setState(() => _step = 1);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(140, 48),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child:Text('Submit', style: AppTextStyles.bodySmall.copyWith(color: Color(0xFF242424)),),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}