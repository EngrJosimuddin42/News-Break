import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/home/widgets/bottom_nav_bar.dart';
import 'package:news_break/app/modules/home/widgets/home_app_bar.dart';
import 'package:news_break/app/modules/home/widgets/home_tab_bar.dart';
import 'package:news_break/app/modules/home/widgets/tabs/beauty_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/entertainment_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/food_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/for_you_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/health_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/local_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/local_tv_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/reactions_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/sports_tab.dart';
import 'package:news_break/app/modules/home/widgets/tabs/weather_tab.dart';
import '../../theme/app_colors.dart';
import '../community/community_view.dart';
import '../me/me_view.dart';
import '../notification/notification_view.dart';
import '../reels/reels_view.dart';
import '../../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final navIndex = controller.selectedNavIndex.value;

      if (navIndex == 1) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: const ReelsView(),
          bottomNavigationBar: SafeArea(child: const HomeBottomNavBar()),
        );
      }
      if (navIndex == 2) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: const NotificationAppBar(),
          body: const NotificationBody(),
          bottomNavigationBar: SafeArea(child: const HomeBottomNavBar()),
        );
      }
      if (navIndex == 3) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: const CommunityAppBar(),
          body: const CommunityBody(),
          bottomNavigationBar: SafeArea(child: const HomeBottomNavBar()),
        );
      }
      if (navIndex == 4) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: const MeAppBar(),
          body: const MeBody(),
          bottomNavigationBar: SafeArea(child: const HomeBottomNavBar()),
        );
      }

      // Home (default)
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: const HomeAppBar(),
        body: Column(
          children: [
            const HomeTabBar(),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                final index = controller.selectedTabIndex.value;
                if (index >= controller.tabs.length) return const SizedBox();
                final tabName = controller.tabs[index];
                return _buildTabContentByName(tabName);
              }),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(child: const HomeBottomNavBar()),
        floatingActionButton: Obx(() {
          if (controller.selectedTabIndex.value == 0 &&
              controller.tabs.isNotEmpty &&
              controller.tabs[0] == 'Reactions') {
            return FloatingActionButton(
              onPressed: controller.onCreatePost,
              backgroundColor: AppColors.backgroundAss,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Image.asset('assets/icons/plump_feather_pen.png',
                  width: 24, height: 24),
            );
          }
          return const SizedBox.shrink();
        }),
      );
    });
  }

  Widget _buildTabContentByName(String tabName) {
    switch (tabName) {
      case 'Reactions':     return const ReactionsTab();
      case 'For you':       return const ForYouTab();
      case 'Local':         return const LocalTab();
      case 'Local Tv':      return const LocalTvTab();
      case 'Entertainment': return const EntertainmentTab();
      case 'Sports':        return const SportsTab();
      case 'Food':          return const FoodTab();
      case 'Health':        return const HealthTab();
      case 'Beauty':        return const BeautyTab();
      case 'Weather':       return const WeatherTab();
      default:              return const ReactionsTab();
    }
  }
}