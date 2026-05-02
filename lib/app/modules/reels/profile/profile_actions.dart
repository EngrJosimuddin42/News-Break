import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../models/reel_model.dart';
import '../share_sheet.dart';

class ProfileActions extends StatelessWidget {
  final dynamic user;
  final ReelsController controller;
  final bool isFollowing;

  const ProfileActions({
    super.key,
    required this.user,
    required this.controller,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [

            // Action Buttons
            Expanded(
              child: GestureDetector(
                onTap: () => controller.toggleFollow(user),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1D1D1D),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      isFollowing ? 'Following' : 'Follow',
                      style: AppTextStyles.buttonOutline.copyWith(
                          color: isFollowing
                              ? Colors.grey
                              : Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final reelDataForProfile = ReelModel(
                      id:user?.id ?? 0,
                      userName:user?.userName ?? "Unknown",
                      userProfileImage:
                      user?.userProfileImage ?? "",
                      imageUrl:user?.userProfileImage ?? "");
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width),
                    builder: (_) => ShareSheet(
                        reel: reelDataForProfile,
                        isProfileShare: true),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1D1D1D),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text('Share',
                          style: AppTextStyles.buttonOutline)),
                ),
              ),
            ),
          ],
        ),
      );
  }
}