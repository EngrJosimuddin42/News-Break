import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final items = [
      {'icon': 'assets/icons/home.png', 'label': 'Home'},
      {'icon': 'assets/icons/reels.png', 'label': 'Reels'},
      {'icon': 'assets/icons/notification.png', 'label': 'Notification'},
      {'icon': 'assets/icons/actions_lovely.png', 'label': 'Community'},
      {'icon': 'assets/icons/person.png', 'label': 'Me'},
    ];

    return Obx(() => Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: Colors.white12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final isSelected = c.selectedNavIndex.value == i;
          return GestureDetector(
            onTap: () => c.onNavTap(i),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    items[i]['icon']!,
                    width: 24,
                    height: 24,
                    color: isSelected
                        ? AppColors.red
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    items[i]['label']!,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      color: isSelected
                          ? AppColors.red
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ));
  }
}