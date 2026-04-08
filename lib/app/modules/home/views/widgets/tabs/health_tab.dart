import 'package:flutter/material.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/category_news_card.dart';

class HealthTab extends StatelessWidget {
  const HealthTab({super.key});

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?w=800',
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
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
      label: 'FITNESS',
      timeAgo: '2h',
      title:
      'Morning Running Groups Are Changing Lives: How Community Exercise Is Boosting Mental Health Across the Country',
      reactions: '2.1K',
      likes: '3.8K',
      comments: '1.9K',
    ),
    CategoryNewsItem(
      publisherName: 'Healthline',
      publisherType: 'Partner publisher',
      followerCount: '2.7M',
      imageUrl: 'https://images.unsplash.com/photo-1505576399279-565b52d4ac71?w=800',
      label: 'WELLNESS',
      timeAgo: '5h',
      title:
      'New Study Reveals the Surprising Link Between Sleep Quality and Long-Term Cardiovascular Health',
      reactions: '4.3K',
      likes: '7.2K',
      comments: '3.1K',
    ),
    CategoryNewsItem(
      publisherName: 'WebMD',
      publisherType: 'Partner publisher',
      followerCount: '1.9M',
      imageUrl: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=800',
      label: 'NUTRITION',
      timeAgo: '9h',
      title:
      'Doctors Are Now Recommending This Simple Daily Habit to Dramatically Reduce Inflammation and Chronic Pain',
      reactions: '6.1K',
      likes: '9.4K',
      comments: '5.5K',
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