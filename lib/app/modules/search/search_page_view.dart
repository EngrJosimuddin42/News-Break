import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({super.key});

  @override
  Widget build(BuildContext context) {

    final SearchPageController controller = Get.put(SearchPageController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios, color: AppColors.textOnDark, size: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        controller: controller.searchController,
                        autofocus: true,
                        style: AppTextStyles.caption,
                        onChanged: controller.onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                          suffixIcon: Obx(() => controller.query.isNotEmpty
                              ? GestureDetector(
                            onTap: controller.clearSearch,
                            child: const Icon(Icons.cancel, color: Colors.grey, size: 20))
                              : const SizedBox.shrink()),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10))))),
                ],
              ),
            ),

            // Trending label
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text('Trending', style: AppTextStyles.button)),

            // Big card containing all items
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0B0B),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF737373))),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Find an item field
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B0B0B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE6E6E6))),
                      child: TextField(
                        controller: controller.filterController,
                        style: AppTextStyles.caption,
                        onChanged: (_) => controller.update(),
                        decoration: const InputDecoration(
                          hintText: 'Find an item',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                          border: InputBorder.none))),

                    const SizedBox(height: 8),

                    // Each item — separate card
                    Obx(() {
                      final items = controller.filteredItems;
                      return Column(
                        children: items.map((item) {
                          final isSelected = controller.selectedItem.value == item;
                          return GestureDetector(
                            onTap: () => controller.selectItem(item),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF121212),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: isSelected ? AppColors.textGreen : const Color(0xFF121212),
                                  width: 1)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(item, style: AppTextStyles.caption)),
                                  if (isSelected)
                                    Icon(Icons.check, color: AppColors.textGreen, size: 20),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
    ),),
          ],
        ),
      ),
    );
  }
}