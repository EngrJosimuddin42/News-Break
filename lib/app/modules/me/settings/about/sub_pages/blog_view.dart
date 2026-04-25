import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../../widgets/help_widgets.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key});

  static const List<Map<String, String>> _posts = [
    {
      'tag': 'Behind the byline',
      'title': 'Reviving local journalism',
      'body': 'Lorem ipsum dolor sit amet consectetur. Lacus ut habitant id nec erat egestas libero lectus. Ipsum velit dictum sit ultrices porttitor. Tellus justo nascetur pellentesque praesent vitae viverra etiam ipsum a.',
      'author': 'Newsbreak',
      'date': 'March 4, 2026 16:00',
      'imageUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600',
    },
    {
      'tag': 'Behind the byline',
      'title': 'Reviving local journalism',
      'body': 'Lorem ipsum dolor sit amet consectetur. Lacus ut habitant id nec erat egestas libero lectus. Ipsum velit dictum sit ultrices porttitor. Tellus justo nascetur pellentesque praesent vitae viverra etiam ipsum a.',
      'author': 'Newsbreak',
      'date': 'March 4, 2026 16:00',
      'imageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600',
    },
    {
      'tag': 'Behind the byline',
      'title': 'Reviving local journalism',
      'body': 'Lorem ipsum dolor sit amet consectetur. Lacus ut habitant id nec erat egestas libero lectus. Ipsum velit dictum sit ultrices porttitor. Tellus justo nascetur pellentesque praesent vitae viverra etiam ipsum a.',
      'author': 'Newsbreak',
      'date': 'March 4, 2026 16:00',
      'imageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252F39),
      appBar: HelpWidgets.helpAppBar('Help Center'),
      body: Column(
        children: [
          const HelpTabBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: _posts.map((post) => _buildCard(post)).toList(),
                    ),
                  ),
                  HelpWidgets.helpFooter(),
                ],
              ),
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
        color:AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
             Image.network(
            post['imageUrl']!,
              width: double.infinity,
               fit: BoxFit.fitWidth,
            errorBuilder: (_, __, ___) => Container(
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
                    style:AppTextStyles.overline.copyWith(color: AppColors.background)),
                const SizedBox(height: 6),

                // Title
                Text(post['title']!,
                    style:AppTextStyles.bodySmall),
                const SizedBox(height: 8),

                // Body
                Text(post['body']!,
                    style: AppTextStyles.overline.copyWith(color: AppColors.background)),
                const SizedBox(height: 12),

                // Author + date
                Row(
                  children: [
                    Text(post['author']!,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textOnDark)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('|',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textOnDark)),
                    ),
                    Text(post['date']!,
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textOnDark)),
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