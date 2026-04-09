import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../controllers/notification_controller.dart';
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
        labelStyle: AppTextStyles.labelLarge,
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        tabs: NotificationController.tabs.map((t) => Tab(text: t)).toList(),
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

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller.tabController,
      children: [
        _buildNewsTab(),
        _buildEmptyTab(),
        _buildEmptyTab(),
        _buildEmptyTab(),
        _buildEmptyTab(),
      ],
    );
  }

  Widget _buildNewsTab() {
    return ListView(
      children: [
        Container(
          height: 100,
          width: 335,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/premium_bg.jpg'),
              fit: BoxFit.cover),
          ),
          child: Row(
            children: [
               Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Try Premium for FREE',
                       style: AppTextStyles.buttonOutline,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ad-free reading, boosted comments,\nsmarter recommendations and more.',
                    style: AppTextStyles.textSmall.copyWith(color: Color(0xFFF3DAD5)),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFD5F5C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
                child: Text('Upgrade',
                style: AppTextStyles.bodySmall.copyWith(color:AppColors.surface),
                ),
              ),
            ],
          ),
        ),

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