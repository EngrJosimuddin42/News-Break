import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class ClipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const ClipCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox( width: 140, height: 160,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
                child: Image.network( imageUrl, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]))),

            // Dark gradient at bottom
            Positioned( bottom: 0, left: 0, right: 0,
                child: Container( height: 70,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black87, Colors.transparent])))),

            // Avatar + subtitle + title
            Positioned( bottom: 8, left: 8, right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey[700],
                          child: Image.asset('assets/images/clip_person.png')),
                      const SizedBox(width: 6),
                      Expanded(
                          child: Text( subtitle, style:AppTextStyles.display,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(title,
                    style:AppTextStyles.overline.copyWith(color: AppColors.surface),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}