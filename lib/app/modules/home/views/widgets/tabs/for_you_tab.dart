import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/home_controller.dart';
import '../for_you_reaction_card.dart';

class ForYouTab extends GetView<HomeController> {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // People section
        _buildSectionHeader('People You May Like'),
        SizedBox(
          height: 175,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => PeopleCard(
              name: 'Catherine',
              subtitle: 'Daily rising star',
              onDismiss: () {},
              onFollow: () {},
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Local clips section
        _buildSectionHeader('Local clips'),
        SizedBox(
          height: 160,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => ClipCard(
              title: 'Play Time',
              subtitle: 'Love for animals',
              imageAsset: 'assets/images/clip_$i.png',
            ),
          ),
        ),

        const SizedBox(height: 16),
        Column(
          children: [
            ForYouReactionCard(
              publisherName: 'shefinds',
              timeAgo: '19h',
              title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind'...",
              imageAsset: 'assets/images/news_image.png',
              onFollow: () => controller.onFollow('shefinds'),
              onDismiss: () => controller.onDismiss('shefinds'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Text(title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}

class PeopleCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final VoidCallback onDismiss;
  final VoidCallback onFollow;

  const PeopleCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.onDismiss,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 160,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF434447)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(Icons.close, color: Colors.white54, size: 20)),
            ],
          ),
          CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFF7A1CA4),
            child: Text(name[0],
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11)),
       SizedBox(height: 12),
          SizedBox(
            width: 125,
            height: 36,
            child: OutlinedButton(
              onPressed: onFollow,
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFF3498FA),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('+ Follow', style: AppTextStyles.buttonOutline),
            ),
          ),
        ],
      ),
    );
  }
}

class ClipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;

  const ClipCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image.asset(imageAsset, width: 120, height: 160, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(width: 120, height: 160, color: Colors.grey[900])),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black54,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 10)),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}