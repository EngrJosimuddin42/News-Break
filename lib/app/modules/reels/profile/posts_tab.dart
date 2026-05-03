import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../widgets/network_or_file_image.dart';
import '../player/full_screen_video_player.dart';

class PostsTab extends StatelessWidget {
  final dynamic user;
  final ReelsController controller;

  const PostsTab({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final String profileOwnerName = user?.userName ?? '';
    final authCtrl = Get.find<AuthController>();
    final String loginUserName = authCtrl.user.value?.userName ?? '';
    final String loginName = authCtrl.user.value?.name ?? '';

    return Obx(() {
      final userReels = controller.reelsList.where((r) {
        return r.userName == profileOwnerName ||
            r.userName == loginUserName ||
            r.userName == loginName ||
            r.userName == 'Me';
      }).toList();

      final bool hasReels = userReels.isNotEmpty;
      final bool hasVideos = user?.userVideos != null && user!.userVideos.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 16, 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(60)),
              child: Text('Videos', style: AppTextStyles.overline.copyWith(color: AppColors.background)))),

          if (!hasReels && !hasVideos)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text("No videos found", style: TextStyle(color: Colors.white))))

          else if (hasReels)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 1),
              itemCount: userReels.length,
              itemBuilder: (_, i) {
                final reel = userReels[i];
                return GestureDetector(
                  onTap: () {
                    int index = controller.reelsList.indexWhere((r) => r.id == reel.id);
                    if (index != -1) {
                      controller.updatePage(index);
                      Get.back();
                    } else {
                      Get.to(() => FullScreenVideoPlayer(url: reel.videoUrl ?? ""));
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: NetworkOrFileImage(
                            url: reel.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 6),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black87, Colors.transparent])),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( reel.description,
                                  style: AppTextStyles.labelMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                                Row(
                                  children: [
                                    const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                                    Text(reel.likes.toString(), style: AppTextStyles.labelMedium),
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
            )
          else
          // Fallback Grid (Static Videos)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 1),
              itemCount: user?.userVideos?.length ?? 0,
              itemBuilder: (_, i) {
                final video = user!.userVideos[i];
                return GestureDetector(
                  onTap: () {
                    int index = controller.reelsList.indexWhere(
                            (r) => r.id.toString() == video['id'].toString());
                    if (index != -1) {
                      controller.updatePage(index);
                      Get.back();
                    } else {
                      Get.to(() => FullScreenVideoPlayer(url: video['videoUrl'] ?? ""));
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: NetworkOrFileImage(
                            url: video['imageUrl'] ?? "",
                            fit: BoxFit.cover)),
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 6),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black87, Colors.transparent])),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(video['title']!, style: AppTextStyles.labelMedium),
                                Row(
                                  children: [
                                    const Icon(Icons.play_arrow, color: Colors.white, size: 24),
                                    Text(video['views']!, style: AppTextStyles.labelMedium),
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
    });
  }
}