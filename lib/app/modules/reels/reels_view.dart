import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/reels/comments_sheet.dart';
import 'package:news_break/app/modules/reels/three_dot_sheet.dart';
import 'package:news_break/app/modules/reels/share_sheet.dart';
import 'package:news_break/app/modules/reels/user_profile_view.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/reels/reels_controller.dart';
import 'create_reel_view.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final PageController _pageController = PageController();
  final ReelsController controller = Get.put(ReelsController());

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full screen page view
          Obx(() {
            if (controller.isLoading.value) {
            return const Center(
            child: CircularProgressIndicator(color: Colors.white),
           );
           }

          if (controller.reelsList.isEmpty) {
           return const Center(
           child: Text("No Reels Found", style: TextStyle(color: Colors.white)),
          );
          }

           return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
             itemCount: controller.reelsList.length,
             itemBuilder: (_, i) => _buildReel(controller.reelsList[i], i),
           );
          }),

          // Top camera icon
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 16,
            child: GestureDetector(
              onTap: () => Get.to(() => const CreateReelView()),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Color(0xFF282828),
                  shape: BoxShape.circle,
                ),
                child:Icon(Icons.camera_alt_outlined,color:AppColors.surface, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReel(dynamic reel, int index) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: (reel.imageUrl != null && reel.imageUrl!.isNotEmpty)
              ? Image.network(
            reel.imageUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              );
            },
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[900],
              child: const Icon(Icons.broken_image, color: Colors.white24),
            ),
          )
              : Container(color: Colors.grey[900]),
        ),

        // Dark gradient bottom
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
        ),

        // Right side actions
        Positioned(
          right: 12,
          bottom: 120,
          child: Column(
            children: [
              // Timer icon
              GestureDetector(
                onTap: () => Get.to(() => const UserProfileView()),
                child: Stack(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/timer.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color:AppColors.textGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
                ),
              const SizedBox(height: 20),

              // Like
              _actionBtn(
                icon: reel.isLiked == true
                    ? Icons.thumb_up
                    : Icons.thumb_up_outlined,
                color: reel.isLiked == true
                    ? AppColors.linkColor
                    : AppColors.surface,
                count: controller.formatCount(reel.likes),
                onTap: () => controller.toggleLike(index),
              ),

              const SizedBox(height: 16),

              // Comment
              _actionBtn(
                assetIcon: 'assets/icons/comment2.png',
                color: Colors.white,
                count: controller.formatCount(reel.comments),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const ReelsCommentsSheet(),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Share Button
              _actionBtn(
                assetIcon: 'assets/icons/share2.png',
                color: Colors.white,
                count: controller.formatCount(reel.shares),
                onTap: () {
                  controller.incrementShare(index);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: const Color(0xFF2C2C2E),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                    builder: (_) => ShareSheet(reel: reel),
                  );
                },
              ),

              // 3 dot Button
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  builder: (context) => ThreeDotSheet(
                    authorName: reel.userName ?? "Unknown",
                    onShare: () {
                      Get.back();
                      controller.shareReel(reel.id);
                    },
                    onSave: () {
                      Get.back();
                      controller.saveReel(reel.id);
                    },
                    onReport: () {
                      controller.reportReel(reel.id, context);
                    },
                  ),
                ),
                child: const Icon(Icons.more_vert, color: Colors.white, size: 32),
              ),
            ],
          ),
        ),

        // Bottom info
        Positioned(
          left: 16, right: 80, bottom: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reel.source ?? "", style: AppTextStyles.small),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(reel.userName ?? "", style: AppTextStyles.bodyMedium),
                  const SizedBox(width: 32),
                  if (reel.isFollowing == true)
                    Text('Following', style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFFC4C4C4)))
                  else
                    GestureDetector(
                      onTap: () => controller.toggleFollow(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFF3597FA), borderRadius: BorderRadius.circular(8)),
                        child: Text('+ Follow', style: AppTextStyles.buttonOutline),                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(reel.description ?? "", style: AppTextStyles.small),
            ],
          ),
        ),

        // Comment input
        Positioned(
          bottom: 1, left: 0, right: 0,
          child: GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const ReelsCommentsSheet(),
            ),
            child: Container(
              height: 36,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xFF333333)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Write a comment...',
                    style: AppTextStyles.display.copyWith(color: AppColors.textOnDark),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionBtn({
    IconData? icon,
    String? assetIcon,
    required Color color,
    required String count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          assetIcon != null
              ? Image.asset(
            assetIcon,
            width: 28,
            height: 28,
            color: color,
          )
              : Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(count,
              style: AppTextStyles.buttonOutline),
        ],
      ),
    );
  }
}