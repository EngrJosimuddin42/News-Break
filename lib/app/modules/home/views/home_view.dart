import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/beauty_tab.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/empty_tab.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/entertainment_tab.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/food_tab.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/for_you_tab.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/health_tab.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/reactions_tab.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/sports_tab.dart';
import 'package:news_break/app/modules/home/views/widgets/tabs/weather_tab.dart';
import '../../../theme/app_colors.dart';
import '../../community/views/community_view.dart';
import '../../me/views/me_view.dart';
import '../../notification/views/notification_view.dart';
import '../controllers/home_controller.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_tab_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final navIndex = controller.selectedNavIndex.value;

      // Notification
      if (navIndex == 2) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: const NotificationAppBar(),
          body: const NotificationBody(),
          bottomNavigationBar: SafeArea(child: const HomeBottomNavBar()),
        );
      }

      // Community
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
              child: Obx(() =>
                  _buildTabContent(controller.selectedTabIndex.value)),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(child: const HomeBottomNavBar()),
        floatingActionButton: Obx(() {
          if (controller.selectedTabIndex.value == 0) {
            return FloatingActionButton(
              onPressed: controller.onCreatePost,
              backgroundColor: AppColors.backgroundAss,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.asset('assets/icons/plump_feather_pen.png',
                  width: 24, height: 24),
            );
          }
          return const SizedBox.shrink();
        }),
      );
    });
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return const ReactionsTab();
      case 1:
        return const ForYouTab();
      case 2:
        return const EmptyTab();
      case 3:
        return const EmptyTab();
      case 4:
        return const EntertainmentTab();
      case 5:
        return const SportsTab();
      case 6:
        return const FoodTab();
      case 7:
        return const HealthTab();
      case 8:
        return const BeautyTab();
      case 9:
        return const WeatherTab();
      default:
        return const ReactionsTab();
    }
  }
}