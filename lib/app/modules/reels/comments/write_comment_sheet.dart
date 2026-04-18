import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class WriteCommentSheet extends StatefulWidget {
  final int reelId;
  const WriteCommentSheet({super.key, required this.reelId});

  @override
  State<WriteCommentSheet> createState() => _WriteCommentSheetState();
}

class _WriteCommentSheetState extends State<WriteCommentSheet> {
  final controller = Get.find<ReelsController>();
  final TextEditingController _controller = TextEditingController();
  bool _showGifPicker = false;
  String? _selectedGifUrl;

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
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          // Community guidelines
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: AppTextStyles.overline,
                    children: [
                      TextSpan(text: 'Please be respectful. Make sure your comment meets our '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text('community guidelines.',
                            style: AppTextStyles.overline.copyWith(color: AppColors.textGreen,decoration: TextDecoration.underline,
                              decorationColor: AppColors.textGreen,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (_selectedGifUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _selectedGifUrl!,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedGifUrl = null),
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black54,
                        child: Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Text field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _controller,
              autofocus: true,
              style: AppTextStyles.labelMedium,
              decoration:InputDecoration(
                hintText: 'Write a comment...',
                hintStyle:AppTextStyles.overline,
                border: InputBorder.none,
              ),
            ),
          ),

          // Reactions (Emoji row)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
             child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            child: Row(
                children: controller.reactions.map((r) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GestureDetector(
                  onTap: () {
                    _controller.text += r;
                  },
                  child: Text(r, style: const TextStyle(fontSize: 22)),
                ),
              )).toList(),
            ),
             ),
          ),

          const Divider(color: Colors.grey, height: 1),

          // Bottom row (Images, GIF, Send)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // Image icon
                GestureDetector(
                  onTap: () {},
                  child:Icon(Icons.image_outlined, color:AppColors.surface, size: 22),
                ),
                const SizedBox(width: 12),

                // GIF icon
                GestureDetector(
                  onTap: () => setState(() => _showGifPicker = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                      border: Border.all(color:AppColors.surface),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('GIF',
                      style:AppTextStyles.display),
                  ),
                ),

                const Spacer(),

                // Send button
                GestureDetector(
                  onTap: () {
                    if (_controller.text.isNotEmpty || _selectedGifUrl != null) {
                      final controller = Get.find<ReelsController>();
                      controller.addComment(widget.reelId, _controller.text, _selectedGifUrl);
                      Get.back();
                    }
                  },
                  child: Image.asset('assets/icons/send2.png', height: 24, width: 24),
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
          onTap: () {
            Get.back();
          },
          child:Icon(Icons.close, color:AppColors.textOnDark, size: 20),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            style:AppTextStyles.caption.copyWith(color: AppColors.textOnDark),
            decoration: InputDecoration(
              hintText: 'Search for GIFs',
              hintStyle: AppTextStyles.caption.copyWith(color: AppColors.textOnDark),
              prefixIcon: Icon(Icons.search, color:AppColors.textOnDark, size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => _showGifPicker = false),
            child: Text('Cancel',
                style:AppTextStyles.bodyMedium),
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
        itemCount: controller.gifImages.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedGifUrl = controller.gifImages[i];
              _showGifPicker = false;
            });
          },
          child: Image.network(
            controller.gifImages[i],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: Colors.grey[800]),
          ),
        ),
      ),
    );
  }
}