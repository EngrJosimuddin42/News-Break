import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  // Tab list
  final RxList<String> tabs = <String>[
    'Reactions', 'For you', 'Local', 'Local Tv',
    'Entertainment', 'Sports', 'Food', 'Health', 'Beauty', 'Weather',
  ].obs;

  final RxInt selectedTabIndex = 0.obs;
  final RxInt selectedNavIndex = 0.obs;

  // Bottom nav
  void onNavTap(int index) => selectedNavIndex.value = index;

  // Tab tap
  void onTabTap(int index) {
    selectedTabIndex.value = index;
  }

  // App bar actions
  void onEditTabs() => Get.toNamed(Routes.EDIT_TABS, arguments: tabs);
  void onSearch() {}
  void onLocation() {}

  // FAB — create post
  void onCreatePost() => Get.toNamed(Routes.CREATE_POST);

  // News card actions
  void onFollow(String publisher) {}
  void onDismiss(String publisher) {}
  void onTryAgain() {}
}