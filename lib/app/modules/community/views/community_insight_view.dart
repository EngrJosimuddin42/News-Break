import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class CommunityInsightView extends StatelessWidget {
  const CommunityInsightView({super.key});

  static const List<Map<String, String>> _items = [
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Color(0xFF959595), size: 20),
        ),
        title: Text('Community insight center',
          style:AppTextStyles.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Column(
          children: [
          const SizedBox(height: 10),
        Expanded(
          child: Container(
            width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      child:ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final item = _items[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item['imageUrl']!,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 72, height: 72, color: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title']!,
                       style: AppTextStyles.bodySmall),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle']!,
                      style: AppTextStyles.labelSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFA9A9A9)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(44)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 14),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child:Text('Join',
                  style: AppTextStyles.bodySmall),
                ),
              ],
            ),
          );
        },
      ),
          ),
        ),
    Container(
    height: 40,
    color: Colors.black,
    width: double.infinity,
    ),
    ],
    ),
    );
  }
}