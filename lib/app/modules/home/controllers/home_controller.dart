import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../ai/views/nbot_sheet.dart';
import '../../location/views/choose_location_sheet.dart';
import '../../search/views/search_view.dart';

class HomeController extends GetxController {
  // Tab list
  final RxList<String> tabs = <String>[
    'Reactions', 'For you', 'Local', 'Local Tv',
    'Entertainment', 'Sports', 'Food', 'Health', 'Beauty', 'Weather',
  ].obs;

  final RxInt selectedTabIndex = 0.obs;
  final RxInt selectedNavIndex = 0.obs;

  // Auth check
  bool get isLoggedIn => AuthController.to.user.value != null;
  String get userName => AuthController.to.user.value?.name ?? '';


  // Bottom nav
  void onNavTap(int index) {
    selectedNavIndex.value = index;
  }

  // Tab tap
  void onTabTap(int index) {
    selectedTabIndex.value = index;
  }

  // App bar actions
  void onEditTabs() => Get.toNamed(Routes.EDIT_TABS, arguments: tabs);

  void onAI() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NBotSheet(),
    );
  }

  void onSearch() => Get.to(() => const SearchView());


  void onLocation() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ChooseLocationSheet(),
    );
  }


  final selectedLocation = Rxn<Map<String, String>>();
  void setLocation(Map<String, String> location) {
    selectedLocation.value = location;
  }
  String get locationTitle => selectedLocation.value?['city'] ?? 'Choose Your Location';


  // FAB — create post
  void onCreatePost() {
    if (isLoggedIn) {
      Get.toNamed(Routes.CREATE_POST);
    } else {
      Get.toNamed(Routes.SIGNIN);
    }
  }

  // News card actions
  void onFollow(String publisher) {
    if (!isLoggedIn) Get.toNamed(Routes.SIGNIN);
  }

  void onDismiss(String publisher) {}
  void onTryAgain() {}
}