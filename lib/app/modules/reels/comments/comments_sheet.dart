import 'package:flutter/material.dart';

class CommentsSheet extends StatefulWidget {
  const CommentsSheet({super.key});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final TextEditingController _commentController = TextEditingController();

  static const List<Map<String, String>> _comments = [
    {
      'name': 'Joser',
      'location': 'New York',
      'text': 'I wonder if they order that or not',
      'likes': '1.4K',
    },
    {
      'name': 'Joser',
      'location': 'New York',
      'text': 'I wonder if they order that or not',
      'likes': '1.4K',
    },
    {
      'name': 'Joser',
      'location': 'New York',
      'text': 'I wonder if they order that or not',
      'likes': '1.4K',
    },
  ];

  static const List<String> _reactions = ['😮', '😢', '❤️', '😊', '😡', '❤️‍🔥', '👍', 'ℹ️'];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                const Expanded(
                  child: Text('2000 Comments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close,
                      color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),

          // Comments list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: _comments.length,
              itemBuilder: (_, i) => _buildComment(_comments[i]),
            ),
          ),

          // Write a comment input
          Container(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2E),
              border: Border(top: BorderSide(color: Colors.white12)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showWriteCommentSheet(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A3C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Write a comment',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 13)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(Map<String, String> comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(comment['name']!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Text(comment['location']!,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 11)),
                    const Spacer(),
                    const Text('Follow',
                        style: TextStyle(
                            color: Colors.blue, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment['text']!,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 13)),
                const SizedBox(height: 8),

                // Actions
                Row(
                  children: [
                    _commentAction(Icons.chat_bubble_outline, 'Reply'),
                    const SizedBox(width: 16),
                    _commentAction(Icons.thumb_up_outlined,
                        comment['likes']!),
                    const SizedBox(width: 16),
                    _commentAction(Icons.swap_horiz, ''),
                    const SizedBox(width: 16),
                    _commentAction(Icons.share_outlined, 'Share'),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _showCommentOptionsSheet(),
                      child: const Icon(Icons.more_vert,
                          color: Colors.grey, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        if (label.isNotEmpty) ...[
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ],
    );
  }

  void _showWriteCommentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const WriteCommentSheet(),
    );
  }

  void _showCommentOptionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const CommentOptionsSheet(),
    );
  }
}

// ── Write Comment Sheet ──────────────────────
class WriteCommentSheet extends StatefulWidget {
  const WriteCommentSheet({super.key});

  @override
  State<WriteCommentSheet> createState() => _WriteCommentSheetState();
}

class _WriteCommentSheetState extends State<WriteCommentSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _showGifPicker = false;

  static const List<String> _reactions = [
    '😮', '😢', '❤️', '😊', '😡', '❤️‍🔥', '👍', 'ℹ️'
  ];

  static const List<String> _gifImages = [
    'https://images.unsplash.com/photo-1482961674540-0b0e8363a005?w=200',
    'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=200',
    'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=200',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    'https://images.unsplash.com/photo-1617854818583-09e7f077a156?w=200',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=200',
    'https://images.unsplash.com/photo-1490750967868-88df5691cc13?w=200',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showGifPicker) return _buildGifPicker();
    return _buildWriteComment();
  }

  Widget _buildWriteComment() {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          // Community guidelines
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                children: [
                  const TextSpan(
                      text: 'Please be respectful. Make sure your comment meets our '),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text('community guidelines.',
                          style: TextStyle(
                              color: Colors.blue, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Text field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _controller,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Write a comment...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),

          const Divider(color: Colors.white12, height: 1),

          // Bottom row
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // Reactions
                ..._reactions.map((r) => Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 2),
                  child: GestureDetector(
                    onTap: () {
                      _controller.text += r;
                    },
                    child: Text(r,
                        style: const TextStyle(fontSize: 20)),
                  ),
                )),
                const Spacer(),

                // Image icon
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.image_outlined,
                      color: Colors.grey, size: 22),
                ),
                const SizedBox(width: 12),

                // GIF icon
                GestureDetector(
                  onTap: () =>
                      setState(() => _showGifPicker = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('GIF',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),

                // Send button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.send_rounded,
                      color: Colors.blue, size: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGifPicker() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: Colors.white, size: 22),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const TextField(
            style: TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search for GIFs',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 18),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => _showGifPicker = false),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: _gifImages.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.network(
            _gifImages[i],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: Colors.grey[800]),
          ),
        ),
      ),
    );
  }
}

// ── Comment Options Sheet ────────────────────
class CommentOptionsSheet extends StatelessWidget {
  const CommentOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _optionTile(
                    icon: Icons.copy_outlined,
                    label: 'Copy',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _optionTile(
                    icon: Icons.share_outlined,
                    label: 'Share this content',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _optionTile(
                    icon: Icons.block,
                    label: 'Block : Viral Vibes',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _optionTile(
                    icon: Icons.flag_outlined,
                    iconColor: Colors.red,
                    label: 'Report comment',
                    labelColor: Colors.red,
                    trailing: const Icon(Icons.chevron_right,
                        color: Colors.white38, size: 18),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const CommentReportSheet(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    Color iconColor = Colors.white,
    required String label,
    Color labelColor = Colors.white,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(label,
          style: TextStyle(color: labelColor, fontSize: 14)),
      trailing: trailing,
      onTap: onTap,
      dense: true,
    );
  }
}

// ── Comment Report Sheet ─────────────────────
class CommentReportSheet extends StatefulWidget {
  const CommentReportSheet({super.key});

  @override
  State<CommentReportSheet> createState() => _CommentReportSheetState();
}

class _CommentReportSheetState extends State<CommentReportSheet> {
  String? _selectedReason;

  static const List<String> _reasons = [
    'Abusive or hateful',
    'Misleading or spam',
    'Violence or gory',
    'Sexual Content',
    'Minor safety',
    'Dangerous or criminal',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 18),
                ),
                const Expanded(
                  child: Text('Report Comment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close,
                      color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),

          // Reasons
          ..._reasons.map((reason) => RadioListTile<String>(
            value: reason,
            groupValue: _selectedReason,
            onChanged: (val) =>
                setState(() => _selectedReason = val),
            title: Text(reason,
                style: const TextStyle(
                    color: Colors.white, fontSize: 14)),
            activeColor: Colors.white,
            dense: true,
          )),

          const Divider(color: Colors.white12, height: 1),

          // Submit button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedReason == null
                    ? null
                    : () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedReason != null
                      ? Colors.white
                      : Colors.white24,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Submit',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}