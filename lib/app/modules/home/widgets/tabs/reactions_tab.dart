import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../news_card.dart';

class ReactionsTab extends GetView<HomeController> {
  const ReactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
      return ListView(
        children: [
          NewsCard(
            publisherName: 'shefinds',
            publisherMeta: 'user · Beverly Hills, CA',
            timeAgo: '6d',
            title: "For seven long years, he served without ever asking for anything in return. His name is Sergeant Diesel, a 7-year-old Pit Bull veteran dog who walked beside soldiers throu...",
            imageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800',
            onFollow: () => controller.onFollow('shefinds'),
            onDismiss: () => controller.onDismiss('shefinds'),
          ),
          NewsCard(
            publisherName: 'ESPN',
            publisherMeta: 'Partner publisher · New York, NY',
            timeAgo: '3h',
            title: "NBA Playoffs: Underdog Team Clinches Surprising Victory in Game 7 Overtime Thriller Against the Champions...",
            imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800',
            onFollow: () => controller.onFollow('ESPN'),
            onDismiss: () => controller.onDismiss('ESPN'),
          ),
          NewsCard(
            publisherName: 'BBC News',
            publisherMeta: 'Partner publisher · London, UK',
            timeAgo: '1d',
            title: "World Leaders Gather for Emergency Climate Summit as Scientists Warn of Unprecedented Environmental Crisis Ahead...",
            imageUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800',
            onFollow: () => controller.onFollow('BBC News'),
            onDismiss: () => controller.onDismiss('BBC News'),
          ),
          NewsCard(
            publisherName: 'TechCrunch',
            publisherMeta: 'Partner publisher · San Francisco, CA',
            timeAgo: '5h',
            title: "Apple Announces Revolutionary AI Features Coming to iPhone With the Next Major Software Update This Fall...",
            imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
            onFollow: () => controller.onFollow('TechCrunch'),
            onDismiss: () => controller.onDismiss('TechCrunch'),
          ),
        ],
      );
    }
  }