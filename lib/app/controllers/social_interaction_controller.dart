import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/models/comment_source.dart';
import 'package:share_plus/share_plus.dart';
import '../modules/reels/comments/comments_sheet.dart';
import '../widgets/app_snackbar.dart';
import 'auth/auth_helper.dart';
import 'comment_controller.dart';

class SocialInteractionController extends GetxController {
  static SocialInteractionController get to => Get.find();

  final likedIds = <String>{}.obs;
  final dislikedIds = <String>{}.obs;
  final savedIds = <String>{}.obs;
  final followedPublishers = <String>{}.obs;
  final blockedSources = <String>{}.obs;
  final hiddenIds = <String>{}.obs;
  final reportedIds = <String>{}.obs;
  final joinedCommunityIds = <int>{}.obs;
  final reactions = <String, String>{}.obs;
  var likedComments = <String>[].obs;
  var dislikedComments = <String>[].obs;
  var savedItems = <String>[].obs;
  var selectedReason = Rxn<String>();
  var isReportSubmitted = false.obs;
  var reportContentId = 0.obs;
  var reportContentType = ''.obs;

  void selectReason(String reason) => selectedReason.value = reason;
  bool isCommentLiked(String id) => likedComments.contains(id);
  bool isCommentDisliked(String id) => dislikedComments.contains(id);


  // LIKE
  void toggleLike(int id, {String type = 'news'}) {
    if (!AuthHelper.checkLogin()) return;
    final key = '${type}_$id';
    if (likedIds.contains(key)) {
      likedIds.remove(key);
    } else {
      likedIds.add(key);
      dislikedIds.remove(key);
    }
  }

  void likeComment(String id) {
    if (!likedComments.contains(id)) {
      likedComments.add(id);
      dislikedComments.remove(id);
    }
  }

  bool isLiked(dynamic id, {String type = 'news'}) =>
      likedIds.contains('${type}_$id');

  int getAdjustedLikes(String commentId, int originalLikes) {
    if (isCommentLiked(commentId)) {
      return originalLikes + 1;
    } else if (isCommentDisliked(commentId) && originalLikes > 0) {
      return originalLikes - 1;
    }
    return originalLikes;
  }


  //  DISLIKE
  void toggleDislike(int id, {String type = 'news'}) {
    if (!AuthHelper.checkLogin()) return;
    final key = '${type}_$id';
    if (dislikedIds.contains(key)) {
      dislikedIds.remove(key);
    } else {
      dislikedIds.add(key);
      likedIds.remove(key);
    }

  }

  bool isDisliked(dynamic id, {String type = 'news'}) =>
      dislikedIds.contains('${type}_$id');

  void dislikeComment(String id) {
    if (!dislikedComments.contains(id)) {
      dislikedComments.add(id);
      likedComments.remove(id);
    }
  }

  void toggleCommentDislike(String id) {
    if (dislikedComments.contains(id)) {
      dislikedComments.remove(id);
    } else {
      dislikedComments.add(id);
      likedComments.remove(id);
    }
  }

  // SAVE
  void toggleSave(int id, {String type = 'news'}) {
    if (!AuthHelper.checkLogin()) return;
    final key = '${type}_$id';
    if (savedIds.contains(key)) {
      savedIds.remove(key);
      AppSnackbar.success(message: 'Removed from saved');
    } else {
      savedIds.add(key);
      AppSnackbar.success(message: 'Saved successfully');
    }
  }

  bool isSaved(int id, {String type = 'news'}) =>
      savedIds.contains('${type}_$id');


  // FOLLOW
  void toggleFollow(String publisherName) {
    if (!AuthHelper.checkLogin()) return;
    if (followedPublishers.contains(publisherName)) {
      followedPublishers.remove(publisherName);
      AppSnackbar.success(message: 'Unfollowed $publisherName');
    } else {
      followedPublishers.add(publisherName);
      AppSnackbar.success(message: 'Following $publisherName');
    }
  }

  bool isFollowing(String publisherName) =>
      followedPublishers.contains(publisherName);

  //  BLOCK
  void blockSource(String publisherName) {
    if (!AuthHelper.checkLogin()) return;
    blockedSources.add(publisherName);
    AppSnackbar.success(message: 'Blocked $publisherName');
  }

  bool isBlocked(String publisherName) =>
      blockedSources.contains(publisherName);

  // HIDE
  void hideContent(int id, {String type = 'news'}) {
    final key = '${type}_$id';
    hiddenIds.add(key);
    AppSnackbar.success(message: 'Content hidden from your feed');
  }

  bool isHidden(int id, {String type = 'news'}) =>
      hiddenIds.contains('${type}_$id');

  //  REPORT
  void openReport(int id, String type) {
    reportContentId.value = id;
    reportContentType.value = type;
    resetReport();
  }

  void resetReport() {
    selectedReason.value = null;
    isReportSubmitted.value = false;
  }

  void submitReport() {
    if (selectedReason.value == null) return;
    final key = '${reportContentType.value}_${reportContentId.value}';
    reportedIds.add(key);
    isReportSubmitted.value = true;
    AppSnackbar.success(message: 'Reported successfully');
  }

  bool isReported(int id, {String type = 'news'}) =>
      reportedIds.contains('${type}_$id');


  // ── SHARE
  Future<void> share({
    required int id,
    required String title,
    required String type, // 'news' | 'reel' | 'post'
  }) async {
    final String url = 'https://newsbreak.com/$type/$id';
    await Share.share('$title\n$url');
  }

  void shareContent(String id, {required String type}) async {
    String message = "Check out this $type on News Break!";
    String url = "https://newsbreak.com/$type/$id";
    await Share.share('$message\n$url');
  }

  // COMMENT
  void openComments(int id, CommentSource source) {
    if (!AuthHelper.checkLogin()) return;
    Get.find<CommentController>().loadComments(id, source);
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(Get.context!).size.width),
      builder: (_) => CommentsSheet(id: id, source: source),
    );
  }

  void toggleCommentLike(String id) async {
    if (isCommentLiked(id)) {
      likedComments.remove(id);
    } else {
      likedComments.add(id);
      dislikedComments.remove(id);
    }
  }


  // Reaction
  void updateReaction(dynamic id, String type, String emoji) {
    if (!AuthHelper.checkLogin()) return;
    final String key = '${type}_$id';
    reactions[key] = emoji;
  }

  String getMyReaction(dynamic id, String type) {
    return reactions['${type}_$id'] ?? '';
  }

  String getSelectedReaction(dynamic id, {String type = 'news'}) =>
      reactions['${type}_$id'] ?? '';



  // JOIN COMMUNITY
  void toggleJoin(int communityId) {
    if (!AuthHelper.checkLogin()) return;
    if (joinedCommunityIds.contains(communityId)) {
      joinedCommunityIds.remove(communityId);
      AppSnackbar.success(message: 'Left socials');
    } else {
      joinedCommunityIds.add(communityId);
      AppSnackbar.success(message: 'Joined socials!');
    }
  }

  bool isJoined(int communityId) =>
      joinedCommunityIds.contains(communityId);
}