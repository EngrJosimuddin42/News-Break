import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/reels/profile/profile_option_sheet.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../models/reel_model.dart';
import '../../../widgets/app_snackbar.dart';
import '../player/full_screen_video_player.dart';
import '../share_sheet.dart';

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
            child: Icon(Icons.arrow_back_ios, color: AppColors.textOnDark, size: 20)),
        actions: [
          GestureDetector(
              onTap: () {
                ProfileOptionSheet.showOptions(
                  context,
                  user: widget.user,
                  onBlockConfirm: () {},
                  onReportSubmit: (String reason) {},
                );
              },
              child: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.more_vert, color: AppColors.textOnDark, size: 24))),
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
              ?.toString() ??
              widget.user?.totalFollowers?.toString() ??
              '0';

          return ListView(
            children: [
              // Profile Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar
                    CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        NetworkImage(widget.user?.userProfileImage ?? ""),
                        backgroundColor: Colors.grey[800]),
                    const SizedBox(height: 16),

                    // Name
                    Text(widget.user?.userName ?? "Unknown",
                        style: AppTextStyles.bodySmall
                            .copyWith(color: const Color(0xFFEAEAEA))),
                    const SizedBox(height: 16),

                    // Meta
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/icons/calender.png',
                            height: 14, width: 14),
                        const SizedBox(width: 4),
                        Text(
                            'user since ${widget.user?.userSince ?? "Unknown"}',
                            style: AppTextStyles.overline
                                .copyWith(color: AppColors.info)),
                        const SizedBox(width: 12),
                        Image.asset('assets/icons/location1.png',
                            height: 14, width: 14),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                              widget.user?.location ?? "Unknown Location",
                              style: AppTextStyles.overline,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statItem(postCount.toString(), 'Post'),
                        _buildVerticalDivider(),
                        _statItem(
                            widget.user?.totalViews?.toString() ?? '0', 'Views'),
                        _buildVerticalDivider(),
                        _statItem(followerCount, 'Followers'),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    //  Follow button — user-level state
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.toggleFollow(widget.user),
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

                    // Share button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          final reelDataForProfile = ReelModel(
                              id: widget.user?.id ?? 0,
                              userName: widget.user?.userName ?? "Unknown",
                              userProfileImage:
                              widget.user?.userProfileImage ?? "",
                              imageUrl: widget.user?.userProfileImage ?? "");
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
              ),

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

              if (_selectedTab == 0) _buildPostsTab(),
              if (_selectedTab == 1) _buildReactionsTab(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 30, width: 1, color: const Color(0xFF333333));
  }

  Widget _buildPostsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 16, 12),
          child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(60)),
              child: Text('Videos',
                  style: AppTextStyles.overline
                      .copyWith(color: AppColors.background))),
        ),
        if (widget.user?.userVideos == null || widget.user!.userVideos.isEmpty)
          const Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text("No videos found",
                      style: TextStyle(color: Colors.white))))
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 1),
            itemCount: widget.user?.userVideos.length ?? 0,
            itemBuilder: (_, i) {
              final video = widget.user!.userVideos[i];
              return GestureDetector(
                onTap: () {
                  final ReelsController reelsController =
                  Get.find<ReelsController>();
                  int index = reelsController.reelsList.indexWhere(
                          (r) => r.id.toString() == video['id'].toString());
                  if (index != -1) {
                    reelsController.updatePage(index);
                    Get.back();
                  } else {
                    Get.to(() =>
                        FullScreenVideoPlayer(url: video['videoUrl'] ?? ""));
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          video['imageUrl'] ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[900],
                              child: const Icon(Icons.play_circle_outline,
                                  color: Colors.white24)),
                        ),
                      ),
                      Positioned(
                        bottom: 0, left: 0, right: 0,
                        child: Container(
                          padding:
                          const EdgeInsets.fromLTRB(8, 20, 8, 6),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black87, Colors.transparent]),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(video['title']!,
                                  style: AppTextStyles.labelMedium),
                              Row(
                                children: [
                                  const Icon(Icons.play_arrow,
                                      color: Colors.white, size: 24),
                                  Text(video['views']!,
                                      style: AppTextStyles.labelMedium),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildReactionsTab() {
    final reactions = widget.user?.userReactions ?? [];
    return Column(
      children: reactions.map<Widget>((reaction) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 16,
                  backgroundImage:
                  NetworkImage(widget.user?.userProfileImage ?? ""),
                  backgroundColor: Colors.grey[800]),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.user?.userName ?? "User",
                            style: AppTextStyles.textSmall
                                .copyWith(color: AppColors.secondary)),
                        const SizedBox(width: 6),
                        Text('reacted',
                            style: AppTextStyles.display
                                .copyWith(color: AppColors.secondary)),
                        const SizedBox(width: 6),
                        Container(
                            width: 16, height: 16,
                            decoration: BoxDecoration(
                                color: AppColors.textGreen,
                                shape: BoxShape.circle),
                            child: Icon(Icons.thumb_up,
                                color: AppColors.surface, size: 10)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(reaction['time'] ?? "",
                        style: AppTextStyles.display
                            .copyWith(color: AppColors.textOnDark)),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        final ReelsController controller =
                        Get.find<ReelsController>();
                        int indexInMainList = controller.reelsList.indexWhere(
                                (reel) =>
                            reel.id.toString() ==
                                reaction['id'].toString());
                        if (indexInMainList != -1) {
                          controller.updatePage(indexInMainList);
                          Get.back();
                        } else {
                          if (reaction['videoUrl'] != null &&
                              reaction['videoUrl'] != "") {
                            Get.to(() => FullScreenVideoPlayer(
                                url: reaction['videoUrl']));
                          } else {
                            AppSnackbar.error(
                                message: 'Video link not found!');
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF333333),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(reaction['title'] ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.textSmall
                                      .copyWith(color: AppColors.surface)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(
                                  reaction['imageUrl']!,
                                  width: 64, height: 48,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                          width: 64,
                                          height: 48,
                                          color: Colors.grey[800]),
                                ),
                                const Icon(Icons.play_arrow,
                                    color: Colors.white, size: 18),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
          if (isSelected) Container(height: 2, width: 50, color: Colors.white),
        ],
      ),
    );
  }

  Widget _statItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: AppTextStyles.bodyMedium),
        Text(label, style: AppTextStyles.overline),
      ],
    );
  }
}