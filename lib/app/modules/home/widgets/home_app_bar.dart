import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleSpacing: 16,
      title: GestureDetector(
        onTap: c.onChooseLocation,
        child: Obx(() => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(c.locationTitle,
              style: AppTextStyles.headlineMedium,
              overflow: TextOverflow.ellipsis,
             maxLines: 1)),
            const SizedBox(width: 6),
            Container(width: 18, height: 18,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle),
              child: const Center(
                child: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.background, size: 15))),
          ],
        )),
      ),

      actions: [
        IconButton(
          onPressed: c.onAI,
          icon: Image.asset('assets/icons/add.png', width: 22, height: 22)),
        IconButton(
          onPressed: c.onSearch,
          icon: Image.asset('assets/icons/search.png', width: 22, height: 22)),
        IconButton(
          onPressed: c.onManageLocation,
          icon: Image.asset('assets/icons/location.png', width: 22, height: 22)),
      ],
    );
  }
}