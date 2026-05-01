import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/report_success.dart';
import '../../controllers/social_interaction_controller.dart';
import '../../controllers/socials/socials_controller.dart';
import '../../widgets/bottom_sheet_handle.dart';

class SocialsReportSheet extends GetView<SocialsController> {
  final dynamic contentId;
  final String contentType;

  const SocialsReportSheet({
    super.key,
    this.contentId = 0,
    this.contentType = 'post',
  });

  @override
  Widget build(BuildContext context) {
    final socialInteractionCtrl = Get.find<SocialInteractionController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      socialInteractionCtrl.openReport(contentId, contentType);
    });

    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFF2C2C2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Obx(() => socialInteractionCtrl.isReportSubmitted.value
          ? const ReportSuccess()
          : _buildSelectReason(context, socialInteractionCtrl)),
    );
  }

  Widget _buildSelectReason(
      BuildContext context,
      SocialInteractionController socialInteractionCtrl,
      ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetHandle(),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18)),
                Expanded(
                    child: Text('Select a reason',
                        style: AppTextStyles.caption, textAlign: TextAlign.center)),
                GestureDetector(
                    onTap: () {
                      socialInteractionCtrl.resetReport();
                      Get.back();
                    },
                    child: const Icon(Icons.close, color: Colors.white, size: 24)),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.reportReasons.length,
            itemBuilder: (_, i) {
              final reason = controller.reportReasons[i];
              return Obx(() => RadioListTile<String>(
                value: reason,
                groupValue: socialInteractionCtrl.selectedReason.value,
                onChanged: (val) => socialInteractionCtrl.selectReason(val!),
                title: Text(reason, style: AppTextStyles.caption),
                activeColor: Colors.white,
                dense: true,
              ));
            },
          ),

          // Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      socialInteractionCtrl.resetReport();
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                        fixedSize: const Size(140, 48),
                        side: const BorderSide(color: Color(0xFF959595)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: Text('Cancel', style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFFC4C4C4))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => socialInteractionCtrl.submitReport(),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(140, 48),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    child: Text('Submit', style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF242424))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}