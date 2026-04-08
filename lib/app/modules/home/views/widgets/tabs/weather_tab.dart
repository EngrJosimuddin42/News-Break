import 'package:flutter/material.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/category_news_card.dart';

class WeatherTab extends StatelessWidget {
  const WeatherTab({super.key});

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1601297183305-6df142704ea2?w=800',
      label: 'OPINION',
      timeAgo: '19h',
      title:
      "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    CategoryNewsItem(
      publisherName: 'Weather Channel',
      publisherType: 'Partner publisher',
      followerCount: '3.2M',
      imageUrl: 'https://images.unsplash.com/photo-1561484930-998b6a7b22e8?w=800',
      label: 'FORECAST',
      timeAgo: '4h',
      title:
      'El Niño Pattern Expected to Bring Above-Average Temperatures to Much of the Country Through Summer',
      reactions: '2.3K',
      likes: '3.9K',
      comments: '1.4K',
    ),
    CategoryNewsItem(
      publisherName: 'AccuWeather',
      publisherType: 'Partner publisher',
      followerCount: '1.5M',
      imageUrl: 'https://images.unsplash.com/photo-1530908295418-a12e326966ba?w=800',
      label: 'CLIMATE',
      timeAgo: '8h',
      title:
      'Record-Breaking Heat Wave Sweeps Across Southern States — Tips for Staying Cool and Healthy During Extreme Temperatures',
      reactions: '4.7K',
      likes: '6.8K',
      comments: '3.2K',
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