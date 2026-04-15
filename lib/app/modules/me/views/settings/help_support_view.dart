import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about/sub_pages/help_widgets.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _categories = [
    'Advertising',
    'Publishers',
    'Reading News',
    'Comments and Notification',
    'Account, Profile, and Privacy',
    'Contact Us',
  ];

  static const List<String> _promotedArticles = [
    'How to create an advertiser account',
    'Scale Faster. Reach Higher. Accelerate with Premium Inventory (MSP) this February',
    'Premium Partners (MSP) Overview',
    'Why is the article not loading?',
    'How do I request the removal of an article?',
    'How do I contact News Break?',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.black, size: 18),
        ),
        title: const Text('Help & Support',
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── স্ক্রিনশটের মতো লোগো এবং টেক্সট সেকশন
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
            ),
            child: Row(
              children: [
                // Newsbreak Logo + Text
                Image.asset('assets/images/newsbreak_logo.png', width: 24, height: 24), // আপনার লোগো পাথ
                const SizedBox(width: 8),
                const Text('Newsbreak',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 30),
                // Help Center Text
                const Text('Help Center',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child:_buildNewsbreakTab()
          ),
        ],
      ),
    );
  }

  // ── Newsbreak Tab ────────────────────────────
  Widget _buildNewsbreakTab() {
    return ListView(
      children: [
        // Hero banner
        Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1523821741446-edb2b68bb7a0?w=800',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 120,
                color: Colors.purple.shade200,
              ),
            ),
            Positioned.fill(
              child: Container(color: Colors.black38),
            ),
            const Positioned.fill(
              child: Center(
                child: Text(
                  'Hi, How Can We Help You?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'search issue keywords',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        // Categories
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _categories.map((cat) {
              bool isClickable = cat == 'Advertising' || cat == 'Publishers';
              return GestureDetector(
                onTap: isClickable
                    ? () => Get.to(() => HelpDetailView(title: cat))
                    : null,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: Center(
                    child: Text(cat,
                        style: const TextStyle(
                            color: Colors.red, fontSize: 14)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        // Promoted Articles
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text('Promoted Articles',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
        ),

        ..._promotedArticles.map((article) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(article,
                    style: const TextStyle(
                        color: Colors.black87, fontSize: 13)),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
          ],
        )),

        const SizedBox(height: 16),
        HelpWidgets.helpFooter(),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ── Help Detail View ─────────────────────────
class HelpDetailView extends StatelessWidget {
  final String title;
  const HelpDetailView({super.key, required this.title});

  static const List<Map<String, String>> _sections = [
    {
      'title': 'How to get started',
      'body':
      'Lorem ipsum dolor sit amet consectetur. Nulla mauris etiam risus at congue. Cursus odio nunc quis congue magna integer enim fringilla.',
    },
    {
      'title': 'Creating a profile',
      'body':
      'Lorem ipsum dolor sit amet consectetur. Nulla mauris etiam risus at congue. Cursus odio nunc quis congue magna integer enim fringilla.',
    },
    {
      'title': 'Troubleshooting',
      'body':
      'Lorem ipsum dolor sit amet consectetur. Nulla mauris etiam risus at congue. Cursus odio nunc quis congue magna integer enim fringilla.',
    },
    {
      'title': 'App Campaigns',
      'body':
      'Lorem ipsum dolor sit amet consectetur. Nulla mauris etiam risus at congue. Cursus odio nunc quis congue magna integer enim fringilla.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.black, size: 18),
        ),
        title: const Text('Help & Support',
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── স্ক্রিনশটের মতো লোগো এবং টেক্সট সেকশন
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
            ),
            child: Row(
              children: [
                // Newsbreak Logo + Text
                Image.asset('assets/images/newsbreak_logo.png', width: 24, height: 24), // আপনার লোগো পাথ
                const SizedBox(width: 8),
                const Text('Newsbreak',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 30),
                // Help Center Text
                const Text('Help Center',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: ListView(
              children: [
                // Breadcrumb
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                        const Text('NewsBreak Help Center',
                            style: TextStyle(
                                color: Colors.red, fontSize: 12)),
                      Text(' > $title',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),

                // Search
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFFEEEEEE)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey, size: 18),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700)),
                ),

                // Sections
                ..._sections.map((section) => Padding(
                  padding:
                  const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(section['title']!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text(section['body']!,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              height: 1.5)),
                    ],
                  ),
                )),

                const SizedBox(height: 24),
                HelpWidgets.helpFooter(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}