import 'package:flutter/material.dart';
import 'package:news_break/app/modules/home/views/widgets/ad_video_card.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/category_news_card.dart';

class EntertainmentTab extends StatelessWidget {
  const EntertainmentTab({super.key});

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher.',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800',
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
      publisherType: 'Partner publisher.',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=800',
      label: 'ENTERTAINMENT',
      timeAgo: '2h',
      title:
      'Hollywood Stars React to the Latest Box Office Surprises as Summer Blockbuster Season Kicks Off With Record Numbers',
      reactions: '980',
      likes: '2.1K',
      comments: '1.8K',
    ),
    CategoryNewsItem(
      publisherName: 'Variety',
      publisherType: 'Partner publisher.',
      followerCount: '1.2M',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      label: 'MUSIC',
      timeAgo: '5h',
      title:
      'Grammy-Winning Artist Announces Surprise Album Drop and World Tour Starting Next Month',
      reactions: '3.4K',
      likes: '5.6K',
      comments: '2.2K',
    ),
    CategoryNewsItem(
      publisherName: 'Entertainment Weekly',
      publisherType: 'Partner publisher.',
      followerCount: '900K',
      imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800',
      label: 'MOVIES',
      timeAgo: '8h',
      title:
      'Exclusive: First Look at the Most Anticipated Sequel of the Year — Fans Are Already Losing Their Minds',
      reactions: '2.7K',
      likes: '4.1K',
      comments: '3.3K',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      itemCount: _items.length + 1, // +1 for ad
      itemBuilder: (context, index) {
        if (index == 1) return const AdVideoCard(); // 2nd position এ ad
        final itemIndex = index > 1 ? index - 1 : index;
        return CategoryNewsCard(item: _items[itemIndex]);
      },
    );
  }
}