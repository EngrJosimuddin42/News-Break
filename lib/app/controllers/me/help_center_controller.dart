import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/help_center_model.dart';

class HelpCenterController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  var displayArticles = <HelpArticle>[].obs;
  var displayCategories = <HelpCategory>[].obs;


  @override
  void onInit() {
    super.onInit();
    displayArticles.assignAll(promotedArticles);
    displayCategories.assignAll(categories);
  }

  void runSearch(String query) {
    if (query.isEmpty) {
      displayArticles.assignAll(promotedArticles);
      displayCategories.assignAll(categories);
    } else {
      displayArticles.assignAll(
        promotedArticles
            .where((a) => a.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
      displayCategories.assignAll(
        categories
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  final List<HelpCategory> categories = [
    HelpCategory(name: 'Advertising', isClickable: true),
    HelpCategory(name: 'Publishers', isClickable: true),
    HelpCategory(name: 'Reading News'),
    HelpCategory(name: 'Comments and Notification'),
    HelpCategory(name: 'Account, Profile, and Privacy'),
    HelpCategory(name: 'Contact Us'),
  ];

  final List<HelpArticle> promotedArticles = [
    HelpArticle(title: 'How to create an advertiser account'),
    HelpArticle(
        title: 'Scale Faster. Reach Higher. Accelerate with Premium Inventory (MSP) this February'),
    HelpArticle(title: 'Premium Partners (MSP) Overview'),
    HelpArticle(title: 'Why is the article not loading?'),
    HelpArticle(title: 'How do I request the removal of an article?'),
    HelpArticle(title: 'How do I contact News Break?'),
  ];
}