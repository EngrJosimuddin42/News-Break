import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:news_break/app/modules/reels/reels_comments_sheet.dart';
import 'package:news_break/app/modules/reels/reels_options_sheets.dart';
import 'package:news_break/app/modules/reels/user_profile_view.dart';

// ── Reels View ───────────────────────────────
class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final PageController _pageController = PageController();

  static const List<Map<String, dynamic>> _reels = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800',
      'userName': '@Good Times',
      'description': 'what a Thrill',
      'source': '3month',
      'likes': '2.5k',
      'comments': '3.5k',
      'shares': '1',
      'isFollowing': false,
      'isLiked': false,
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
      'userName': '@City Life',
      'description': 'Amazing views',
      'source': '1month',
      'likes': '1.2k',
      'comments': '890',
      'shares': '45',
      'isFollowing': false,
      'isLiked': false,
    },
  ];

  late List<Map<String, dynamic>> _reelStates;

  @override
  void initState() {
    super.initState();
    _reelStates = _reels.map((r) => Map<String, dynamic>.from(r)).toList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full screen page view
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _reelStates.length,
            itemBuilder: (_, i) => _buildReel(_reelStates[i], i),
          ),

          // Top camera icon
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 16,
            child: GestureDetector(
              onTap: _showCreateReelSheet,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white38),
                ),
                child: const Icon(Icons.camera_alt_outlined,
                    color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReel(Map<String, dynamic> reel, int index) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.network(
            reel['imageUrl'],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: Colors.grey[900]),
          ),
        ),

        // Dark gradient bottom
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
        ),

        // Right side actions
        Positioned(
          right: 12,
          bottom: 120,
          child: Column(
            children: [
              // Avatar
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(reel['imageUrl']),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const UserProfileView()),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add,
                          color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Like
              _actionBtn(
                icon: reel['isLiked'] == true
                    ? Icons.thumb_up
                    : Icons.thumb_up_outlined,
                color: reel['isLiked'] == true
                    ? Colors.blue
                    : Colors.white,
                count: reel['likes'],
                onTap: () => setState(() {
                  _reelStates[index]['isLiked'] =
                  !(_reelStates[index]['isLiked'] as bool);
                }),
              ),
              const SizedBox(height: 16),

              // Comment
              _actionBtn(
                icon: Icons.chat_bubble_outline,
                color: Colors.white,
                count: reel['comments'],
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Share
              _actionBtn(
                icon: Icons.share_outlined,
                color: Colors.white,
                count: reel['shares'],
                onTap: () => _showShareSheet(reel),
              ),

              // bottom info এ more_vert icon
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const ReelsOptionsSheet(),
                ),
                child: const Icon(Icons.more_vert, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),

        // Bottom info
        Positioned(
          left: 16,
          right: 80,
          bottom: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reel['source'],
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 11)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(reel['userName'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  if (reel['isFollowing'] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white38),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Following',
                          style: TextStyle(
                              color: Colors.white, fontSize: 11)),
                    )
                  else
                    GestureDetector(
                      onTap: () => setState(() {
                        _reelStates[index]['isFollowing'] = true;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('+ Follow',
                            style: TextStyle(
                                color: Colors.white, fontSize: 11)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(reel['description'],
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 13)),
            ],
          ),
        ),

        // Comment input
        // Comment input
        Positioned(
          left: 16,
          right: 16,
          bottom: 50,
          child: GestureDetector(
            // ১. এখানে onTap ফাংশনটি যুক্ত করা হয়েছে
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const ReelsCommentsSheet(),
            ),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: const Center(
                child: Text(
                  'Write a comment...',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required Color color,
    required String count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(count,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  // ── Create Reel Sheet ──────────────────────
  void _showCreateReelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _CreateReelSheet(),
    );
  }

  // ── Share Sheet ────────────────────────────
  void _showShareSheet(Map<String, dynamic> reel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _ShareSheet(reel: reel),
    );
  }
}

// ── Create Reel Sheet ────────────────────────
class _CreateReelSheet extends StatefulWidget {
  const _CreateReelSheet();

  @override
  State<_CreateReelSheet> createState() => _CreateReelSheetState();
}

class _CreateReelSheetState extends State<_CreateReelSheet> {
  int _selectedTab = 0; // 0=Upload, 1=Video

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3A1C71), Color(0xFF6B4E9E), Color(0xFF9B7DBF)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Close
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close,
                      color: Colors.white, size: 24),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Title
          const Text('Create on NewsBreak',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Text(
            'To create videos, allow access to your\ncamera and microphone',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),

          const SizedBox(height: 32),

          // Access camera
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined,
                        color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('Access camera',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Access microphone
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic_outlined, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('Access Microphone',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),

          const Spacer(),

          // Record button
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Upload / Video tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tab('Upload', 0),
              const SizedBox(width: 32),
              _tab('Video', 1),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _tab(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        children: [
          if (index == 0)
            const Icon(Icons.upload_outlined, color: Colors.white, size: 20),
          Text(label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              )),
        ],
      ),
    );
  }
}

// ── Share Sheet ──────────────────────────────
class _ShareSheet extends StatelessWidget {
  final Map<String, dynamic> reel;
  const _ShareSheet({required this.reel});

  static const List<Map<String, dynamic>> _shareOptions = [
    {'label': 'Instagram', 'icon': Icons.camera_alt, 'color': Color(0xFFE1306C)},
    {'label': 'Share by Image', 'icon': Icons.image_outlined, 'color': Colors.grey},
    {'label': 'Copy link', 'icon': Icons.link, 'color': Colors.grey},
    {'label': 'Facebook', 'icon': Icons.facebook, 'color': Color(0xFF1877F2)},
    {'label': 'Email', 'icon': Icons.email_outlined, 'color': Colors.grey},
    {'label': 'Text message', 'icon': Icons.message_outlined, 'color': Colors.green},
    {'label': 'WhatsApp', 'icon': Icons.chat_outlined, 'color': Color(0xFF25D366)},
    {'label': 'Facebook messenger', 'icon': Icons.messenger_outline, 'color': Color(0xFF0099FF)},
    {'label': 'X', 'icon': Icons.close, 'color': Colors.black},
    {'label': 'Facebook groups', 'icon': Icons.group_outlined, 'color': Color(0xFF1877F2)},
    {'label': 'More', 'icon': Icons.more_horiz, 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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

        // Preview
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  reel['imageUrl'],
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(width: 48, height: 48, color: Colors.grey[800]),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reel['userName'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                  Text(reel['description'],
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 11)),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.grey, size: 18),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        const Divider(color: Colors.white12, height: 1),

        // Share options
        ..._shareOptions.map((option) => ListTile(
          leading: Icon(option['icon'] as IconData,
              color: option['color'] as Color, size: 22),
          title: Text(option['label'] as String,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          onTap: () => Navigator.pop(context),
          dense: true,
        )),

        const SizedBox(height: 16),
      ],
    );
  }
}