import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0; // 0 = Newsbreak, 1 = Help Center

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
          // Tab bar
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _tab('Newsbreak', 0),
                _tab('Help Center', 1),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: _selectedTab == 0
                ? _buildNewsbreakTab()
                : _buildHelpCenterTab(),
          ),
        ],
      ),
    );
  }

  Widget _tab(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.red : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.grey,
            fontSize: 14,
            fontWeight:
            isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
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
              return GestureDetector(
                onTap: () => Get.to(() => HelpDetailView(title: cat)),
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
        _buildFooter(),
        const SizedBox(height: 24),
      ],
    );
  }

  // ── Help Center Tab ──────────────────────────
  Widget _buildHelpCenterTab() {
    return ListView(
      children: [
        // Breadcrumb
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedTab = 0),
                child: const Text('NewsBreak Help Center',
                    style: TextStyle(color: Colors.red, fontSize: 12)),
              ),
              const Text(' > Advertising',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),

        // Search
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEEEEEE)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'search',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon:
                Icon(Icons.search, color: Colors.grey, size: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),

        // Article content
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('Advertising',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700)),
        ),

        ..._helpSections.map((section) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
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
              const SizedBox(height: 8),
            ],
          ),
        )),

        const SizedBox(height: 16),
        _buildFooter(),
        const SizedBox(height: 24),
      ],
    );
  }

  static const List<Map<String, String>> _helpSections = [
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

  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xFFEEEEEE)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text('Terms of Use',
                    style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('|',
                    style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text('Privacy Policy',
                    style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
            ],
          ),
        ),
        const Text('© 2020 Particle Media. All Rights Reserved.',
            style: TextStyle(color: Colors.grey, fontSize: 10)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('English (US)',
                style: TextStyle(color: Colors.grey, fontSize: 11)),
            const Icon(Icons.keyboard_arrow_down,
                color: Colors.grey, size: 16),
          ],
        ),
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
          // Tab bar
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _tabItem('Newsbreak', false),
                _tabItem('Help Center', true),
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
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Text('NewsBreak Help Center',
                            style: TextStyle(
                                color: Colors.red, fontSize: 12)),
                      ),
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
                _buildFooter(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(label,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.grey,
            fontSize: 14,
            fontWeight:
            isSelected ? FontWeight.w600 : FontWeight.normal,
          )),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xFFEEEEEE)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Terms of Use',
                  style: TextStyle(color: Colors.grey, fontSize: 11)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('|',
                    style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
              const Text('Privacy Policy',
                  style: TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ),
        const Text('© 2020 Particle Media. All Rights Reserved.',
            style: TextStyle(color: Colors.grey, fontSize: 10)),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('English (US)',
                style: TextStyle(color: Colors.grey, fontSize: 11)),
            Icon(Icons.keyboard_arrow_down,
                color: Colors.grey, size: 16),
          ],
        ),
      ],
    );
  }
}