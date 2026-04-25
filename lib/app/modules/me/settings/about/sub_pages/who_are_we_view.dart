import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../../controllers/me/who_are_we_controller.dart';
import '../../../../../widgets/custom_network_image.dart';
import '../../../../../widgets/help_widgets.dart';

class WhoAreWeView extends StatelessWidget {
  WhoAreWeView({super.key});

  final WhoAreWeController controller = Get.put(WhoAreWeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelpWidgets.helpAppBar('Help Center'),
      body: Column(
        children: [
          const HelpTabBar(),
        Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }
              if (!controller.isLoading.value && controller.aboutSections.isEmpty) {
                return const Center(child: Text("No information available."));
              }

              return ListView(
              children: [
                // About & Story
                ...controller.aboutSections.map((section) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HelpWidgets.redChip(section.chip),
                      const SizedBox(height: 8),
                      Text(section.title, style: AppTextStyles.chart.copyWith(color: Colors.black)),
                      const SizedBox(height: 12),
                      Text(section.desc, style:AppTextStyles.overline.copyWith(color: Color(0xFF6C6C6C))),
                      const SizedBox(height: 12),

                       CustomNetworkImage(imageUrl: section.image),

                      const SizedBox(height: 16),
                    ],
                  ),
                )),

                // Team
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Some people we\'d like\nyou to meet', textAlign: TextAlign.center, style:AppTextStyles.head )),

                ...controller.teamList.map((member) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      CircleAvatar( radius: 36,
                        backgroundImage: NetworkImage(member.imageUrl)),
                      const SizedBox(height: 8),
                      Text(member.name, style: AppTextStyles.button.copyWith(color: Color(0xFF333333))),
                      Text(member.role, style: AppTextStyles.textSmall.copyWith(color: Color(0xFF6C6C6C))),
                      const SizedBox(height: 12),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(member.bio, textAlign: TextAlign.center, style: AppTextStyles.overline)),
                    ],
                  ),
                )),

                HelpWidgets.helpFooter(),
              ],
              );
            }),
        ),
        ],
      ),
    );
  }
}