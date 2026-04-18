import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/comment_model.dart';
import '../../models/reel_model.dart';
import '../../modules/me/settings/about/legal_view.dart';
import '../../modules/reels/comments/report_comment_sheet.dart';
import '../../modules/reels/three_dot/report_reels_sheet.dart';
import 'package:share_plus/share_plus.dart';
import '../auth_controller.dart';
import 'package:flutter/services.dart';

class ReelsController extends GetxController {

//  Reels Data
  var reelsList = <ReelModel>[].obs;
  var isLoading = true.obs;
  var savedReels = <int>[].obs;

  // Comments Data
  var commentsList = <CommentModel>[].obs;
  var isCommentsLoading = false.obs;

  final String mediaAccountLabel = 'Media account';
  final String checkOutPrefix = 'Check out ';
  final String sendStoryLabel = 'Send this story';

  @override
  void onInit() {
    super.onInit();
    fetchReels();
  }

  void fetchReels() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      var dummyData = [
      ReelModel(
          id: 1,
          imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
          userProfileImage: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200',
          userName: '@Good Times',
          description: 'what a Trail!',
          source: '3month',
          likes: 2500,
          comments: 3500,
          shares: 1200,
          isFollowing: false,
          isLiked: false,
      ),
        ReelModel(
          id: 2,
          imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
          userProfileImage: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200',
          userName: 'Aliana',
          description: '',
          source: '2month',
          likes: 1500,
          comments: 800,
          shares: 450,
          isFollowing: true,
          isLiked: true,
        ),
      ];

      reelsList.assignAll(dummyData);
    } finally {
      isLoading(false);
    }
  }


  void fetchComments(int reelId) async {
    try {
      isCommentsLoading(true);
      await Future.delayed(const Duration(milliseconds: 500));
      var dummyComments = [
        CommentModel(
          id: 101,
          userName: 'Joser',
          location: 'New York',
          text: 'I wonder if they order that or not',
          userProfileImage: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200',
          likes: 1400,
          createdAt: '2h',
        ),
        CommentModel(
          id: 102,
          userName: 'Zayan',
          location: 'London',
          text: 'This is a beautiful shot! 🔥',
          userProfileImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
          likes: 850,
          createdAt: '5h',
        ),
      ];
      commentsList.assignAll(dummyComments);
    } finally {
      isCommentsLoading(false);
    }
  }

  final List<String> reactions =  ['❤️', '😂', '😮', '😍', '😢', '🔥', '👏', '🙌', '👍', '💯', '✨', '🙏', '😊', '😡', '❤️‍🔥', 'ℹ️'];
  final List<String> gifImages = [
    'https://images.unsplash.com/photo-1482961674540-0b0e8363a005?w=200',
    'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=200',
    'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=200',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    'https://images.unsplash.com/photo-1617854818583-09e7f077a156?w=200',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=200',
    'https://images.unsplash.com/photo-1490750967868-88df5691cc13?w=200',
  ];

  final List<String> reportReasons = [
    'Abusive or hateful',
    'Misleading or spam',
    'Violence or gory',
    'Sexual Content',
    'Minor safety',
    'Dangerous or criminal',
  ];

  String formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  void toggleLike(int index) {
    reelsList[index].isLiked = !reelsList[index].isLiked;
    reelsList[index].isLiked ? reelsList[index].likes++ : reelsList[index].likes--;
    reelsList.refresh();
  }

  void toggleCommentLike(int commentId) {
    int index = commentsList.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      commentsList[index].likes++;
      commentsList.refresh();
    }
  }

  void toggleFollow(int index) {
    reelsList[index].isFollowing = !reelsList[index].isFollowing;
    reelsList.refresh();
  }


  void incrementComment(int reelId) {
    int index = reelsList.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      reelsList[index].comments++;
      reelsList.refresh();
    }
  }

  void incrementShare(int index) {
    reelsList[index].shares++;
    reelsList.refresh();
  }

  void copyComment(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.back();
    Get.snackbar('Success', 'Copied to clipboard', snackPosition: SnackPosition.BOTTOM, duration: 1.seconds);
  }


  void onShareOptionTap(int reelId, String platform) async {
    int index = reelsList.indexWhere((r) => r.id == reelId);
    if (index == -1) return;
    if (platform == 'Copy link') {
      Clipboard.setData(ClipboardData(text: 'https://newsbreak.com/reels/$reelId'));
      Get.back();
      Get.snackbar("Success", "Link copied!");
      incrementShare(index);
    } else if (platform == 'More') {
      Get.back();
      await Share.share('Check out this story by ${reelsList[index].userName}: https://newsbreak.com/reels/$reelId');
      incrementShare(index);
    }
  }


  void submitReport({
    int? id,
    required String reason,
    required String type, // 'reel' OR 'comment'
  }) {}

  void saveReel(int id) {
    if (savedReels.contains(id)) {
      savedReels.remove(id);
      Get.snackbar('Removed', 'Removed from saved reels');
    } else {
      savedReels.add(id);
      Get.snackbar('Saved', 'Reel saved successfully!');
    }
  }


  void reportReel(int id, BuildContext context) {
    Get.back();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width),
      builder: (context) => ReportReelsSheet(reelId: id),
    );
  }

  void reportComment(int id, BuildContext context) {
    Get.back();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      builder: (context) => const ReportCommentSheet(),
    );
  }

  void openHelpCenter() {
    Get.back();
    Get.to(() => const LegalView(type: LegalType.terms));
  }

  void hideAuthorContent(String authorName) {
    reelsList.removeWhere((r) => r.userName == authorName);
    reelsList.refresh();
    Get.back();
  }

  void blockUser(String userName) {
    reelsList.removeWhere((r) => r.userName == userName);
    commentsList.removeWhere((c) => c.userName == userName);
    reelsList.refresh();
    commentsList.refresh();
    Get.back();
    Get.snackbar('Blocked', 'Content from $userName hidden');
  }

  void addComment(int reelId, String text, String? gifUrl) {
    if (text.isEmpty && gifUrl == null) return;
    final user = Get.find<AuthController>().user.value;

    var newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch,
      userName: user?.name ?? 'Guest',
      location: user?.location ?? 'Online',
      text: gifUrl ?? text,
      userProfileImage: user?.profileImageUrl ?? '',
      likes: 0,
      createdAt: 'Just now',
    );

    commentsList.insert(0, newComment);
    commentsList.refresh();

    int index = reelsList.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      reelsList[index].comments++;
      reelsList.refresh();
    }
  }
}