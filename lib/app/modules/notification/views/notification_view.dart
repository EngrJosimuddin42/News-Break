import 'package:flutter/material.dart';
import 'notification_news_item.dart';
import 'notification_settings_view.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  static const List<String> _tabs = [
    'News',
    'Likes',
    'Replies',
    'Follows',
    'Others',
  ];

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
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Notifications',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const NotificationSettingsView()),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: Colors.white,
          indicatorWeight: 2,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNewsTab(),
          _buildEmptyTab(),
          _buildEmptyTab(),
          _buildEmptyTab(),
          _buildEmptyTab(),
        ],
      ),
    );
  }

  Widget _buildNewsTab() {
    return ListView(
      children: [
        // Premium banner
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=800'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Try Premium for FREE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 4),
                    Text(
                      'Ad-free reading, boosted comments,\nsmarter recommendations and more.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                ),
                child: const Text('Upgrade',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
              ),
            ],
          ),
        ),

        // Today section
        _sectionLabel('Today'),
        ..._newsItems.take(2).map((item) => Column(
          children: [
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
          ],
        )),

        // Earlier section
        _sectionLabel('Earlier'),
        ..._newsItems.skip(2).map((item) => Column(
          children: [
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
          ],
        )),
      ],
    );
  }

  Widget _buildEmptyTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mail_outline, color: Colors.grey, size: 64),
          SizedBox(height: 16),
          Text('No messages yet',
              style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(label,
          style: const TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }
}