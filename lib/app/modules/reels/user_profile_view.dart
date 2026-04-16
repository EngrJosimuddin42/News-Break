import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ── User Profile View ────────────────────────
class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  int _selectedTab = 0; // 0=Posts, 1=Reactions
  bool _isFollowing = false;

  static const List<Map<String, String>> _videos = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?w=400',
      'title': 'Love for animals',
      'views': '904',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=400',
      'title': 'Love for animals',
      'views': '904',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=400',
      'title': 'Love for animals',
      'views': '904',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=400',
      'title': 'Love for animals',
      'views': '904',
    },
  ];

  static const List<Map<String, String>> _reactions = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=200',
      'title': 'Snake Venom',
      'time': 'Friday 5:10 PM',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?w=200',
      'title': 'Snake Venom',
      'time': 'Friday 5:10 PM',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=200',
      'title': 'Snake Venom',
      'time': 'Friday 5:10 PM',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=200',
      'title': 'Snake Venom',
      'time': 'Friday 5:10 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.white, size: 18),
        ),
        actions: [
          GestureDetector(
            onTap: () => _showOptionsSheet(),
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.more_vert, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Profile header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 36,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                  ),
                  backgroundColor: Colors.grey[800],
                ),
                const SizedBox(width: 20),

                // Stats
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statItem('32', 'Post'),
                      _statItem('10k', 'Views'),
                      _statItem('10', 'Followers'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Name + meta
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Aliana',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Row(
              children: const [
                Icon(Icons.person_outline, color: Colors.grey, size: 14),
                SizedBox(width: 4),
                Text('user since Mar 2026',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                SizedBox(width: 12),
                Icon(Icons.location_on_outlined,
                    color: Colors.grey, size: 14),
                SizedBox(width: 4),
                Text('New York',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _isFollowing = !_isFollowing),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _isFollowing
                            ? Colors.transparent
                            : const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(8),
                        border: _isFollowing
                            ? Border.all(color: Colors.white24)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          _isFollowing ? 'Following' : 'Follow',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('Share',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _tabItem('Posts', 0),
                const SizedBox(width: 24),
                _tabItem('Reactions', 1),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 8),

          // Tab content
          if (_selectedTab == 0) _buildPostsTab(),
          if (_selectedTab == 1) _buildReactionsTab(),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Videos chip
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Videos',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
        ),

        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 2),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 1,
          ),
          itemCount: _videos.length,
          itemBuilder: (_, i) {
            final video = _videos[i];
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    video['imageUrl']!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: Colors.grey[800]),
                  ),
                ),
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 6),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black87, Colors.transparent],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(video['title']!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 11)),
                        Row(
                          children: [
                            const Icon(Icons.play_arrow,
                                color: Colors.white, size: 14),
                            Text(video['views']!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildReactionsTab() {
    return Column(
      children: _reactions.map((reaction) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Avatar + reaction icon
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                    ),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 16, height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.thumb_up,
                          color: Colors.white, size: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Aliana',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(width: 4),
                        const Text('reacted',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    Text(reaction['time']!,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 11)),

                    const SizedBox(height: 6),

                    // Article card
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(reaction['title']!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13)),
                          ),
                          const SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Stack(
                              children: [
                                Image.network(
                                  reaction['imageUrl']!,
                                  width: 48, height: 36,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 48, height: 36,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const Positioned.fill(
                                  child: Center(
                                    child: Icon(Icons.play_arrow,
                                        color: Colors.white, size: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _tabItem(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 14,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.normal,
              )),
          const SizedBox(height: 4),
          if (isSelected)
            Container(height: 2, width: 20, color: Colors.white),
        ],
      ),
    );
  }

  Widget _statItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }

  // ── Options Sheet ──────────────────────────
  void _showOptionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Share
              ListTile(
                leading: const Icon(Icons.share_outlined,
                    color: Colors.white, size: 20),
                title: const Text('Share this profile',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                onTap: () => Navigator.pop(context),
                dense: true,
              ),
              const Divider(color: Colors.white12, height: 1),

              // Block
              ListTile(
                leading: const Icon(Icons.block,
                    color: Colors.white, size: 20),
                title: const Text('Block',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                  _showBlockConfirm();
                },
                dense: true,
              ),
              const Divider(color: Colors.white12, height: 1),

              // Report
              ListTile(
                leading: const Icon(Icons.flag_outlined,
                    color: Colors.red, size: 20),
                title: const Text('Report user',
                    style: TextStyle(color: Colors.red, fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                  _showReportSheet();
                },
                dense: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Block Confirm ──────────────────────────
  void _showBlockConfirm() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: const Text('Are you sure?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        content: const Text(
          'If you block this user, you\'ll not see any content from this user.',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Block',
                style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  // ── Report Sheet ───────────────────────────
  void _showReportSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Report User',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Divider(color: Colors.white12, height: 1),
          ListTile(
            title: const Text('Report user name',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            onTap: () {
              Navigator.pop(context);
              _showReportSuccess();
            },
          ),
          const Divider(color: Colors.white12, height: 1),
          ListTile(
            title: const Text('Report user avatar',
                style: TextStyle(color: Colors.white, fontSize: 14)),
            onTap: () {
              Navigator.pop(context);
              _showReportSuccess();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Report Success ─────────────────────────
  void _showReportSuccess() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 36),
            const SizedBox(height: 12),
            const Text('Thanks for letting us know',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text(
              'your feedback is important in helping us keep our community safe',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}