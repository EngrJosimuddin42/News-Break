import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ── News Detail View ─────────────────────────
class NewsDetailView extends StatelessWidget {
  const NewsDetailView({super.key});

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
        title: GestureDetector(
          onTap: () {},
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.auto_awesome,
                    color: Colors.blueAccent, size: 16),
                SizedBox(width: 6),
                Text('Ask anything',
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => _showMoreSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Category
                const Text('Politics',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),

                // Title
                const Text(
                  'Lorem ipsum dolor sit amet consectetur. Fames quisque feugiat fermentum dictum nulla netus cras pellentesque.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Author + time
                const Text('By OPINION · 19h',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 12),

                // Publisher row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[800],
                      child: const Icon(Icons.person,
                          color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('shefinds',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(width: 4),
                            Icon(Icons.verified,
                                color: Colors.blue, size: 14),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('Follow',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Main image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=800',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 200,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text('Joe sussman / Shutterstock.com',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                const SizedBox(height: 12),

                // Second image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1518770660439-4636190af475?w=800',
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 160,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),

          // Bottom bar
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
              border: Border(
                  top: BorderSide(color: Colors.white12)),
            ),
            child: Row(
              children: [
                // Comment input
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showCreateAccountSheet(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Write a comment',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 13)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Like
                Row(
                  children: const [
                    Icon(Icons.thumb_up_outlined,
                        color: Colors.grey, size: 18),
                    SizedBox(width: 4),
                    Text('1.4K',
                        style:
                        TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(width: 16),

                // Comment
                Row(
                  children: const [
                    Icon(Icons.chat_bubble_outline,
                        color: Colors.grey, size: 18),
                    SizedBox(width: 4),
                    Text('4k',
                        style:
                        TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(width: 16),

                // Share
                Row(
                  children: const [
                    Icon(Icons.share_outlined,
                        color: Colors.grey, size: 18),
                    SizedBox(width: 4),
                    Text('Share',
                        style:
                        TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Create Account Sheet ───────────────────
  void _showCreateAccountSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close,
                    color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(height: 8),

            // Logo
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.newspaper,
                  color: Colors.white, size: 28),
            ),
            const SizedBox(height: 12),

            const Text('Create an account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Log in or sign up to comment',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 24),

            // Facebook
            _socialBtn(
              icon: Icons.facebook,
              iconColor: const Color(0xFF1877F2),
              label: 'Continue with Facebook',
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),

            // Google
            _socialBtn(
              icon: Icons.g_mobiledata,
              iconColor: Colors.red,
              label: 'Continue with Google',
              onTap: () => Navigator.pop(context),
            ),

            const SizedBox(height: 16),
            const Icon(Icons.keyboard_arrow_down,
                color: Colors.grey, size: 24),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _socialBtn({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 10),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  // ── More Options Sheet ─────────────────────
  void _showMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Card 1 — Save, Share, Short Post
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _iconAction(Icons.bookmark_border, 'Save', () {}),
                    _iconAction(Icons.share_outlined, 'Share', () {}),
                    _iconAction(
                        Icons.edit_outlined, 'Short Post', () {}),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Card 2 — options
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _optionTile(
                      icon: Icons.block,
                      iconColor: Colors.white,
                      label: 'Block cource: better america',
                      onTap: () => Navigator.pop(context),
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    _optionTile(
                      icon: Icons.flag_outlined,
                      iconColor: Colors.red,
                      label: 'Report',
                      labelColor: Colors.red,
                      onTap: () => Navigator.pop(context),
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    _optionTile(
                      icon: Icons.flag_circle_outlined,
                      iconColor: Colors.red,
                      label: 'Report Ad',
                      labelColor: Colors.red,
                      onTap: () => Navigator.pop(context),
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    _optionTile(
                      icon: Icons.block_outlined,
                      iconColor: Colors.red,
                      label: 'Try Ad-free',
                      labelColor: Colors.red,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Card 3 — Ask/request
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: _optionTile(
                  icon: Icons.auto_fix_high,
                  iconColor: Colors.blueAccent,
                  label: 'Ask/request/report anything',
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconAction(
      IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(label,
              style:
              const TextStyle(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    Color iconColor = Colors.white,
    required String label,
    Color labelColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(label,
          style: TextStyle(color: labelColor, fontSize: 14)),
      onTap: onTap,
      dense: true,
    );
  }
}