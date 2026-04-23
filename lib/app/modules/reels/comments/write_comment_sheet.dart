import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/widgets/bottom_sheet_handle.dart';
import '../../../controllers/comment_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class WriteCommentSheet extends StatefulWidget {
  final dynamic reelId;
  const WriteCommentSheet({super.key, required this.reelId});

  @override
  State<WriteCommentSheet> createState() => _WriteCommentSheetState();
}

class _WriteCommentSheetState extends State<WriteCommentSheet> {
  final controller = Get.find<CommentController>();

  @override
  void dispose() {
    controller.clearCommentMedia();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isGifPickerMode.value) {
        return _buildGifPicker();
      }
      return _buildWriteComment();
    });
  }

  Widget _buildWriteComment() {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            _buildTopBar(),
            const SizedBox(height: 12),
            _buildMediaPreview(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller.commentTextController,
                autofocus: true,
                maxLines: null,
                style: AppTextStyles.labelMedium,
                decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    hintStyle: AppTextStyles.overline,
                    border: InputBorder.none))),

            _buildReactionRow(),
            const Divider(color: Colors.grey, height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: controller.onAddMedia,
                      icon: const Icon(Icons.image_outlined,
                          color: AppColors.surface, size: 22)),
                  const SizedBox(width: 4),
                  GestureDetector(
                      onTap: () => controller.isGifPickerMode.value = true,
                      child: Container(
                          padding: const EdgeInsets.symmetric( horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.surface),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text('GIF', style: AppTextStyles.display.copyWith(fontSize: 10)))),
                  const Spacer(),
                  Obx(() => controller.isSendingComment.value
                      ? const SizedBox(width: 24, height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.primary))
                      : GestureDetector(
                      onTap: () => controller.submitComment(
                          widget.reelId,
                          controller.selectedGifUrl.value),
                      child: Image.asset('assets/icons/send2.png', height: 24, width: 24))),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const BottomSheetHandle(),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(style: AppTextStyles.overline,
              children: [
                const TextSpan(text: 'Please be respectful. Make sure your comment meets our '),
                TextSpan(text: 'community guidelines.', style: AppTextStyles.overline.copyWith(
                        color: AppColors.textGreen,
                        decoration: TextDecoration.underline)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaPreview() {
    return Obx(() {
      final gif = controller.selectedGifUrl.value;
      final image = controller.selectedImage.value;
      final bytes = controller.selectedImageBytes.value;

      if ((gif == null || gif.isEmpty) && image == null && bytes == null) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: (gif != null && gif.isNotEmpty)
                  ? Image.network(gif,
                  height: 120, width: 160, fit: BoxFit.cover)
                  : kIsWeb
                  ? Image.memory(bytes!,
                  height: 120, width: 160, fit: BoxFit.cover)
                  : Image.file(File(image!.path),
                  height: 120, width: 160, fit: BoxFit.cover),
            ),
            Positioned(right: 5, top: 5,
              child: GestureDetector(
                onTap: controller.clearCommentMedia,
                child: const CircleAvatar(radius: 12,
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.close, size: 16, color: Colors.white)))),
          ],
        ),
      );
    });
  }

  Widget _buildReactionRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.reactions
              .map((r) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
                onTap: () {
                  controller.commentTextController.text += r;
                },
                child: Text(r, style: const TextStyle(fontSize: 22)))))
              .toList())),
    );
  }

  Widget _buildGifPicker() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.isGifPickerMode.value = false;
                      controller.gifSearchQuery.value = '';
                    },
                    icon: const Icon(Icons.close, color: AppColors.textOnDark, size: 20)),
                Expanded(
                  child: Container(height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextField(
                      style: AppTextStyles.caption.copyWith(color: AppColors.textOnDark),
                      onChanged: (val) =>
                      controller.gifSearchQuery.value = val,
                      decoration: InputDecoration(
                          hintText: 'Search for GIFs',
                          hintStyle: AppTextStyles.caption.copyWith(color: AppColors.textOnDark),
                          prefixIcon: const Icon(Icons.search, color: AppColors.textOnDark, size: 20),
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 10))))),
                TextButton(
                    onPressed: () {
                      controller.isGifPickerMode.value = false;
                      controller.gifSearchQuery.value = '';
                    },
                    child: Text('Cancel', style: AppTextStyles.bodyMedium)),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),

          Expanded(
            child: Obx(() => GridView.builder(
              padding: const EdgeInsets.all(2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemCount: controller.filteredGifImages.length,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => controller.selectGif(controller.filteredGifImages[i]),
                child: Image.network(
                  controller.filteredGifImages[i],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey[800]),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}