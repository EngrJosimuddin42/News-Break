import 'package:flutter/material.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/category_news_card.dart';

class SportsTab extends StatelessWidget {
  const SportsTab({super.key});

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?w=800',
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
      imageUrl: 'https://images.unsplash.com/photo-1534787238916-9ba6764efd4f?w=800',
      label: 'CYCLING',
      timeAgo: '3h',
      title:
      'Professional Cyclist Breaks World Record in Time Trial Event, Leaving Competitors Stunned at the Championship',
      reactions: '654',
      likes: '1.2K',
      comments: '876',
    ),
    CategoryNewsItem(
      publisherName: 'ESPN',
      publisherType: 'Partner publisher',
      followerCount: '5.1M',
      imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
      label: 'BASKETBALL',
      timeAgo: '6h',
      title:
      'NBA Playoffs: Underdog Team Clinches Surprising Victory in Game 7 Overtime Thriller',
      reactions: '8.9K',
      likes: '12.4K',
      comments: '7.8K',
    ),
    CategoryNewsItem(
      publisherName: 'Sports Illustrated',
      publisherType: 'Partner publisher',
      followerCount: '2.3M',
      imageUrl: 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800',
      label: 'FOOTBALL',
      timeAgo: '10h',
      title:
      'Transfer Window: Top Club Confirms Signing of Star Striker in Record-Breaking Deal Worth Millions',
      reactions: '5.2K',
      likes: '9.1K',
      comments: '4.4K',
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