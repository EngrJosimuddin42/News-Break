import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
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
            title: " For seven long years, he served without ever asking for anything in return.His name is Sergeant Diesel, a 7-year-old Pit Bull veteran dog who walked beside soldiers throu...",
            imageAsset: 'assets/images/news_image.png',
            onFollow: () => controller.onFollow('shefinds'),
            onDismiss: () => controller.onDismiss('shefinds'),
          ),
          NewsCard(
            publisherName: 'shefinds',
            publisherMeta: 'user · Beverly Hills, CA',
            timeAgo: '6d',
            title: " For seven long years, he served without ever asking for anything in return.His name is Sergeant Diesel, a 7-year-old Pit Bull veteran dog who walked beside soldiers throu...",
            imageAsset: 'assets/images/news_image.png',
            onFollow: () => controller.onFollow('shefinds'),
            onDismiss: () => controller.onDismiss('shefinds'),
          ),
        ],
      );
    }
  }