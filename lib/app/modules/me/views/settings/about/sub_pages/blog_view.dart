import 'package:flutter/material.dart';

import 'help_widgets.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key});

  static const List<Map<String, String>> _posts = [
    {
      'tag': 'Behind the byline',
      'title': 'Reviving local journalism',
      'body':
      'Lorem ipsum dolor sit amet consectetur. Lacus ut habitant id nec erat egestas libero lectus. Ipsum velit dictum sit ultrices porttitor. Tellus justo nascetur pellentesque praesent vitae viverra etiam ipsum a.',
      'author': 'Newsbreak',
      'date': 'March 4, 2026 16:00',
      'imageUrl':
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600',
    },
    {
      'tag': 'Behind the byline',
      'title': 'Reviving local journalism',
      'body':
      'Lorem ipsum dolor sit amet consectetur. Lacus ut habitant id nec erat egestas libero lectus. Ipsum velit dictum sit ultrices porttitor. Tellus justo nascetur pellentesque praesent vitae viverra etiam ipsum a.',
      'author': 'Newsbreak',
      'date': 'March 4, 2026 16:00',
      'imageUrl':
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600',
    },
    {
      'tag': 'Behind the byline',
      'title': 'Reviving local journalism',
      'body':
      'Lorem ipsum dolor sit amet consectetur. Lacus ut habitant id nec erat egestas libero lectus. Ipsum velit dictum sit ultrices porttitor. Tellus justo nascetur pellentesque praesent vitae viverra etiam ipsum a.',
      'author': 'Newsbreak',
      'date': 'March 4, 2026 16:00',
      'imageUrl':
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: HelpWidgets.helpAppBar('Help Center'),
        body: Column(
            children: [
            const HelpTabBar(),
        const Divider(height: 1, color: Color(0xFFEEEEEE)),

        Expanded(
          child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ..._posts.map((post) => _buildCard(post)),
          const SizedBox(height: 8),
          HelpWidgets.helpFooter(),
        ],
      ),
        ),
      ],
    ),
    );
  }

  Widget _buildCard(Map<String, String> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Image.network(
            post['imageUrl']!,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 180,
              color: Colors.grey[200],
              child: const Icon(Icons.image, color: Colors.grey, size: 48),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Text(post['tag']!,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),

                // Title
                Text(post['title']!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),

                // Body
                Text(post['body']!,
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        height: 1.5)),
                const SizedBox(height: 12),

                // Author + date
                Row(
                  children: [
                    Text(post['author']!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('|',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 12)),
                    ),
                    Text(post['date']!,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}