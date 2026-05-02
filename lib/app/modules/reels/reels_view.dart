import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/reels/comments/comments_sheet.dart';
import 'package:news_break/app/modules/reels/player/single_reel_player.dart';
import 'package:news_break/app/modules/reels/three_dot/three_dot_sheet.dart';
import 'package:news_break/app/modules/reels/share_sheet.dart';
import 'package:news_break/app/modules/reels/profile/profile_view.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/auth/auth_helper.dart';
import '../../controllers/reels/comment_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/reels/reels_controller.dart';
import '../../controllers/social_interaction_controller.dart';
import '../../models/comment_source.dart';
import '../../widgets/publisher_avatar.dart';
import '../../widgets/reels_follow_button.dart';
import 'create_reel_view.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  late final ReelsController controller;

  @override
  void initState() {
    super.initState();

    final homeController = Get.find<HomeController>();
    final hasCustomList = homeController.customReelsForNavigation.isNotEmpty;
    final initialIndex = homeController.customReelsInitialIndex.value;

    if (Get.isRegistered<ReelsController>()) {
      controller = Get.find<ReelsController>();
    } else {
      controller = Get.put(ReelsController());
    }
    if (hasCustomList) {
      controller.reelsList.clear();
      controller.reelsList.assignAll(homeController.customReelsForNavigation);
      homeController.customReelsForNavigation.clear();
      homeController.customReelsInitialIndex.value = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.pageController.hasClients && initialIndex > 0) {
          controller.pageController.jumpToPage(initialIndex);
        }
      });

    } else {
      controller.reelsList.clear();
      controller.fetchReels();
    }
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
             controller: controller.pageController,
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
              onTap: () {
                if (AuthHelper.checkLogin()) {
                  Get.to(() => const CreateReelView());
                }
              },
              child: Container(width: 36, height: 36,
                decoration: BoxDecoration(
                    color: Color(0xFF282828),
                    shape: BoxShape.circle),
                child:Icon(Icons.camera_alt_outlined,color:AppColors.surface, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(dynamic reel) {
    return Container( width: 279,  height: 60,
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      decoration: BoxDecoration(
        color: const Color(0x66000000),
        borderRadius: BorderRadius.circular(48),
        border: Border.all( color: const Color(0xFF616161), width: 1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PublisherAvatar.fromUrl(
              imageUrl: reel.userProfileImage ?? "",
            name: reel.userName ?? "U",
            size: 32.0,
            shape: BoxShape.circle),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(reel.userName ?? "User",
                style: AppTextStyles.bodyMedium),
              Text(reel.source?? "Just now", style: AppTextStyles.overline),
            ],
          ),
          const SizedBox(width: 12),
          ReelsFollowButton(reel: reel),
        ],
      ),
    );
  }

  Widget _buildReel(dynamic reel, int index) {
    final socialCtrl = Get.find<SocialInteractionController>();
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: SingleReelPlayer(
            videoUrl: reel.videoUrl ?? "",
            thumbnail: reel.imageUrl)),

        // Dark gradient bottom
        Positioned( bottom: 0, left: 0, right: 0,
          child: Container( height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent])))),

        Positioned(
          top: MediaQuery.of(context).padding.top + 8,  left: 16,
          child: _buildProfileCard(reel)),

        // Right side actions
        Positioned( right: 12, bottom: 120,
          child: Column(
            children: [
              // Profile
              GestureDetector(
                onTap: () {
                  if (AuthHelper.checkLogin()) {
                    Get.to(() => ProfileView(user: reel));
                  }
                },
                child: Stack(
                children: [
                  Container( width: 44, height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/timer.png'),
                        fit: BoxFit.cover))),
                  Positioned( bottom: 0, right: 0,
                    child: Container( width: 18,  height: 18,
                      decoration: BoxDecoration(
                        color:AppColors.textGreen,
                        shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Colors.white, size: 14))),
                ],
              ),
                ),
              const SizedBox(height: 16),

              // Like
              _actionBtn(
                icon: reel.isLiked == true
                    ? Icons.thumb_up
                    : Icons.thumb_up_outlined,
                color: reel.isLiked == true
                    ? AppColors.linkColor
                    : AppColors.surface,
                count: socialCtrl.formatCount(reel.likes),
                onTap: () {
                  if (AuthHelper.checkLogin()) {
                    controller.toggleLike(index);
                  }
                },
              ),

              const SizedBox(height: 16),

              // Comment
              Obx(() {
                final currentReel = controller.reelsList.firstWhere(
                      (r) => r.id == reel.id,
                  orElse: () => reel,
                );
                return _actionBtn(
                  assetIcon: 'assets/icons/comment2.png',
                  color: Colors.white,
                  count: socialCtrl.formatCount(currentReel.comments),
                  onTap: () {
                    if (AuthHelper.checkLogin()) {
                      Get.find<CommentController>().loadComments(
                          reel.id, CommentSource.reel);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        builder: (context) =>
                            CommentsSheet(id: reel.id, source: CommentSource.reel),
                      );
                    }
                  },
                );
              }),

              const SizedBox(height: 16),

              // Share Button
              _actionBtn(
                assetIcon: 'assets/icons/share2.png',
                color: Colors.white,
                count: socialCtrl.formatCount(reel.shares),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
                    builder: (_) => ShareSheet(reel: reel),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 3 dot Button
              GestureDetector(
                onTap: () {
                  if (AuthHelper.checkLogin()) {
                    showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width),
                  builder: (context) => ThreeDotSheet(reelId: reel.id,
                    authorName: reel.userName ?? "Unknown",

                    onShare: () {
                      Get.back();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
                        builder: (_) => ShareSheet(reel: reel),
                      );
                    },

                    onSave: () {
                      Get.back();
                      controller.saveReel(reel.id);
                    },

                    onReport: () {
                      controller.reportReel(reel.id, context);
                    },
                  ),
                );
                 }
                  },
                child: const Icon(Icons.more_vert, color: Colors.white, size: 32),

              ),
            ],
          ),
        ),

        // Comment input
        Positioned( bottom: 20, left: 0, right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () {
                if (AuthHelper.checkLogin()) {
                  Get.find<CommentController>().loadComments( reel.id, CommentSource.reel);

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width),
                    builder: (context) => CommentsSheet( id: reel.id, source: CommentSource.reel),
                  );
                }
              },
              child: Container( height: 40, width: 335,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: AppColors.surface),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                      alignment: Alignment.centerLeft,
                    child: Text( 'Write a comment...', style: AppTextStyles.overline))))))),
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
            assetIcon, width: 28, height: 28,
            color: color)
              : Icon(icon, color: color, size: 28),
          const SizedBox(height: 2),
          Text(count, style: AppTextStyles.buttonOutline),
        ],
      ),
    );
  }
}