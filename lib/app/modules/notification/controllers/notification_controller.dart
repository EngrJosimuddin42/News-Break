import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  static const List<String> tabs = [
    'News',
    'Likes',
    'Replies',
    'Follows',
    'Others',
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}