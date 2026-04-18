import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';

class ReportVideoSheet extends StatelessWidget {
  const ReportVideoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ReelsController controller = Get.find<ReelsController>();
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios,color: Colors.white, size: 20)),
                Expanded(
                  child: Text('Report video',
                      textAlign: TextAlign.center,
                      style:AppTextStyles.caption)),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(Icons.close,color: Colors.white, size: 20)),
              ],
            ),
          ),
          SizedBox(height: 6),
          const Divider(color: Colors.white12, height: 1),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Infringing my rights',
                    style: AppTextStyles.caption),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style:AppTextStyles.overline,
                    children: [
                      TextSpan(text: 'Visit the '),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => controller.openHelpCenter(),
                          child: Text('help center',
                              style:AppTextStyles.overline.copyWith(color: AppColors.textGreen)),
                        ),
                      ),
                       TextSpan( text: ' for more information to submit a copyright infringement notice.'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                  width: 311,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.openHelpCenter();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:AppColors.linkColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                    child:Text('Open Help Center',
                        style:AppTextStyles.bodySmall)),
                ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}