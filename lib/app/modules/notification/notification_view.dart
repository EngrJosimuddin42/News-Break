import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../premium/widgets/premium_banner.dart';
import '../../controllers/notification_controller.dart';
import 'notification_news_item.dart';
import 'notification_settings_view.dart';

// ── AppBar ──────────────────────────────────────
class NotificationAppBar extends GetView<NotificationController>
    implements PreferredSizeWidget {
  const NotificationAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title:Text('Notifications',
       style: AppTextStyles.displaySmall,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () => Get.to(() => const NotificationSettingsView()),
        ),
      ],
      bottom: TabBar(
        controller: controller.tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        indicatorColor: Colors.white,
        indicatorWeight: 2,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelStyle: AppTextStyles.caption,
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        tabs: NotificationController.tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }
}

// ── Follow Notification Item ─────────────────────
class FollowNotificationItem extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final String timeAgo;
  final bool isHighlighted;

  const FollowNotificationItem({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.timeAgo,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: isHighlighted
            ? const Color(0xFF2C3C53)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
          CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        const SizedBox(width: 12),
        // Text info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                style: AppTextStyles.caption),
              const SizedBox(height: 2),
              Text('Started Following you',
                style: AppTextStyles.labelSmall.copyWith(color:AppColors.light)),
              const SizedBox(height: 2),
              Text(timeAgo,
                style: AppTextStyles.labelSmall.copyWith(color:AppColors.accentLight)),
            ],
          ),
        ),
          ],
        ),
    );
  }
}

// ── Body ────────────────────────────────────────
class NotificationBody extends GetView<NotificationController> {
  const NotificationBody({super.key});

  static const List<Map<String, String>> _newsItems = [
    {
      'category': 'Breaking News',
      'title': 'FCC chair threatens over Iran war coverage',
      'source': 'USA TODAY',
      'timeAgo': '9h',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=200',
      'reactions': '1.4K',
      'comments': '4.3k',
      'shares': '2.8k',
    },
    {
      'category': 'Breaking News',
      'title': 'FCC chair threatens over Iran war coverage',
      'source': 'USA TODAY',
      'timeAgo': '9h',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=200',
      'reactions': '1.4K',
      'comments': '4.3k',
      'shares': '2.8k',
    },
    {
      'category': 'Breaking News',
      'title': 'FCC chair threatens over Iran war coverage',
      'source': 'USA TODAY',
      'timeAgo': '9h',
      'imageUrl': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=200',
      'reactions': '1.4K',
      'comments': '4.3k',
      'shares': '2.8k',
    },
  ];

  // Sample followers data
  static const List<Map<String, String>> _followItems = [
    {
      'name': 'Banny',
      'avatarUrl':
      'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=100',
      'timeAgo': '1h',
      'highlighted': 'true',
    },
    {
      'name': 'James K.',
      'avatarUrl':
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'timeAgo': '3h',
      'highlighted': 'false',
    },
    {
      'name': 'Sophia Lee',
      'avatarUrl':
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      'timeAgo': '5h',
      'highlighted': 'false',
    },
    {
      'name': 'Marcus T.',
      'avatarUrl':
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      'timeAgo': '1d',
      'highlighted': 'false',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller.tabController,
      children: [
        _buildNewsTab(),   // News    — index 0
        _buildEmptyTab(),  // Likes   — index 1
        _buildEmptyTab(),  // Replies — index 2
        _buildFollowsTab(), // Follows — index 3
        _buildEmptyTab(),  // Others  — index 4
      ],
    );
  }

// ── Follows Tab ──────────────────────────────
  Widget _buildFollowsTab() {
    if (_followItems.isEmpty) return _buildEmptyTab();
    return ListView.separated(
      itemCount: _followItems.length,
      separatorBuilder: (_, __) =>
      const Divider(color: Colors.white12, height: 1),
      itemBuilder: (context, index) {
        final item = _followItems[index];
        return FollowNotificationItem(
          name: item['name']!,
          avatarUrl: item['avatarUrl']!,
          timeAgo: item['timeAgo']!,
          isHighlighted: item['highlighted'] == 'true',
        );
      },
    );
  }

  Widget _buildNewsTab() {
    return ListView(
      children: [
        const PremiumBanner(),

        _sectionLabel('Today'),
        ..._newsItems.take(2).map((item) => Column(children: [
          NotificationNewsItem(
            category: item['category']!,
            title: item['title']!,
            source: item['source']!,
            timeAgo: item['timeAgo']!,
            imageUrl: item['imageUrl']!,
            reactions: item['reactions']!,
            comments: item['comments']!,
            shares: item['shares']!,
          ),
          const Divider(color: Colors.white12, height: 1),
        ])),

        _sectionLabel('Earlier'),
        ..._newsItems.skip(2).map((item) => Column(children: [
          NotificationNewsItem(
            category: item['category']!,
            title: item['title']!,
            source: item['source']!,
            timeAgo: item['timeAgo']!,
            imageUrl: item['imageUrl']!,
            reactions: item['reactions']!,
            comments: item['comments']!,
            shares: item['shares']!,
          ),
          const Divider(color: Colors.white12, height: 1),
        ])),
      ],
    );
  }

  Widget _buildEmptyTab() {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/message.png',
            width: 90,
            height: 90,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text('No messages yet',
              style: AppTextStyles.overline),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(label,
          style:AppTextStyles.textSmall),
    );
  }
}