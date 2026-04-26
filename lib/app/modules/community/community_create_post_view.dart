import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/community/community_controller.dart';
import '../../widgets/publisher_avatar.dart';

class CommunityCreatePostView extends StatefulWidget {
  final bool openImagePicker;
  const CommunityCreatePostView({super.key, this.openImagePicker = false});

  @override
  State<CommunityCreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CommunityCreatePostView> {
  final TextEditingController _textController = TextEditingController();

  final controller = Get.find<CommunityController>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        ),
        title:Text('Create a Post',
          style: AppTextStyles.displaySmall,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User row
                  Row(
                    children: [
                      Obx(() {
                        final user = AuthController.to.user.value;
                        return PublisherAvatar.fromUrl(
                          imageUrl: user?.profileImageUrl ?? '',
                          name: user?.name ?? '',
                          size: 40);
                      }),
                      const SizedBox(width: 10),
                      Obx(() => Text(
                        AuthController.to.user.value?.name ?? 'Guest',
                        style: AppTextStyles.button,
                      )),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Text input
                  TextField(
                    controller: _textController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: null,
                    decoration:InputDecoration(
                      hintText:
                      'All your ideas, advice or daily experiences are welcome here!',
                      hintStyle: AppTextStyles.labelMedium.copyWith(color: Color(0xFF959595)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Add Image box
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color(0xFF444444),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 28),
                          SizedBox(height: 4),
                          Text('Add Image',
                          style: AppTextStyles.labelMedium.copyWith(color: Color(0xFF959595)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom bar
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 16, 24),
            child: Column(
              children: [
                // Tags / Location / GIF
                Row(
                  children: [
                    _bottomAction(Icons.tag, 'Tags'),
                    const SizedBox(width: 30),
                    _bottomAction(Icons.location_on_outlined, 'Location'),
                    const SizedBox(width: 30),
                    _bottomAction(Icons.gif_box_outlined, 'Gif'),
                  ],
                ),

                const SizedBox(height: 12),

                // Post button
                SizedBox(
                  width:335,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF656565),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text('Post',
                      style:AppTextStyles.bodyMedium.copyWith(color: Color(0xFF242424)) ,
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

  Widget _bottomAction(IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 6),
          Text(label,
            style: AppTextStyles.overline,
          ),
        ],
      ),
    );
  }
}