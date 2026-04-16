import 'package:flutter/material.dart';
import 'category_news_card.dart';

class BeautyTab extends StatelessWidget {
  const BeautyTab({super.key});

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=800',
      label: 'OPINION',
      timeAgo: '19h',
      title:
      "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=800',
      label: 'MAKEUP',
      timeAgo: '3h',
      title:
      'The Best Drugstore Makeup Dupes for High-End Products That Beauty Influencers Are Raving About Right Now',
      reactions: '3.7K',
      likes: '8.2K',
      comments: '4.6K',
    ),
    CategoryNewsItem(
      publisherName: 'Allure',
      publisherType: 'Partner publisher',
      followerCount: '2.1M',
      imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=800',
      label: 'SKINCARE',
      timeAgo: '6h',
      title:
      'Dermatologists Reveal the One Ingredient You Should Add to Your Skincare Routine for Glowing, Youthful Skin',
      reactions: '5.4K',
      likes: '10.1K',
      comments: '6.3K',
    ),
    CategoryNewsItem(
      publisherName: 'Vogue Beauty',
      publisherType: 'Partner publisher',
      followerCount: '4.6M',
      imageUrl: 'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=800',
      label: 'TRENDS',
      timeAgo: '12h',
      title:
      "Spring 2025's Biggest Beauty Trends: Bold Lips, Dewy Skin, and the Return of the '90s Aesthetic",
      reactions: '7.8K',
      likes: '14.3K',
      comments: '8.9K',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      itemCount: _items.length,
      itemBuilder: (context, index) =>
          CategoryNewsCard(item: _items[index]),
    );
  }
}