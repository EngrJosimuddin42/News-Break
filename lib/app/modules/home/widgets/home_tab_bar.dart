import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();

    return SizedBox( height: 40,
      child:Obx(() => ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: c.tabs.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          // First item = edit icon
          if (i == 0) {
            return GestureDetector(
              onTap: c.onEditTabs,
              child: Container(width: 32, height: 32,
                alignment: Alignment.center,
                child: Image.asset('assets/icons/round-plus.png', width: 20, height: 20, color: AppColors.white)),
            );
          }

          final tabIndex = i - 1;

          return Obx(() {
            final isSelected = c.selectedTabIndex.value == tabIndex;
            return GestureDetector(
              onTap: () => c.onTabTap(tabIndex),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSelected ? AppColors.white : Colors.white24, width: 1)),
                child: Center(
                child: Text( c.tabs[tabIndex],  style: AppTextStyles.bodySmall.copyWith(
                    color: isSelected
                        ? AppColors.background
                        : AppColors.white,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w400)))),
            );
          });
        },
      ),
    ),
    );
  }
}