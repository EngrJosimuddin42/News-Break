import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/reels/profile/posts_tab.dart';
import 'package:news_break/app/modules/reels/profile/profile_actions.dart';
import 'package:news_break/app/modules/reels/profile/profile_header.dart';
import 'package:news_break/app/modules/reels/profile/profile_option_sheet.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';
import 'package:news_break/app/modules/reels/profile/reactions_tab.dart';

import '../../../widgets/app_snackbar.dart';

class ProfileView extends StatefulWidget {
  final dynamic user;
  const ProfileView({super.key, this.user});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ReelsController controller = Get.find<ReelsController>();
      controller.incrementProfileView(widget.user);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios,
                color: AppColors.textOnDark, size: 20)),

        actions: [
          GestureDetector(
            onTap: () {
              ProfileOptionSheet.showOptions(
                context,
                user: widget.user,
                onBlockConfirm: () {
                  final ReelsController controller = Get.find<ReelsController>();

                  bool isBlocked = controller.hideAuthorContent(widget.user?.userName ?? '');

                  if (isBlocked) {
                    Get.back();
                    Get.back();
                    AppSnackbar.success(message: 'User blocked successfully');
                  }
                },
                onReportSubmit: (String reason) {},
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.more_vert, color: AppColors.textOnDark, size: 24),
            ),
          ),
        ],
      ),

      body: GetBuilder<ReelsController>(
        builder: (controller) {
          final String userName = widget.user?.userName ?? '';
          final bool isFollowing = controller.isUserFollowing(userName);
          final int postCount = controller.getUserPostCount(userName);
          final String followerCount = controller.reelsList
              .firstWhereOrNull((r) => r.userName == userName)
              ?.totalFollowers
              .toString() ??
              widget.user?.totalFollowers?.toString() ??
              '0';

          return ListView(
            children: [

              // Profile Header
              ProfileHeader(
                user: widget.user,
                postCount: postCount.toString(),
                followerCount: followerCount),

              // Profile Actions
              ProfileActions(
                user: widget.user,
                controller: controller,
                isFollowing: isFollowing),

              const SizedBox(height: 12),
              const Divider(color: Colors.white12, height: 1),
              const SizedBox(height: 12),

              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _tabItem('Posts', 0),
                    const SizedBox(width: 24),
                    _tabItem('Reactions', 1),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.white12, height: 1),
              const SizedBox(height: 8),

              if (_selectedTab == 0) PostsTab(  user: widget.user, controller: controller),
              if (_selectedTab == 1) ReactionsTab( user: widget.user, controller: controller),
            ],
          );
        },
      ),
    );
  }


  Widget _tabItem(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        children: [
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 2),
          if (isSelected)
            Container(height: 2, width: 50, color: Colors.white),
        ],
      ),
    );
  }
}