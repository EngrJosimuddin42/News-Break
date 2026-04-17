import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/reel_model.dart';
import '../../modules/me/settings/about/legal_view.dart';
import '../../modules/reels/three_dot/report_sheet.dart';
import 'package:share_plus/share_plus.dart';

class ReelsController extends GetxController {

  var reelsList = <ReelModel>[].obs;
  var isLoading = true.obs;

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


  String formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  void toggleLike(int index) {
    var reel = reelsList[index];
    reel.isLiked = !reel.isLiked;
    if (reel.isLiked) {
      reel.likes++;
    } else {
      reel.likes--;
    }
    reelsList.refresh();
  }


  void toggleFollow(int index) {
    reelsList[index].isFollowing = true;
    reelsList.refresh();
  }


  void incrementComment(int index) {
    reelsList[index].comments++;
    reelsList.refresh();
  }

  void incrementShare(int index) {
    reelsList[index].shares++;
    reelsList.refresh();
  }

  void onShareOptionTap(int reelId, String platform) async {
    int index = reelsList.indexWhere((element) => element.id == reelId);
    if (index != -1) {
      incrementShare(index);
    }
    if (platform == 'More') {
      Get.back();
      await Share.share(
        'Check out this story by ${reelsList[index].userName}: https://yourapp.com/reels/$reelId',
        subject: 'Share Reel',
      );
    } else {
      Get.back();
      if (platform == 'Copy link') {
        Get.snackbar("Success", "Link copied!");
      }
    }
  }

  void submitReport({required int reelId, required String reason}) async {}

  void saveReel(int id) async {}

  void reportReel(int id, BuildContext context) {
    Get.back();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      builder: (context) => ReportSheet(reelId: id),
    );
  }

  void openHelpCenter() {
    Get.back();
    Get.to(() => const LegalView(type: LegalType.terms));
  }

  void hideAuthorContent(String authorName) {
    reelsList.removeWhere((reel) => reel.userName == authorName);
    Get.back();
  }
}