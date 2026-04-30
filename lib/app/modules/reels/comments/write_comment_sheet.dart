import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/widgets/bottom_sheet_handle.dart';
import '../../../controllers/comment_controller.dart';
import '../../../controllers/social_interaction_controller.dart';
import '../../../controllers/social_utility_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../widgets/my_gif_picker.dart';

class WriteCommentSheet extends StatefulWidget {
  final dynamic reelId;
  final String type;
  final String? replyToId;
  final String? replyToName;
  final bool onlyEmoji;
  final String? author;
  const WriteCommentSheet({super.key, required this.reelId,this.type = 'news',this.replyToId,this.replyToName,this.author, this.onlyEmoji = false});

  @override
  State<WriteCommentSheet> createState() => _WriteCommentSheetState();
}

class _WriteCommentSheetState extends State<WriteCommentSheet> {
  final commentController = Get.find<CommentController>();
  final utility = Get.find<SocialUtilityController>();

  @override
  void dispose() {
    utility.clearAllMedia();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (utility.isGifPickerMode.value) {
        return MyGifPicker(controller: utility);
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
                  controller: commentController.commentTextController,
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
                  if (!widget.onlyEmoji) ...[
                  IconButton(
                      onPressed: utility.pickImage,
                      icon: const Icon(Icons.image_outlined, color: AppColors.surface, size: 22)),
                  const SizedBox(width: 4),

                  GestureDetector(
                      onTap: () => utility.isGifPickerMode.value = true,
                      child: Container(
                          padding: const EdgeInsets.symmetric( horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.surface),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text('GIF', style: AppTextStyles.display.copyWith(fontSize: 10))))],
                  const Spacer(),
                  Obx(() => commentController.isSendingComment.value
                      ? const SizedBox(width: 24, height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.primary))
                      : GestureDetector(

                    onTap: () async {
                      final text = commentController.commentTextController.text.trim();
                      if (widget.onlyEmoji) {
                        if (text.isNotEmpty) {
                          final socialCtrl = Get.find<SocialInteractionController>();
                          socialCtrl.updateReaction(widget.reelId, widget.type, text);
                          socialCtrl.incrementReactionCount(widget.reelId, source: widget.type);
                          commentController.commentTextController.clear();
                          Get.back();
                        }
                      } else {
                        final String? gifUrl = utility.selectedGifUrl.value;
                        final String? imagePath = utility.selectedImage.value?.path;
                        await commentController.submitComment(
                          widget.reelId,
                          gifUrl: gifUrl,
                          imagePath: imagePath,
                        );
                      }
                    },

                    child: Image.asset('assets/icons/send2.png', height: 24, width: 24),
                  ),),
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
                TextSpan(text: 'socials guidelines.', style: AppTextStyles.overline.copyWith(
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
      final gif = utility.selectedGifUrl.value;
      final image = utility.selectedImage.value;
      final bytes = utility.selectedImageBytes.value;

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
                  height: 120, width: 160, fit: BoxFit.cover)),
            Positioned(right: 5, top: 5,
              child: GestureDetector(
                onTap: utility.clearAllMedia,
                child: const CircleAvatar(radius: 12,
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.close, size: 16, color: Colors.white)))),
          ],
        ),
      );
    });
  }

  Widget _buildReactionRow() {
    final utility = Get.find<SocialUtilityController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: utility.reactions.map((emoji) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () {
                  commentController.commentTextController.text = emoji;
                  commentController.commentTextController.selection =
                      TextSelection.fromPosition(TextPosition(offset: emoji.length));},
                child: Text(emoji, style: const TextStyle(fontSize: 22)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  }