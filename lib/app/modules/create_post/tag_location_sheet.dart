import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/widgets/bottom_sheet_handle.dart';
import '../../theme/app_text_styles.dart';
import '../../controllers/create_post_controller.dart';

class TagLocationSheet extends GetView<CreatePostController> {
  const TagLocationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          const BottomSheetHandle(),
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: controller.locationSearchController,
                      style:AppTextStyles.caption,
                      onChanged: (val) => controller.filterLocations(val),
                      decoration: const InputDecoration(
                        hintText: 'Find Location',
                        hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Colors.white54, size: 18),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text('Cancel', style: TextStyle(color: Colors.blue, fontSize: 14)),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredLocations.length,
              itemBuilder: (_, i) {
                final loc = controller.filteredLocations[i];
                return ListTile(
                  onTap: () => Get.back(result: loc),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  title: Text(loc['city']!, style: AppTextStyles.caption),
                  subtitle: Text(loc['zip']!, style: AppTextStyles.overline),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}