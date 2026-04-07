import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../controllers/home_controller.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_tab_bar.dart';
import 'widgets/news_card.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onCreatePost,
        backgroundColor: AppColors.backgroundAss,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Image.asset('assets/icons/plump_feather_pen.png',
            width: 24, height: 24
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0: // Reactions
        return _buildNewsFeed();
      case 1: // For you
        return _buildForYouTab();
      case 2: // Local
        return _buildEmptyState();
      case 3: // Local TV
        return _buildEmptyState();
      default:
        return _buildNewsFeed();
    }
  }

  Widget _buildNewsFeed() {
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

  Widget _buildForYouTab() {
    return ListView(
      children: [
        // People you may like section
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('People You May Like',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => _PeopleCard(
                    name: 'Catherine',
                    subtitle: 'Daily rising star',
                    onDismiss: () {},
                    onFollow: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        // Local clips section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Local clips',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => _ClipCard(
                    title: 'Play Time',
                    subtitle: 'Love for animals',
                    imageAsset: 'assets/images/clip_$i.png',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildNewsFeed(),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_articles.png',
              width: 80, height: 80,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.wifi_off, color: Colors.white54, size: 60)),
          const SizedBox(height: 16),
          const Text('No relavant articles',
              style: TextStyle(color: Colors.white54, fontSize: 14)),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: controller.onTryAgain,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Try Again',
                style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _PeopleCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final VoidCallback onDismiss;
  final VoidCallback onFollow;

  const _PeopleCard({
    required this.name,
    required this.subtitle,
    required this.onDismiss,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(Icons.close, color: Colors.white54, size: 16)),
            ],
          ),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.purple,
            child: Text(name[0],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 8),
          Text(name,
              style: const TextStyle(
                  color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
          Text(subtitle,
              style: const TextStyle(color: Colors.white54, fontSize: 11)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 28,
            child: OutlinedButton(
              onPressed: onFollow,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: const BorderSide(color: Colors.blue, width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text('+ Follow',
                  style: TextStyle(color: Colors.blue, fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;

  const _ClipCard({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image.asset(imageAsset,
              width: 120,
              height: 160,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(width: 120, height: 160, color: Colors.grey[900])),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black54,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subtitle,
                      style: const TextStyle(color: Colors.white70, fontSize: 10)),
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}