import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/controllers/social_utility_controller.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/create_post_controller.dart';
import '../../controllers/socials/socials_controller.dart';
import '../../widgets/my_gif_picker.dart';
import '../../widgets/publisher_avatar.dart';

class SocialsCreatePostView extends StatefulWidget {
  final bool openImagePicker;
  const SocialsCreatePostView({super.key, this.openImagePicker = false});

  @override
  State<SocialsCreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<SocialsCreatePostView> {
  final TextEditingController _textController = TextEditingController();
  final socialsController = Get.find<SocialsController>();
  final utility = Get.find<SocialUtilityController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CreatePostController>().postType.value = PostType.social;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    utility.clearAllMedia();
    utility.clearTags();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createPostController = Get.find<CreatePostController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        ),
        title: Text('Create a Post', style: AppTextStyles.displaySmall),
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
                  _buildUserRow(),
                  const SizedBox(height: 12),

                  // Text Input
                  TextField(
                    controller: _textController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'All your ideas, advice or daily experiences are welcome here!',
                      hintStyle: AppTextStyles.labelMedium.copyWith(
                          color: const Color(0xFF959595)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location Preview
                  _buildLocationPreview(createPostController),

                  // GIF Preview
                  Obx(() {
                    final gifUrl = utility.selectedGifUrl.value;
                    if (gifUrl == null || gifUrl.isEmpty) return const SizedBox.shrink();
                    return _buildGifPreview();
                  }),

                  // Image Preview
                  Obx(() {
                    final mediaFile = utility.selectedImage.value;
                    final gifUrl = utility.selectedGifUrl.value;
                    if (gifUrl != null && gifUrl.isNotEmpty) return const SizedBox.shrink();
                    if (mediaFile == null) {
                      return GestureDetector(
                        onTap: () => utility.pickImage(),
                        child: _buildAddImageBox(),
                      );
                    }
                    return _buildImagePreview();
                  }),
                ],
              ),
            ),
          ),

          _buildBottomBar(createPostController),
        ],
      ),
    );
  }

  //  User Row
  Widget _buildUserRow() {
    return Row(
      children: [
        Obx(() {
          final user = AuthController.to.user.value;
          return PublisherAvatar.fromUrl(
            imageUrl: user?.profileImageUrl ?? '',
            name: user?.name ?? '',
            size: 40,
          );
        }),
        const SizedBox(width: 10),
        Obx(() => Text(
          AuthController.to.user.value?.name ?? 'Guest',
          style: AppTextStyles.button,
        )),
      ],
    );
  }

  //  Location Preview
  Widget _buildLocationPreview(CreatePostController controller) {
    return Obx(() {
      if (controller.selectedLocation.value.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Colors.blue, size: 16),
            const SizedBox(width: 4),
            Expanded(
              child: Text(controller.selectedLocation.value,
                  style: AppTextStyles.labelSmall.copyWith(color: Colors.blue)),
            ),
            GestureDetector(
              onTap: () => controller.selectedLocation.value = '',
              child: const Icon(Icons.close, color: Colors.grey, size: 16),
            ),
          ],
        ),
      );
    });
  }

  //  GIF Preview
  Widget _buildGifPreview() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              utility.selectedGifUrl.value!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 5, top: 5,
            child: GestureDetector(
              onTap: () => utility.selectedGifUrl.value = null,
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Image Preview
  Widget _buildImagePreview() {
    return Stack(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(utility.selectedImage.value!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 0, top: 0,
          child: GestureDetector(
            onTap: () => utility.selectedImage.value = null,
            child: const Icon(Icons.cancel, color: Colors.red, size: 24),
          ),
        ),
      ],
    );
  }

  // Add Image Box
  Widget _buildAddImageBox() {
    return Container(
      width: 90, height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF444444),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          Text('Add Image',
              style: AppTextStyles.labelMedium.copyWith(
                  color: const Color(0xFF959595))),
        ],
      ),
    );
  }

  //Bottom Bar
  Widget _buildBottomBar(CreatePostController createPostController) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 16, 24),
      child: Column(
        children: [
          Row(
            children: [
              //  Tags button
              _bottomAction(Icons.tag, 'Tags', onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: const Color(0xFF1C1C1E),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Trending Tags', style: AppTextStyles.bodyMedium),
                        const SizedBox(height: 12),
                        Obx(() => Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: utility.trendingTags.map((tag) {
                            final isSelected = utility.selectedTags.contains(tag);
                            return GestureDetector(
                              onTap: () => utility.toggleTag(tag),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue
                                      : const Color(0xFF444444),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(tag,
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey,
                                    )),
                              ),
                            );
                          }).toList(),
                        )),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (utility.tagsText.isNotEmpty) {
                                _textController.text += '\n${utility.tagsText}';
                              }
                              utility.clearTags();
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text('Add Tags', style: AppTextStyles.bodyMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(width: 30),

              //  Location button
              _bottomAction(Icons.location_on_outlined, 'Location',
                  onTap: createPostController.onTagLocation),

              const SizedBox(width: 30),

              // GIF button
              _bottomAction(Icons.gif_box_outlined, 'Gif', onTap: () {
                Get.bottomSheet(
                  MyGifPicker(controller: utility),
                  isScrollControlled: true,
                );
              }),
            ],
          ),
          const SizedBox(height: 12),

          //  Post button
          SizedBox(
            width: double.infinity,
            child: Obx(() => ElevatedButton(
              onPressed: createPostController.isLoading.value
                  ? null
                  : () {
                createPostController.textController.text = _textController.text;
                createPostController.onPost();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: createPostController.isLoading.value
                    ? Colors.grey
                    : const Color(0xFF656565),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: createPostController.isLoading.value
                  ? const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2))
                  : Text('Post',
                  style: AppTextStyles.bodyMedium.copyWith(
                      color: const Color(0xFF242424))),
            )),
          ),
        ],
      ),
    );
  }

  // Bottom Action Item
  Widget _bottomAction(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.overline),
        ],
      ),
    );
  }
}