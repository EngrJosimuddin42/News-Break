import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../controllers/social_interaction_controller.dart';
import '../../../widgets/network_or_file_image.dart';
import '../player/full_screen_video_player.dart';

class ReactionsTab extends StatelessWidget {
  final dynamic user;
  final ReelsController controller;
  final bool isFullActivity;

  const ReactionsTab({
    super.key,
    required this.user,
    required this.controller,
    this.isFullActivity = false,
  });

  @override
  Widget build(BuildContext context) {
    final String profileOwnerName = user?.userName ?? '';
    final String loginUserName = Get.find<AuthController>().user.value?.userName ?? '';
    final String loginName = Get.find<AuthController>().user.value?.name ?? '';
    final bool isMyProfile = profileOwnerName == loginUserName;
    final socialCtrl = Get.find<SocialInteractionController>();
    String currentTime = DateFormat('EEEE h:mm a').format(DateTime.now());

    return Obx(() {
      final reactedReels = controller.reelsList.where((reel) {
        if (isMyProfile) {
          if (reel.userName == loginUserName || reel.userName == loginName) return false;
          final bool isLikedByMe = socialCtrl.likedIds.contains('reel_${reel.id}');
          final String myEmoji = socialCtrl.getMyReaction(reel.id, 'reel');
          final bool hasCommentedByMe = socialCtrl.commentList.any((c) =>
          c.reelId == reel.id &&
              (c.userName == loginUserName || c.userName == loginName));
          return isLikedByMe || myEmoji.isNotEmpty || hasCommentedByMe;
        } else {
          if (reel.userName == profileOwnerName) return false;
          final bool isLikedByOwner = socialCtrl.likedIds.contains('reel_${reel.id}');
          final bool commentedByOwner = socialCtrl.commentList.any((c) =>
          c.reelId == reel.id && c.userName == profileOwnerName);
          return isLikedByOwner || commentedByOwner;
        }
      }).toList();

      List reactedNews = [];
      if (isMyProfile) {
        final combined = <int, dynamic>{};
        for (final news in socialCtrl.likedNewsItems) {
          combined[news.id] = news;
        }
        for (final news in socialCtrl.commentedNewsItems) {
          combined[news.id] = news;
        }
        reactedNews = combined.values.where((news) {
          final bool isLiked = socialCtrl.likedIds.any((key) => key.contains('${news.id}'));
          final bool hasCommented = socialCtrl.commentList.any((c) =>
          c.reelId == news.id &&
              (c.userName == loginUserName || c.userName == loginName));
          return isLiked || hasCommented;
        }).toList();
      }

      final staticReactions = user?.userReactions ?? [];

      if (reactedReels.isEmpty && staticReactions.isEmpty && reactedNews.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Text('No Reactions', style: AppTextStyles.bodyMedium),
                const SizedBox(height: 8),
                Text(
                  "This user hasn't commented on\nor reacted to any articles. Yet.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.overline,
                ),
              ],
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            // Reels Reactions
            ...reactedReels.map((reel) {
              String reactionText = 'liked';
              Widget reactionIcon = Container(
                width: 16, height: 16,
                decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                child: const Icon(Icons.thumb_up, color: Colors.white, size: 10),
              );

              if (isMyProfile) {
                final String emoji = socialCtrl.getMyReaction(reel.id, 'reel');
                final bool hasCommentedByMe = socialCtrl.commentList.any((c) =>
                c.reelId == reel.id &&
                    (c.userName == loginUserName || c.userName == loginName));

                if (emoji.isNotEmpty) {
                  reactionText = 'reacted $emoji';
                  reactionIcon = const SizedBox.shrink();
                } else if (hasCommentedByMe) {
                  reactionText = 'commented';
                  reactionIcon = const Icon(Icons.comment, color: Colors.white, size: 14);
                } else if (socialCtrl.likedIds.contains('reel_${reel.id}')) {
                  reactionText = 'liked';
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(user?.userProfileImage ?? ""),
                      backgroundColor: Colors.grey[800],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(profileOwnerName,
                                  style: AppTextStyles.textSmall.copyWith(color: AppColors.secondary)),
                              const SizedBox(width: 6),
                              Text(reactionText,
                                  style: AppTextStyles.display.copyWith(color: AppColors.secondary)),
                              const SizedBox(width: 6),
                              if (reactionText == 'liked' || reactionText == 'commented')
                                reactionIcon,
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(currentTime,
                              style: AppTextStyles.display.copyWith(
                                  color: AppColors.textOnDark, fontSize: 10)),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              if (isMyProfile) {
                                Get.to(
                                      () => FullScreenVideoPlayer(url: reel.videoUrl ?? ''),
                                  arguments: reel,
                                );
                              } else {
                                int index = controller.reelsList.indexWhere((r) => r.id == reel.id);
                                if (index != -1) {
                                  controller.updatePage(index);
                                  Get.back();
                                }
                              }
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF333333),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(reel.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.textSmall.copyWith(color: AppColors.surface)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    NetworkOrFileImage(
                                      url: reel.imageUrl,
                                      width: 64,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    const Icon(Icons.play_arrow, color: Colors.white, size: 18),
                                  ],
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
            }),

            // News Reactions
            if (isFullActivity)
              ...reactedNews.map((news) {
                final bool isLiked = socialCtrl.likedIds.any((key) => key.contains('${news.id}'));
                String newsReactionText = isLiked ? 'liked' : 'commented';

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(user?.userProfileImage ?? ""),
                        backgroundColor: Colors.grey[800],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(profileOwnerName,
                                    style: AppTextStyles.textSmall.copyWith(color: AppColors.secondary)),
                                const SizedBox(width: 6),
                                Text(newsReactionText,
                                    style: AppTextStyles.display.copyWith(color: AppColors.secondary)),
                                const SizedBox(width: 6),
                                Container(
                                  width: 16, height: 16,
                                  decoration: BoxDecoration(
                                      color: newsReactionText == 'liked' ? Colors.blue : Colors.green,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                      newsReactionText == 'liked' ? Icons.thumb_up : Icons.comment,
                                      color: Colors.white, size: 10),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(currentTime,
                                style: AppTextStyles.display.copyWith(
                                    color: AppColors.textOnDark, fontSize: 10)),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF333333),
                                          borderRadius: BorderRadius.circular(6)),
                                      child: Text(news.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.textSmall.copyWith(color: AppColors.surface)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  NetworkOrFileImage(
                                    url: news.imageUrl,
                                    width: 64,
                                    height: 48,
                                    fit: BoxFit.cover,
                                    borderRadius: BorderRadius.circular(6),
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
              }),

            // Static Reactions (Fallback Data)
            ...staticReactions.map<Widget>((reaction) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(user?.userProfileImage ?? ""),
                      backgroundColor: Colors.grey[800],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(profileOwnerName,
                                  style: AppTextStyles.textSmall.copyWith(color: AppColors.secondary)),
                              const SizedBox(width: 6),
                              Text('reacted',
                                  style: AppTextStyles.display.copyWith(color: AppColors.secondary)),
                              const SizedBox(width: 6),
                              Container(
                                width: 16, height: 16,
                                decoration: BoxDecoration(
                                    color: AppColors.textGreen, shape: BoxShape.circle),
                                child: Icon(Icons.thumb_up, color: AppColors.surface, size: 10),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(reaction['time'] ?? "",
                              style: AppTextStyles.display.copyWith(
                                  color: AppColors.textOnDark, fontSize: 10)),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              int indexInMainList = controller.reelsList.indexWhere(
                                      (reel) => reel.id.toString() == reaction['id'].toString());
                              if (indexInMainList != -1) {
                                controller.updatePage(indexInMainList);
                                Get.back();
                              } else if (reaction['videoUrl'] != null && reaction['videoUrl'] != "") {
                                Get.to(() => FullScreenVideoPlayer(url: reaction['videoUrl']));
                              }
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF333333),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(reaction['title'] ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.textSmall.copyWith(color: AppColors.surface)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    NetworkOrFileImage(
                                      url: reaction['imageUrl'] ?? '',
                                      width: 64,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    const Icon(Icons.play_arrow, color: Colors.white, size: 18),
                                  ],
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
          ],
        ),
      );
    });
  }
}