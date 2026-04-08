import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/community_controller.dart';
import 'community_insight_view.dart';
import 'community_post_card.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({super.key});

  static const List<Map<String, dynamic>> _posts = [
    {
      'userName': 'Amalia',
      'userImageUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
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
      'userName': 'Amalia',
      'userImageUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      'text': 'Lorem ipsum dolor sit amet consectetur. Ut sed elementum pellentesque erat. In nisl facilisis ornare felis cras purus amet cursus.',
      'imageUrls': <String>[],
      'likes': '980',
      'comments': '2.1K',
      'shares': '34',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Community',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const CommunityInsightView()),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white38),
              ),
              child: const Center(
                child: Text('#',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Ad banner
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=100',
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(width: 44, height: 44, color: Colors.grey[800]),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FoodRadar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                      Text('Find Free Food Near You Instantly. 100% Free, No Ads..',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                          maxLines: 2),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white38),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Open',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.close, color: Colors.grey, size: 16),
              ],
            ),
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
                const Expanded(
                  child: Text("What's on your mind?",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
                GestureDetector(
                  onTap: controller.onCreatePost,
                  child: const Icon(Icons.edit_outlined,
                      color: Colors.grey, size: 22),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: controller.onCreateImage,
                  child: const Icon(Icons.image_outlined,
                      color: Colors.grey, size: 22),
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
      ),
    );
  }
}