import 'package:get/get.dart';
import 'package:news_break/app/models/comment_source.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/app_snackbar.dart';
import 'auth/auth_helper.dart';
import 'comment_controller.dart';

class SocialInteractionController extends GetxController {
  static SocialInteractionController get to => Get.find();

  bool isJoined(int index) => joinedCommunityIds.contains(index);
  final joinedCommunityIds = <int>{}.obs;

  // ── Liked IDs ─────────────────────────────────
  final likedIds = <int>{}.obs;
  final dislikedIds = <int>{}.obs;

  // ── Saved IDs ─────────────────────────────────
  final savedIds = <int>{}.obs;

  // ── Followed ──────────────────────────────────
  final followedPublishers = <String>{}.obs;

  // ── Blocked ───────────────────────────────────
  final blockedSources = <String>{}.obs;

  // ── Hidden IDs ────────────────────────────────
  final hiddenIds = <int>{}.obs;

  // ── Reported IDs ──────────────────────────────
  final reportedIds = <int>{}.obs;

  // ── LIKE ──────────────────────────────────────
  void toggleLike(int id) {
    if (!AuthHelper.checkLogin()) return; // ✅ login check
    if (likedIds.contains(id)) {
      likedIds.remove(id);
    } else {
      likedIds.add(id);
      dislikedIds.remove(id);
    }
    // ✅ API: await ApiService.toggleLike(id);
  }

  bool isLiked(int id) => likedIds.contains(id);

  // ── DISLIKE ───────────────────────────────────
  void toggleDislike(int id) {
    if (!AuthHelper.checkLogin()) return; // ✅ login check
    if (dislikedIds.contains(id)) {
      dislikedIds.remove(id);
    } else {
      dislikedIds.add(id);
      likedIds.remove(id);
    }
    // ✅ API: await ApiService.toggleDislike(id);
  }

  bool isDisliked(int id) => dislikedIds.contains(id);

  // ── SAVE ──────────────────────────────────────
  void toggleSave(int id) {
    if (!AuthHelper.checkLogin()) return; // ✅ login check
    if (savedIds.contains(id)) {
      savedIds.remove(id);
      AppSnackbar.success(message: 'Removed from saved');
    } else {
      savedIds.add(id);
      AppSnackbar.success(message: 'Saved successfully');
    }
    // ✅ API: await ApiService.toggleSave(id);
  }

  bool isSaved(int id) => savedIds.contains(id);

  // ── FOLLOW ────────────────────────────────────
  void toggleFollow(String publisherName) {
    if (!AuthHelper.checkLogin()) return; // ✅ login check
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
    if (!AuthHelper.checkLogin()) return; // ✅ login check
    blockedSources.add(publisherName);
    AppSnackbar.success(message: 'Blocked $publisherName');
    // ✅ API: await ApiService.blockSource(publisherName);
  }

  bool isBlocked(String publisherName) =>
      blockedSources.contains(publisherName);

  // ── HIDE ──────────────────────────────────────
  void hideContent(int id) {
    hiddenIds.add(id);
    AppSnackbar.success(message: 'Content hidden from your feed');
    // ✅ API: await ApiService.hideContent(id);
  }

  bool isHidden(int id) => hiddenIds.contains(id);

  // ── REPORT ────────────────────────────────────
  void report(int id, String reason) {
    if (!AuthHelper.checkLogin()) return; // ✅ login check
    reportedIds.add(id);
    AppSnackbar.success(message: 'Reported successfully');
    // ✅ API: await ApiService.report(id, reason);
  }

  bool isReported(int id) => reportedIds.contains(id);

  // ── SHARE ─────────────────────────────────────
  Future<void> share({
    required int id,
    required String title,
    required String type, // 'news' | 'reel' | 'post'
  }) async {
    final String url = 'https://newsbreak.com/$type/$id';
    await Share.share('$title\n$url');
    // ✅ API: await ApiService.incrementShare(id);
  }

  // ── COMMENT ───────────────────────────────────
  void openComments(int id, CommentSource source) {
    if (!AuthHelper.checkLogin()) return; // ✅ login check
    Get.find<CommentController>().loadComments(id, source);
  }
}