import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController;

  var allowNotification = true.obs;
  var soundVibration = true.obs;
  var localNews = true.obs;
  var breakingNews = true.obs;
  var recommendedReactions = true.obs;
  var followedReactions = true.obs;
  var forYou = true.obs;
  var localDeals = true.obs;
  var commentReplies = true.obs;
  var doNotDisturb = true.obs;
  var frequency = 0.5.obs;

  static const List<String> tabs = ['News', 'Likes', 'Replies', 'Follows', 'Others'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  void updateSwitch(String key, bool value) {
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}