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
import '../controllers/home_controller.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_tab_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const HomeAppBar(),
      body: Column(
        children: [
          const HomeTabBar(),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() => _buildTabContent(controller.selectedTabIndex.value)),
          ),
        ],
      ),

      bottomNavigationBar: const HomeBottomNavBar(),

      floatingActionButton: Obx(() {
        if (controller.selectedTabIndex.value == 0) {
          return FloatingActionButton(
            onPressed: controller.onCreatePost,
            backgroundColor: AppColors.backgroundAss,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Image.asset('assets/icons/plump_feather_pen.png',
              width: 24,
              height: 24,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0: // Reactions
        return const ReactionsTab();
      case 1: // For you
        return const ForYouTab();
      case 2: // Local
        return const EmptyTab();
      case 3: // Local Tv
        return const EmptyTab();
      case 4: // Entertainment
        return const EntertainmentTab();
      case 5: // Sports
        return const SportsTab();
      case 6: // Food
        return const FoodTab();
      case 7: // Health
        return const HealthTab();
      case 8: // Beauty
        return const BeautyTab();
      case 9: // Weather
        return const WeatherTab();
      default:
        return const ReactionsTab();
    }
  }
}