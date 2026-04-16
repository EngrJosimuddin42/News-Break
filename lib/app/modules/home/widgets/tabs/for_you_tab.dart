import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../ad_video_card.dart';
import '../clip_card.dart';
import '../people_card.dart';
import 'category_news_card.dart';

class ForYouTab extends GetView<HomeController> {
  const ForYouTab({super.key});

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher.',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800',
      label: 'OPINION',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    CategoryNewsItem(
      publisherName: 'Variety',
      publisherType: 'Partner publisher.',
      followerCount: '1.2M',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      label: 'ENTERTAINMENT',
      timeAgo: '3h',
      title: 'Grammy-Winning Artist Announces Surprise Album Drop and World Tour Starting Next Month',
      reactions: '3.4K',
      likes: '5.6K',
      comments: '2.2K',
    ),
    CategoryNewsItem(
      publisherName: 'ESPN',
      publisherType: 'Partner publisher.',
      followerCount: '5.1M',
      imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
      label: 'SPORTS',
      timeAgo: '6h',
      title: 'NBA Playoffs: Underdog Team Clinches Surprising Victory in Game 7 Overtime Thriller',
      reactions: '8.9K',
      likes: '12.4K',
      comments: '7.8K',
    ),
    CategoryNewsItem(
      publisherName: 'Healthline',
      publisherType: 'Partner publisher.',
      followerCount: '2.7M',
      imageUrl: 'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?w=800',
      label: 'HEALTH',
      timeAgo: '9h',
      title: 'New Study Reveals the Surprising Link Between Sleep Quality and Long-Term Cardiovascular Health',
      reactions: '4.3K',
      likes: '7.2K',
      comments: '3.1K',
    ),
  ];

  static const List<Map<String, String>> _clips = [
    {
      'title': 'Play Time',
      'subtitle': 'Love for animals',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=400',
    },
    {
      'title': 'City Life',
      'subtitle': 'Urban stories',
      'imageUrl': 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=400',
    },
    {
      'title': 'Nature Walk',
      'subtitle': 'Explore outdoors',
      'imageUrl': 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=400',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // People section
        _buildSectionHeader('People You May Like'),
        SizedBox(
          height: 175,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => PeopleCard(
              name: 'Catherine',
              subtitle: 'Daily rising star',
              onDismiss: () {},
              onFollow: () {},
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Local clips section
        _buildSectionHeader('Local clips'),
        SizedBox(
          height: 160,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _clips.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => ClipCard(
              title: _clips[i]['title']!,
              subtitle: _clips[i]['subtitle']!,
              imageUrl: _clips[i]['imageUrl']!,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // News Section
        ...List.generate(
          controller.isLoggedIn ? _items.length + 1 : _items.length,
              (index) {
            if (controller.isLoggedIn && index == 1) {
              return const AdVideoCard();
            }
            final itemIndex = (controller.isLoggedIn && index > 1)
                ? index - 1
                : index;
            return CategoryNewsCard(item: _items[itemIndex]);
          },
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}