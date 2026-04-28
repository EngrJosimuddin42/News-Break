import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/socials/socials_post_card.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/ad_banner_controller.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/socials/socials_controller.dart';
import '../../widgets/publisher_avatar.dart';
import 'community_insight_view.dart';

// ── AppBar
class SocialsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SocialsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title:Text('Socials', style: AppTextStyles.displaySmall),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () => Get.to(() => const CommunityInsightView()),
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset( 'assets/icons/hashtag.png', width: 28, height: 28))),
      ],
    );
  }
}

// Body
class SocialsBodyView extends GetView<SocialsController> {
  const SocialsBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    final adBanner = Get.find<AdBannerController>();
    return ListView(
      children: [

        Obx(() => adBanner.isBannerVisible.value
            ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  PublisherAvatar.fromUrl(
                    imageUrl: adBanner.adBanner.value.imageUrl,
                    name: adBanner.adBanner.value.title,
                    size: 48),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(adBanner.adBanner.value.title, style: AppTextStyles.bodyMedium),
                        Text(adBanner.adBanner.value.body, style: AppTextStyles.labelMedium.copyWith(color: const Color(0xFF929292)),
                          maxLines: 2),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => adBanner.isBannerVisible.value = false,
                        child: const Icon(Icons.close, color: Colors.grey, size: 20)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => adBanner.openExternalLink(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(75, 40),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: 0),
                        child: Text('Open', style: AppTextStyles.bodyMedium.copyWith(color: const Color(0xFF242424)))),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12, height: 2, thickness: 1),
          ],
        )
            : const SizedBox.shrink(),
        ),


        // Create post row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Obx(() {
                final user = AuthController.to.user.value;
                return PublisherAvatar.fromUrl(
                  imageUrl: user?.profileImageUrl ?? '',
                  name: user?.name ?? '',
                  size: 40);
              }),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                      AuthController.to.user.value?.name ?? 'Guest',
                      style: AppTextStyles.bodyMedium)),
                    Text("What's on your mind?", style: AppTextStyles.labelMedium.copyWith(color: const Color(0xFF929292))),
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.onEditProfile,
                child: Image.asset('assets/icons/edit.png', width: 22, height: 22)),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: controller.onCreatePost,
                child: Image.asset('assets/icons/image.png', width: 22, height: 22)),
            ],
          ),
        ),

        const SizedBox(height: 6),
        const Divider(color: Colors.white12, height: 2, thickness: 1),
        const SizedBox(height: 6),

        // Posts
        Obx(() {
          if (controller.isPostsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return SocialsPostCard(
              post: post);
          },
          );
        },
       )
      ],
    );
  }
}