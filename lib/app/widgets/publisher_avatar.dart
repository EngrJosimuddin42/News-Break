import 'package:flutter/material.dart';

import '../models/news_model.dart';


class PublisherAvatar extends StatelessWidget {
  final NewsModel news;
  final double size;

  const PublisherAvatar({
    super.key,
    required this.news,
    this.size = 42.0,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl = news.publisherImageUrl;

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: (imageUrl.isNotEmpty && imageUrl.startsWith('http'))
            ? Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
        )
            : Image.asset(
          imageUrl.isNotEmpty ? imageUrl : 'assets/images/publisher.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[800],
      alignment: Alignment.center,
      child: Text(
        news.publisherName.isNotEmpty ? news.publisherName[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}