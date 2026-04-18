import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';

class ReportCommentSheet extends StatefulWidget {
  const ReportCommentSheet({super.key});

  @override
  State<ReportCommentSheet> createState() => _ReportCommentSheetState();
}

class _ReportCommentSheetState extends State<ReportCommentSheet> {
  String? _selectedReason;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 16, 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child:Icon(Icons.arrow_back_ios,color:AppColors.surface, size: 20),
                ),
                Expanded(
                  child: Text('Report Comment',
                      textAlign: TextAlign.center,
                      style:AppTextStyles.caption),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close,color:AppColors.surface, size: 20),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),

          // Reasons
          ...Get.find<ReelsController>().reportReasons.map((reason) => RadioListTile<String>(
            value: reason,
            groupValue: _selectedReason,
            onChanged: (val) =>  setState(() => _selectedReason = val),
            title: Text(reason,
                style: AppTextStyles.caption),
            activeColor: Colors.white,
            dense: true,
          )),

          // Submit button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: SizedBox(
              width: 311,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedReason != null) {
                    Get.find<ReelsController>().submitReport(
                      reason: _selectedReason!,
                      type: 'comment',
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child:Text('Submit',
                  style:AppTextStyles.buttonOutline.copyWith(color:AppColors.background),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}