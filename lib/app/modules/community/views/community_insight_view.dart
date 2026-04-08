import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
        ),
        title: const Text(
          'Community insight center',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFEEEEEE)),
        itemBuilder: (_, i) {
          final item = _items[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      Text(
                        item['title']!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle']!,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12, height: 1.4),
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
                    side: const BorderSide(color: Colors.black38),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Join',
                      style: TextStyle(color: Colors.black, fontSize: 13)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}