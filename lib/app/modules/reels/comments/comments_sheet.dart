import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/reels/comments/write_comment_sheet.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/bottom_sheet_handle.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../controllers/comment_controller.dart';
import '../../../controllers/social_interaction_controller.dart';
import '../../../models/comment_model.dart';
import '../../../models/comment_source.dart';
import 'option_sheet.dart';

class CommentsSheet extends StatelessWidget {
  final dynamic id;
  final CommentSource source;

  const CommentsSheet({
    super.key,
    required this.id,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final commentController = Get.find<CommentController>();
    final socialCtrl = Get.find<SocialInteractionController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          const BottomSheetHandle(),
          const SizedBox(height: 12),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => Text(
                      '${commentController.formatCount(commentController.commentsList.length)} Comments',
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
              if (commentController.isCommentsLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              }
              if (commentController.commentsList.isEmpty) {
                return const Center(
                    child: Text("No comments yet", style: TextStyle(color: Colors.white)));
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: commentController.commentsList.length,
                itemBuilder: (_, i) => _buildComment(
                    context,
                    commentController.commentsList[i],
                    commentController,
                    socialCtrl),
              );
            }),
          ),

          // Write comment input
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 12),
            child: GestureDetector(
              onTap: () => _showWriteCommentSheet(context, id),
              child: Container( height: 44,
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
                        errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.account_circle,
                            color: Colors.grey,
                            size: 28)))),
                    const SizedBox(width: 10),
                    Text('Write a comment...', style: AppTextStyles.overline.copyWith(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildComment(BuildContext context, CommentModel comment,
      CommentController commentController,SocialInteractionController socialCtrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar( radius: 18,
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
                      onTap: () => socialCtrl.toggleFollow(comment.userName),
                      child: Obx(() {
                        final bool isFollowing = socialCtrl.isFollowing(comment.userName);
                        return Text(
                          isFollowing ? 'Following' : 'Follow',
                          style: AppTextStyles.overline.copyWith(
                            color: isFollowing
                                ? Colors.grey
                                : AppColors.textGreen,
                            fontWeight: FontWeight.bold),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _buildCommentBody(comment),
                const SizedBox(height: 10),

                // Actions
                Row(
                  children: [
                    // Reply Button
                    _commentAction('assets/icons/comment.png', 'Reply', onTap: () {
                      _showWriteCommentSheet(context, id,
                          replyToId: comment.id.toString(),
                          replyToName: comment.userName
                      );
                    }),
                    const SizedBox(width: 16),

                    //  LIKE Button
                    Obx(() {
                      final commentId = comment.id.toString();
                      final isLiked = socialCtrl.isCommentLiked(commentId);
                      final currentLikes = socialCtrl.getAdjustedLikes(commentId, comment.likes);

                      return _commentAction(
                        'assets/icons/like_up.png',
                        commentController.formatCount(currentLikes),
                        onTap: () => socialCtrl.likeComment(commentId),
                        iconColor: isLiked ? Colors.blue : Colors.white,
                      );
                    }),

                    const SizedBox(width: 16),

                    // DISLIKE Button
                    Obx(() {
                      final commentId = comment.id.toString();
                      final isDisliked = socialCtrl.isCommentDisliked(commentId);
                      return _commentAction(
                         'assets/icons/like_down.png','',
                        onTap: () => socialCtrl.dislikeComment(commentId),
                        iconColor: isDisliked ? Colors.blue : Colors.white,
                      );
                    }),

                    const SizedBox(width: 16),

                    // SHARE Button
                    _commentAction('assets/icons/share.png', 'Share', onTap: () {
                      socialCtrl.shareContent(comment.id.toString(), type: 'comment');
                    }),

                    const Spacer(),
                    Text(comment.createdAt,
                        style: const TextStyle(color: Colors.grey, fontSize: 10)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () =>
                          _showCommentOptionsSheet(context, id, comment.userName),
                      child: Icon(Icons.more_vert,
                          color: AppColors.surface, size: 20)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentBody(CommentModel comment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  GIF
        if (comment.gifUrl != null && comment.gifUrl!.isNotEmpty)
          _buildMediaFrame(
            Image.network(
              comment.gifUrl!,
              fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Text("GIF could not load",
                  style: TextStyle(color: Colors.red)))),

        // Image
        if (comment.imagePath != null && comment.imagePath!.isNotEmpty)
          _buildMediaFrame(
            Image.file( File(comment.imagePath!),
              fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Text("Image error",
                  style: TextStyle(color: Colors.red)))),

        // Text
        if (comment.text.isNotEmpty) ...[
          if (comment.gifUrl != null || comment.imagePath != null)
            const SizedBox(height: 6),
          Text(comment.text, style: AppTextStyles.labelMedium),
        ],
      ],
    );
  }

  Widget _buildMediaFrame(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container( height: 140, width: 180,
          color: Colors.black12, child: child),
    );
  }

  Widget _commentAction(String assetIcon, String label, {VoidCallback? onTap, Color iconColor = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(assetIcon, width: 16, height: 16, color: iconColor),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(label, style: AppTextStyles.labelMedium),
          ],
        ],
      ),
    );
  }

  void _showWriteCommentSheet(BuildContext context, dynamic id, {String? replyToId, String? replyToName}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        builder: (context) => WriteCommentSheet(reelId: id, onlyEmoji: false,replyToId: replyToId,replyToName: replyToName));
  }

  void _showCommentOptionsSheet(BuildContext context, dynamic id, String name) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        builder: (_) => OptionsSheet(reelId: id, authorName: name));
  }
}