import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth/auth_helper.dart';
import '../controllers/reels/reels_controller.dart';
import '../theme/app_text_styles.dart';

class ReelsFollowButton extends StatelessWidget {
  final dynamic reel;

  const ReelsFollowButton({
    super.key,
    required this.reel,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReelsController>(
      builder: (controller) {
        final String userName = reel.userName ?? '';
        final bool isFollowing = controller.isUserFollowing(userName);

        return GestureDetector(
          onTap: () {
            if (AuthHelper.checkLogin()) {
              controller.toggleFollow(reel);
            }
          },
          child: isFollowing
              ? Text(
            'Following',
            style: AppTextStyles.bodySmall
                .copyWith(color: const Color(0xFFC4C4C4)),
          )
              : Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                color: const Color(0xFF3597FA),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              '+ Follow',
              style: AppTextStyles.buttonOutline,
            ),
          ),
        );
      },
    );
  }
}