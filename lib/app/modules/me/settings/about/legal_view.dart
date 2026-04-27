import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/help_widgets.dart';

import '../../../../controllers/me/about_controller.dart';

enum LegalType { terms, privacy, notice }

class LegalView extends StatelessWidget { final LegalType type;

  const LegalView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AboutController(), tag: type.name);
    controller.fetchLegalData(type.name);

    return Obx(() => SharedView(
      isLoading: controller.isLoading.value,
      title: controller.title.value,
      subtitle: controller.subtitle.value,
      lastUpdated: controller.lastUpdated.value,
      importantNotice: controller.importantNotice.value,
      body: controller.body.value,
    ));
  }
}

// ── SharedView
class SharedView extends StatelessWidget {
  final bool isLoading;
  final String title;
  final String subtitle;
  final String lastUpdated;
  final String importantNotice;
  final String body;

  const SharedView({
    super.key,
    required this.isLoading,
    required this.title,
    required this.subtitle,
    required this.lastUpdated,
    required this.importantNotice,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelpWidgets.helpAppBar(title,showCloseIcon: false),
      body: Column(
          children: [
          const HelpTabBar(),

      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(subtitle, style:AppTextStyles.headlineLarge.copyWith(fontWeight: FontWeight.w400)),
            const SizedBox(height: 12),
            Text(lastUpdated, style:AppTextStyles.caption.copyWith(color: Color(0xFF525C5E))),
            const SizedBox(height: 16),
            Text(importantNotice, style:AppTextStyles.button.copyWith(color:Colors.black)),
            const SizedBox(height: 16),
            Text(body, style:AppTextStyles.caption.copyWith(color: Colors.black)),
          ],
        ),
      ),
      ],
    ),
    );
  }
}