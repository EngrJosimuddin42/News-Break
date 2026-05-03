import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/me/me_controller.dart';

class MeActionButtons extends GetView<MeController> {
  const MeActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() => Row(
        children: [
          Expanded(
              child: OutlinedButton(
                  onPressed: controller.isCreator.value
                      ? controller.onCreatorDashboard
                      : controller.onBecomeCreator,
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(160, 50),
                      backgroundColor: Color(0xFF1D1D1D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: Text(
                      controller.isCreator.value
                          ? 'Creator dashboard'
                          : 'Become a creator',
                      style: AppTextStyles.buttonOutline))),
          const SizedBox(width: 12),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                OutlinedButton(
                    onPressed: controller.onCompleteProfile,
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(160, 50),
                        backgroundColor: Color(0xFF1D1D1D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    child:Text('Complete profile', style:AppTextStyles.buttonOutline)),

                // Red dot
                if (!controller.isProfileComplete)
                  Positioned( top: 8, right: 8,
                      child: Container( width: 6,  height: 6,
                          decoration:BoxDecoration(
                              color:AppColors.linkColor,
                              shape: BoxShape.circle))),
              ],
            ),
          ),
        ],
      )),
    );
  }
}