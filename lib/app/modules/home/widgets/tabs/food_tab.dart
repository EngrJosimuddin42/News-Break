import 'package:flutter/material.dart';
import 'category_news_card.dart';

class FoodTab extends StatelessWidget {
  const FoodTab({super.key});

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
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
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
      label: 'NUTRITION',
      timeAgo: '4h',
      title:
      '10 Superfoods That Nutritionists Swear By for Boosting Energy and Immunity This Season',
      reactions: '1.1K',
      likes: '2.3K',
      comments: '1.5K',
    ),
    CategoryNewsItem(
      publisherName: 'Bon Appétit',
      publisherType: 'Partner publisher',
      followerCount: '1.8M',
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
      label: 'RECIPE',
      timeAgo: '7h',
      title:
      'This One-Pan Mediterranean Chicken Recipe Will Completely Transform Your Weeknight Dinner Routine',
      reactions: '3.2K',
      likes: '6.7K',
      comments: '2.1K',
    ),
    CategoryNewsItem(
      publisherName: 'Food Network',
      publisherType: 'Partner publisher',
      followerCount: '3.4M',
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
      label: 'TRENDS',
      timeAgo: '11h',
      title:
      "2025's Hottest Food Trends: From Fermented Delights to Globally-Inspired Street Food Taking Over Restaurant Menus",
      reactions: '2.8K',
      likes: '4.5K',
      comments: '3.0K',
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