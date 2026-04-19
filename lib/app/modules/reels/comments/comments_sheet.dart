import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/reels/comments/write_comment_sheet.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/reels/reels_controller.dart';
import '../../../models/comment_model.dart';
import 'option_sheet.dart';

class CommentsSheet extends StatefulWidget {
  final int reelId;
  const CommentsSheet({super.key, required this.reelId});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final controller = Get.find<ReelsController>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          // Handle
          const SizedBox(height: 12),
          Container(
            width: 40, height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => Text(
                    '${controller.formatCount(controller.commentsList.length)} Comments',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium))),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.white, size: 20)),
              ],
            ),
          ),

          // Comments list
          Expanded(
            child: Obx(() {
              if (controller.isCommentsLoading.value) {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              }

              if (controller.commentsList.isEmpty) {
                return const Center(child: Text("No comments yet", style: TextStyle(color: Colors.white)));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: controller.commentsList.length,
                itemBuilder: (_, i) => _buildComment(controller.commentsList[i], controller),
              );
            }),
          ),

          // Write a comment input
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12),
            child: GestureDetector(
              onTap: () => _showWriteCommentSheet(widget.reelId),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  borderRadius: BorderRadius.circular(60)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Obx(() => Image.network(
                        authController.user.value?.profileImageUrl ?? '',
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_circle, color: Colors.grey, size: 28),
                      )),
                    ),
                    const SizedBox(width: 10),
                    Text('Write a comment...',
                      style:AppTextStyles.overline.copyWith(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildComment(CommentModel comment, ReelsController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(comment.userProfileImage),
            backgroundColor: Colors.grey[800]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.userName, style: AppTextStyles.small),
                          const SizedBox(height: 2),
                          Text(comment.location, style: AppTextStyles.overline),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text('Follow',
                          style: AppTextStyles.overline.copyWith(color: AppColors.textGreen))),
                  ],
                ),
                const SizedBox(height: 6),
                comment.text.startsWith('http')
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    comment.text,
                    height: 140,
                    width: 180,
                    fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Text("GIF could not load", style: TextStyle(color: Colors.red))))
                    : Text(comment.text, style: AppTextStyles.labelMedium),
                const SizedBox(height: 10),

                // Actions
                Row(
                  children: [
                    _commentAction('assets/icons/comment.png', 'Reply'),
                    const SizedBox(width: 16),
                    _commentAction('assets/icons/like_up.png', controller.formatCount(comment.likes)),
                    const SizedBox(width: 16),
                    _commentAction('assets/icons/like_down.png', ''),
                    const SizedBox(width: 16),
                    _commentAction('assets/icons/share.png', 'Share'),
                    const Spacer(),
                    Text(comment.createdAt, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _showCommentOptionsSheet(widget.reelId,comment.userName),
                      child: Icon(Icons.more_vert, color:AppColors.surface, size: 20),
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

  Widget _commentAction(String assetIcon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            assetIcon,
            width: 16,
            height: 16),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(label,
              style: AppTextStyles.labelMedium),
          ],
        ],
      ),
    );
  }

  void _showWriteCommentSheet(int id) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width),
        builder: (context) => WriteCommentSheet(reelId: id));
        }

  void _showCommentOptionsSheet(int id,String name) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width),
      builder: (_) => OptionsSheet(reelId: id, authorName: name));
  }
}
