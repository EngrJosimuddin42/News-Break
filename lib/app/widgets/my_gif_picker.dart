import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MyGifPicker extends StatelessWidget {
  final dynamic controller;

  const MyGifPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.9,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.isGifPickerMode.value = false;
                      controller.gifSearchQuery.value = '';
                    },
                    icon: const Icon(
                        Icons.close, color: AppColors.textOnDark, size: 20)),
                Expanded(
                    child: Container(height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFF121212),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextField(
                            style: AppTextStyles.caption.copyWith(
                                color: AppColors.textOnDark),
                            onChanged: (val) =>
                            controller.gifSearchQuery.value = val,
                            decoration: InputDecoration(
                                hintText: 'Search for GIFs',
                                hintStyle: AppTextStyles.caption.copyWith(
                                    color: AppColors.textOnDark),
                                prefixIcon: const Icon(
                                    Icons.search, color: AppColors.textOnDark,
                                    size: 20),
                                border: InputBorder.none,
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 10))))),
                TextButton(
                    onPressed: () {
                      controller.isGifPickerMode.value = false;
                      controller.gifSearchQuery.value = '';
                    },
                    child: Text('Cancel', style: AppTextStyles.bodyMedium)),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),

          Expanded(
            child: Obx(() =>
                GridView.builder(
                  padding: const EdgeInsets.all(2),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemCount: controller.filteredGifImages.length,
                  itemBuilder: (_, i) =>
                      GestureDetector(
                        onTap: () =>
                            controller.selectGif(
                                controller.filteredGifImages[i]),
                        child: Image.network(
                          controller.filteredGifImages[i],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[800]),
                        ),
                      ),
                )),
          ),
        ],
      ),
    );
  }
}