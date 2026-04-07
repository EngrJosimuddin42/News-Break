import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../controllers/tag_location_controller.dart';

class TagLocationView extends GetView<TagLocationController> {
  const TagLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: controller.searchController,
                        style: AppTextStyles.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Find Location',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary),
                          prefixIcon: const Icon(Icons.search,
                              color: AppColors.textSecondary, size: 18),
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: controller.onCancel,
                    child: Text('Cancel',
                        style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.white)),
                  ),
                ],
              ),
            ),

            // Location list
            Obx(() => Expanded(
              child: ListView.separated(
                itemCount: controller.locations.length,
                separatorBuilder: (_, __) =>
                const Divider(color: Colors.white12, height: 1),
                itemBuilder: (_, i) {
                  final loc = controller.locations[i];
                  return ListTile(
                    onTap: () => controller.onSelectLocation(loc),
                    title: Text(loc['city']!,
                        style: AppTextStyles.bodyMedium),
                    subtitle: Text(loc['zip']!,
                        style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary)),
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}