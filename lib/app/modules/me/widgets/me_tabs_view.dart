import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../controllers/me/me_controller.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../controllers/social_interaction_controller.dart';
import '../../../controllers/socials/socials_controller.dart';
import '../../../models/news_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/network_or_file_image.dart';
import '../../reels/player/full_screen_video_player.dart';
import 'history_item.dart';
import 'package:news_break/app/modules/reels/profile/reactions_tab.dart' as ReelsReactions;

class MeTabsView extends GetView<MeController> {
  final bool isLoggedIn;
  const MeTabsView({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final tabs = isLoggedIn ? controller.tabs : ['Saved', 'History'];

    return Column(
      children: [
        // Tabs
        Obx(() => _buildTabBar(context, tabs)),

        Obx(() => isLoggedIn
            ? _buildLoggedInTabContent(context)
            : _buildLoggedOutTabContent(context)),
      ],
    );
  }

  Widget _buildLoggedInTabContent(BuildContext context) {
    final tabs = controller.tabs;
    final tab = controller.selectedTab.value;
    final tabName = tab < tabs.length ? tabs[tab] : '';

    switch (tabName) {
      case 'Content':
        return Column(
          children: [

            Obx(() => Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  _chip('Reels',
                      controller.selectedChipIndex.value == 0,
                          () => controller.updateChip(0)),
                  const SizedBox(width: 8),
                  _chip('Posts',
                      controller.selectedChipIndex.value == 1,
                          () => controller.updateChip(1)),
                  const SizedBox(width: 8),
                  _chip('Community',
                      controller.selectedChipIndex.value == 2,
                          () => controller.updateChip(2)),
                ],
              ),
            )),


            Obx(() {
              final index = controller.selectedChipIndex.value;
              final loginName = AuthController.to.user.value?.name ?? '';

              if (index == 0) {
                return _buildUserContentList(
                  items: Get.find<ReelsController>().reelsList
                      .where((r) => r.userName == loginName)
                      .toList(),
                  emptyMessage: "You haven't posted any reels yet.",
                  isReel: true,
                );
              } else if (index == 1) {
                return _buildUserContentList(
                  items: Get.find<SocialInteractionController>().userPosts,
                  emptyMessage: "You haven't published any posts yet.",
                );
              } else {
                final myPosts = Get.find<SocialsController>().posts
                    .where((p) => p.author == loginName)
                    .toList();

                if (myPosts.isEmpty) {
                  return Column(
                    children: [
                      const SizedBox(height: 60),
                      Text('No Content', style: AppTextStyles.bodyMedium),
                      const SizedBox(height: 8),
                      Text("You haven't shared anything in community yet.",
                          style: AppTextStyles.overline),
                      const SizedBox(height: 40),
                    ],
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: myPosts.length,
                  separatorBuilder: (context, index) => const Divider(color: Colors.white12),
                  itemBuilder: (context, i) {
                    final item = myPosts[i];
                    final imageUrl = item.imageUrls.isNotEmpty ? item.imageUrls.first : '';
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: SizedBox(
                        width: 50, height: 50,
                        child: NetworkOrFileImage(
                          url: imageUrl,
                          width: 50, height: 50,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      title: Text(item.author, style: AppTextStyles.caption),
                      subtitle: Text(item.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.overline),
                      onTap: () {
                        Get.toNamed(Routes.NEWS_DETAIL, arguments: {
                          'news': NewsModel(
                            id: item.id,
                            category: item.category,
                            title: item.text,
                            author: item.author,
                            publisherName: item.publisherName,
                            timeAgo: item.timeAgo,
                            imageUrl: item.imageUrls.isNotEmpty ? item.imageUrls.first : '',
                            body: item.text,
                            publisherMeta: item.publisherName,
                            likes: item.likes,
                            comments: item.comments,
                          ),
                          'tabType': 'post',
                        });
                      },
                    );
                  },
                );
              }
            }),
          ],
        );

      case 'Reactions':
        return ReelsReactions.ReactionsTab(
          user: AuthController.to.user.value,
          controller: Get.find<ReelsController>(),
          isFullActivity: true, // news + reels
        );

      case 'Saved':
        return _buildSharedSavedView();

      case 'History':
        return _buildSharedHistoryView(context);
      default:
        return const SizedBox();
    }
  }

  Widget _buildLoggedOutTabContent(BuildContext context) {
    final tab = controller.selectedTab.value;
    return tab == 0 ? _buildSharedSavedView() : _buildSharedHistoryView(context);
  }

