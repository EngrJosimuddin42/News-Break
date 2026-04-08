import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../controllers/edit_tabs_controller.dart';

class EditTabsView extends GetView<EditTabsController> {
  const EditTabsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: TextButton(
          onPressed: controller.onCancel,
          child: Text('Cancel', style: AppTextStyles.bodyMedium),
        ),
        leadingWidth: 80,
        title: Text('Edit Top Tabs', style: AppTextStyles.headlineSmall),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: controller.onSave,
            child: Text('Save',
                style: AppTextStyles.bodyMedium),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You can add or remove your top tabs here. These changes will not affect your main feed.',
              style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            Text('Select Topics', style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary)),
            const SizedBox(height: 12),

            Obx(() => Column(
              children: controller.selectedTopics.map((topic) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: GestureDetector(
                    onTap: () => controller.removeFromSelected(topic),
                    child: Image.asset('assets/icons/remove.png',
                        width: 24, height: 24),
                  ),
                  title: Text(topic, style: AppTextStyles.bodyMedium),
                );
              }).toList(),
            )),

            const SizedBox(height: 16),
            Text('All Topics', style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary)),
            const SizedBox(height: 12),

            Obx(() => Column(
              children: controller.allTopics.map((topic) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: GestureDetector(
                    onTap: () => controller.addToSelected(topic),
                    child: Image.asset('assets/icons/add_circle.png',
                        width: 24, height: 24),
                  ),
                  title: Text(topic, style: AppTextStyles.bodyMedium),
                );
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }
}