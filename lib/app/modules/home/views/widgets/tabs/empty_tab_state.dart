import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../theme/app_colors.dart';
import '../../../controllers/home_controller.dart';


class EmptyStateTab extends GetView<HomeController> {
  final String message;

  const EmptyStateTab({
    super.key,
    this.message = 'No relevant articles',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/socket.png',
            width: 90,
            height: 90,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: controller.onTryAgain,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}