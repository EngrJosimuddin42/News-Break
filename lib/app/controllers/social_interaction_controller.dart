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

  // ── Liked IDs ─────────────────────────────────
  final likedIds = <String>{}.obs;
  final dislikedIds = <String>{}.obs;

  // ── Saved IDs ─────────────────────────────────
  final savedIds = <String>{}.obs;

  // ── Followed ──────────────────────────────────
  final followedPublishers = <String>{}.obs;

  // ── Blocked ───────────────────────────────────
  final blockedSources = <String>{}.obs;

  // ── Hidden IDs ────────────────────────────────
  final hiddenIds = <String>{}.obs;

  // ── Reported IDs ──────────────────────────────
  final reportedIds = <String>{}.obs;

  // ── Joined Community IDs ──────────────────────
  final joinedCommunityIds = <int>{}.obs;

  // ── LIKE ──────────────────────────────────────
  void toggleLike(int id, {String type = 'news'}) {
    if (!AuthHelper.checkLogin()) return;
    final key = '${type}_$id';
    if (likedIds.contains(key)) {
      likedIds.remove(key);
    } else {
      likedIds.add(key);
      dislikedIds.remove(key); // like করলে dislike সরবে
    }
    // ✅ API: await ApiService.toggleLike(id, type);
  }

  bool isLiked(int id, {String type = 'news'}) =>
      likedIds.contains('${type}_$id');

  // ── DISLIKE ───────────────────────────────────
  void toggleDislike(int id, {String type = 'news'}) {
    if (!AuthHelper.checkLogin()) return;
    final key = '${type}_$id';
    if (dislikedIds.contains(key)) {
      dislikedIds.remove(key);
    } else {
      dislikedIds.add(key);
      likedIds.remove(key); // dislike করলে like সরবে
    }
    // ✅ API: await ApiService.toggleDislike(id, type);
  }

  bool isDisliked(int id, {String type = 'news'}) =>
      dislikedIds.contains('${type}_$id');

  // ── SAVE ──────────────────────────────────────
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
    // ✅ API: await ApiService.toggleSave(id, type);
  }

  bool isSaved(int id, {String type = 'news'}) =>
      savedIds.contains('${type}_$id');

  // ── FOLLOW ────────────────────────────────────
  void toggleFollow(String publisherName) {
    if (!AuthHelper.checkLogin()) return;
    if (followedPublishers.contains(publisherName)) {
      followedPublishers.remove(publisherName);
      AppSnackbar.success(message: 'Unfollowed $publisherName');
    } else {
      followedPublishers.add(publisherName);
      AppSnackbar.success(message: 'Following $publisherName');
    }
    // ✅ API: await ApiService.toggleFollow(publisherName);
  }

  bool isFollowing(String publisherName) =>
      followedPublishers.contains(publisherName);

  // ── BLOCK ─────────────────────────────────────
  void blockSource(String publisherName) {
    if (!AuthHelper.checkLogin()) return;
    blockedSources.add(publisherName);
    AppSnackbar.success(message: 'Blocked $publisherName');
    // ✅ API: await ApiService.blockSource(publisherName);
  }

  bool isBlocked(String publisherName) =>
      blockedSources.contains(publisherName);

  // ── HIDE ──────────────────────────────────────
  void hideContent(int id, {String type = 'news'}) {
    final key = '${type}_$id';
    hiddenIds.add(key);
    AppSnackbar.success(message: 'Content hidden from your feed');
    // ✅ API: await ApiService.hideContent(id, type);
  }

  bool isHidden(int id, {String type = 'news'}) =>
      hiddenIds.contains('${type}_$id');

  //  REPORT
  var selectedReason = Rxn<String>();
  var isReportSubmitted = false.obs;
  var reportContentId = 0.obs;
  var reportContentType = ''.obs;

  void selectReason(String reason) => selectedReason.value = reason;

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
    //  API: await ApiService.report(reportContentId.value, reportContentType.value, selectedReason.value);
    isReportSubmitted.value = true;
    AppSnackbar.success(message: 'Reported successfully');
  }

  bool isReported(int id, {String type = 'news'}) =>
      reportedIds.contains('${type}_$id');


  // ── SHARE ─────────────────────────────────────
  Future<void> share({
    required int id,
    required String title,
    required String type, // 'news' | 'reel' | 'post'
  }) async {
    final String url = 'https://newsbreak.com/$type/$id';
    await Share.share('$title\n$url');
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

  // ── JOIN COMMUNITY ────────────────────────────
  void toggleJoin(int communityId) {
    if (!AuthHelper.checkLogin()) return;
    if (joinedCommunityIds.contains(communityId)) {
      joinedCommunityIds.remove(communityId);
      AppSnackbar.success(message: 'Left socials');
    } else {
      joinedCommunityIds.add(communityId);
      AppSnackbar.success(message: 'Joined socials!');
    }
    // ✅ API: await ApiService.toggleJoin(communityId);
  }

  bool isJoined(int communityId) =>
      joinedCommunityIds.contains(communityId);
}