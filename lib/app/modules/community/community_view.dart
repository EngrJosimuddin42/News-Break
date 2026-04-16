import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/community_controller.dart';
import 'community_insight_view.dart';
import 'community_post_card.dart';

// ── AppBar
class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommunityAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title:Text('Community',
       style: AppTextStyles.displaySmall),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () => Get.to(() => const CommunityInsightView()),
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/icons/hashtag.png',
              width: 28,
              height: 28,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Body ────────────────────────────────────────
class CommunityBody extends GetView<CommunityController> {
  const CommunityBody({super.key});

  static const List<Map<String, dynamic>> _posts = [
    {
      'userName': 'Haris',
      'userImageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'text': 'Lorem ipsum dolor sit amet consectetur. Ut sed elementum pellentesque erat. In nisl facilisis ornare felis cras purus amet cursus.',
      'imageUrls': [
        'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=600',
        'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=600',
      ],
      'likes': '1.4K',
      'comments': '4K',
      'shares': '67',
    },
    {
      'userName': 'Jordan',
      'userImageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'text': 'Lorem ipsum dolor sit amet consectetur. Ut sed elementum pellentesque erat. In nisl facilisis ornare felis cras purus amet cursus.',
      'imageUrls': ['https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=600'],
      'likes': '980',
      'comments': '2.1K',
      'shares': '34',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Ad banner
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/publisher.png',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        radius: 21,
                        backgroundColor: Colors.grey[800],
                        child: Text('F',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('FoodRadar', style: AppTextStyles.bodyMedium),
                        Text('Find Free Food Near You Instantly. 100% Free, No Ads.',
                          style: AppTextStyles.labelMedium.copyWith(color: const Color(0xFF929292)),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.close, color: Colors.grey, size: 20),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:AppColors.surface,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(75, 40),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: 0,
                        ),
                        child: Text('Open',
                          style: AppTextStyles.bodyMedium.copyWith(color: Color(0xFF242424)),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12, height: 1),
          ],
        ),

        // Create post row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100'),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amalia', style: AppTextStyles.bodyMedium),
                    Text("What's on your mind?",
                      style: AppTextStyles.labelMedium.copyWith(color: const Color(0xFF929292)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.onEditProfile,
                child: Image.asset('assets/icons/edit.png', width: 22, height: 22),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: controller.onCreatePost,
                child: Image.asset('assets/icons/image.png', width: 22, height: 22),
              ),
            ],
          ),
        ),

        const Divider(color: Colors.white12, height: 1),
        const SizedBox(height: 4),

        // Posts
        ..._posts.map((post) => CommunityPostCard(
          userName: post['userName'],
          userImageUrl: post['userImageUrl'],
          text: post['text'],
          imageUrls: List<String>.from(post['imageUrls']),
          likes: post['likes'],
          comments: post['comments'],
          shares: post['shares'],
        )),
      ],
    );
  }
}