  Widget _buildTabBar(BuildContext context, List<String> tabs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(tabs.length, (i) {
              final selected = controller.selectedTab.value == i;
              return GestureDetector(
                onTap: () => controller.selectedTab.value = i,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tabs[i], style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      if (selected)
                        Container(height: 2, width: 50, color: AppColors.surface),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: isSelected ? AppColors.surface : Colors.black,
              borderRadius: BorderRadius.circular(60)),
          child: Text(label,style: AppTextStyles.labelSmall.copyWith(color: isSelected ? AppColors.background: Colors.grey))),
    );
  }
  Widget _buildSharedSavedView() {
    final socialCtrl = Get.find<SocialInteractionController>();

    return Obx(() {
      final reelItems = controller.savedReelsData;
      final newsItems = socialCtrl.savedNewsItems;
      final bool isEmpty = reelItems.isEmpty && newsItems.isEmpty;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                _chip('All', controller.selectedChipIndex.value == 0,
                        () => controller.updateChip(0)),
              ],
            ),
          ),

          if (isEmpty) ...[
            const SizedBox(height: 40),
            Text('No Saved articles', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 8),
            Text("You haven't saved anything. Yet.", style: AppTextStyles.overline),
            const SizedBox(height: 40),
          ] else ...[

            // Reels
            if (reelItems.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reelItems.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.white12),
                itemBuilder: (context, index) {
                  final item = reelItems[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          NetworkOrFileImage(
                            url: item.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                          ),
                        ],
                      ),
                    ),
                    title: Text(item.userName, style: AppTextStyles.caption),
                    subtitle: Text(item.description, style: AppTextStyles.overline),
                    onTap: () => Get.to(
                          () => FullScreenVideoPlayer(url: item.videoUrl ?? ''),
                      arguments: item,
                    ),
                  );
                },
              ),

            // News
            if (newsItems.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newsItems.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.white12),
                itemBuilder: (context, index) {
                  final item = newsItems[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: NetworkOrFileImage(
                        url: item.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    title: Text(item.title, style: AppTextStyles.caption),
                    subtitle: Text(item.publisherName, style: AppTextStyles.overline),
                    onTap: () => Get.toNamed(Routes.NEWS_DETAIL, arguments: item),
                  );
                },
              ),
          ],
        ],
      );
    });
  }


  Widget _buildSharedHistoryView(BuildContext context) {
    return Obx(() => controller.hasHistory.value
        ? Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              const Icon(Icons.visibility_off_outlined,  color: Colors.grey, size: 16),
              const SizedBox(width: 6),
              Text('Visible only to you', style:AppTextStyles.labelMedium.copyWith(color: AppColors.info)),
              const Spacer(),
              GestureDetector(
                  onTap: () => controller.onClearAll(context),
                  child:Text('Clear All', style:AppTextStyles.small.copyWith(color:Color(0xFF3498FA)))),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(color: Colors.white12, height: 1),
        const SizedBox(height: 16),

        ...controller.historyItems.map((item) => Column(
          key: ValueKey(item.id),
          children: [
            HistoryItem(model: item),
            const Divider(color: Colors.white12, height: 1),
          ],
        )),
      ],
    )
        : _buildNoHistoryView());
  }

  Widget _buildNoHistoryView() {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Text('No History', style: AppTextStyles.bodyMedium),
          SizedBox(height: 8),
          Text('Nothing yet. Start reading!', style:AppTextStyles.overline),
        ],
      ),
    );
  }

  Widget _buildUserContentList({
    required List items,
    required String emptyMessage,
    bool isReel = false,
  }) {
    if (items.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 60),
          Text('No Content', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 8),
          Text(emptyMessage, style: AppTextStyles.overline),
          const SizedBox(height: 40),
        ],
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(color: Colors.white12),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: SizedBox(
            width: 50,
            height: 50,
            child: NetworkOrFileImage(
              url: item.imageUrl ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          title: Text(
            isReel ? (item.userName ?? '') : (item.title ?? ''),
            style: AppTextStyles.caption,
          ),
          subtitle: Text(
            isReel ? (item.description ?? '') : (item.body ?? ''),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.overline,
          ),
          onTap: () {
            if (isReel) {
              Get.to(
                    () => FullScreenVideoPlayer(url: item.videoUrl ?? ''),
                arguments: item,
              );
            } else {
              Get.toNamed(Routes.NEWS_DETAIL, arguments: item);
            }
          },
        );
      },
    );
  }
}