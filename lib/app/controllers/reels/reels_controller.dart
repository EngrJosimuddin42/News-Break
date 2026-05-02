import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';
import '../../models/reel_model.dart';
import '../../modules/me/settings/about/legal_view.dart';
import '../../modules/reels/comments/report_comment_sheet.dart';
import '../../modules/reels/three_dot/report_reels_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import '../auth/auth_controller.dart';
import '../social_interaction_controller.dart';

class ReelsController extends GetxController {

//  Reels Data
  var reelsList = <ReelModel>[].obs;
  var isLoading = true.obs;
  var savedReels = <int>[].obs;
  var currentIndex = 0.obs;
  bool useCustomList = false;
  int initialIndex = 0;
  bool _isSharing = false;


  PageController pageController = PageController();

  final String mediaAccountLabel = 'Media account';
  final String checkOutPrefix = 'Check out ';
  final String sendStoryLabel = 'Send this story';

  SocialInteractionController get _social => Get.find<SocialInteractionController>();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  int _parseStatCount(String count) {
    count = count.toLowerCase().replaceAll(',', '');
    if (count.contains('k')) {
      return (double.parse(count.replaceAll('k', '')) * 1000).toInt();
    } else if (count.contains('m')) {
      return (double.parse(count.replaceAll('m', '')) * 1000000).toInt();
    }
    return int.tryParse(count) ?? 0;
  }


  void incrementComment(int reelId) {
    int index = reelsList.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      reelsList[index].comments++;
      reelsList.refresh();
    }
  }

  void resetToDefaultReels() {
    useCustomList = false;
    initialIndex = 0;
    fetchReels();
  }

  void updatePage(int index) {
    currentIndex.value = index;
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
  }

  void toggleLike(int index) {
    reelsList[index].isLiked = !reelsList[index].isLiked;
    reelsList[index].isLiked
        ? reelsList[index].likes++
        : reelsList[index].likes--;
    reelsList.refresh();
  }



  void incrementProfileView(dynamic user) {
    int currentViews = _parseStatCount(user.totalViews.toString());
    currentViews++;
    user.totalViews = _social.formatCount(currentViews);
    reelsList.refresh();
  }

  void toggleFollow(dynamic item) {
    if (item == null) return;
    item.isFollowing = !(item.isFollowing ?? false);
    try {
      if (item.totalFollowers != null) {
        int currentFollowers = _parseStatCount(item.totalFollowers.toString());
        currentFollowers = item.isFollowing
            ? currentFollowers + 1
            : (currentFollowers > 0 ? currentFollowers - 1 : 0);
        item.totalFollowers = _social.formatCount(currentFollowers);
      }
    } catch (e) {
      debugPrint("ToggleFollow Error: $e");
    }
    reelsList.refresh();
    update();
  }


  void incrementShare(int index) {
    reelsList[index].shares++;
    reelsList.refresh();
  }


  void saveReel(int id) {
    if (savedReels.contains(id)) {
      savedReels.remove(id);
      AppSnackbar.success(message: 'Removed from saved reels');
    } else {
      savedReels.add(id);
      AppSnackbar.success(message: 'Reel saved successfully!');
    }
  }


  void reportReel(int id, BuildContext context) {
    Get.back();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      builder: (context) => ReportReelsSheet(reelId: id),
    );
  }


  void reportComment(int id, BuildContext context) {
    Get.back();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
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


  void onShareOptionTap(int reelId, String platform,
      {String? shareUrl, String? userName}) async {
    if (_isSharing) return;
    _isSharing = true;

    int index = reelsList.indexWhere((r) => r.id == reelId);
    final String url = shareUrl ??
        (index != -1
            ? 'https://newsbreak.com/reels/$reelId'
            : 'https://newsbreak.com/news/$reelId');
    final String author =
        userName ?? (index != -1 ? reelsList[index].userName : '');

    if (platform == 'Copy link') {
      await Clipboard.setData(ClipboardData(text: url));
      if (index != -1) incrementShare(index);
      Get.back();
    } else if (platform == 'More') {
      Get.back();
      await Share.share('Check out this story by $author: $url');
      if (index != -1) incrementShare(index);
    }

    _isSharing = false;
  }


  void addUserReel({
    required String videoPath,
    required String thumbnailPath,
    required String text,
  }) {
    final user = AuthController.to.user.value;
    final newReel = ReelModel(
      id: DateTime.now().millisecondsSinceEpoch,
      videoUrl: videoPath,
      imageUrl: thumbnailPath,
      userName: user?.name ?? 'Me',
      userProfileImage: user?.profileImageUrl ?? '',
      description: text,
    );
    reelsList.insert(0, newReel);
  }


  void fetchReels() async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      var dummyData = [
      ReelModel(
          id: 1,
          imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800',
          videoUrl: 'https://www.w3schools.com/html/movie.mp4',
          userProfileImage: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200',
          userName: 'Good Times',
          description: 'what a Trail!',
          source: '6 days ago',
          location: 'Chicago, USA',
          userSince: 'Mar 2026',
          totalPosts: '45',
          totalViews: '12',
          totalFollowers: '15',
          likes: 25,
          comments: 35,
          shares: 12,
          isFollowing: false,
          isLiked: false,
        userVideos: [
          {'id': 'v1','imageUrl': 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400','videoUrl': 'https://www.w3schools.com/html/mov_bbb.mp4', 'title': 'Coding Life', 'views': '2.5k'},
          {'id': 'v2','imageUrl': 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=400','videoUrl': 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4', 'title': 'Beautiful Nature', 'views': '1.1k'},
          {'id': 'v3','imageUrl': 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=400','videoUrl': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', 'title': 'Morning Walk', 'views': '850'},
          {'id': 'v4','imageUrl': 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400','videoUrl': 'https://media.w3.org/2010/05/sintel/trailer.mp4', 'title': 'Forest Adventure', 'views': '3.2k'},
        ],
        userReactions: [
          {'id': 'r1','imageUrl': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=200','videoUrl': 'https://www.w3schools.com/html/movie.mp4', 'title': 'Laptop Review', 'time': 'Tuesday 11:30 AM'},
          {'id': 'r2','imageUrl': 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=200','videoUrl': 'https://media.w3.org/2010/05/sintel/trailer.mp4', 'title': 'Music Studio', 'time': 'Wednesday 8:00 PM'},
          {'id': 'r3','imageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200','videoUrl': 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4', 'title': 'Profile Portrait', 'time': 'Thursday 4:15 PM'},
          {'id': 'r4','imageUrl': 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=200','videoUrl': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', 'title': 'Web Development', 'time': 'Monday 9:05 AM'},
        ],
      ),
        ReelModel(
          id: 2,
          imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
          videoUrl:'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
          userProfileImage: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200',
          userName: 'Aliana',
          description: 'Discover exclusive content and updates from this creator!',
          source: '2 month ago',
          location: 'New York, USA',
          userSince: 'january 2026',
          totalPosts: '25',
          totalViews: '5k',
          totalFollowers: '2.5k',
          likes: 1500,
          comments: 800,
          shares: 450,
          isFollowing: false,
          isLiked: false,
          userVideos: [
            {'id': 'v1','imageUrl': 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?w=400','videoUrl': 'https://www.w3schools.com/html/mov_bbb.mp4', 'title': 'Love for animals', 'views': '904'},
            {'id': 'v2','imageUrl': 'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=400','videoUrl': 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4', 'title': ' Dear', 'views': '1024'},
            {'id': 'v3','imageUrl': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=400','videoUrl': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4','title': 'Love for animals', 'views': '570'},
            {'id': 'v4','imageUrl': 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=400','videoUrl': 'https://media.w3.org/2010/05/sintel/trailer.mp4', 'title': 'Tiger','views': '420'},
          ],
          userReactions: [
            {'id': 'r1','imageUrl': 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=200','videoUrl': 'https://www.w3schools.com/html/movie.mp4', 'title': 'Snake Venom', 'time': 'Friday 5:10 PM'},
            {'id': 'r2','imageUrl': 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?w=200','videoUrl': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', 'title': 'Animal', 'time': 'Saturday 2:10 PM'},
            {'id': 'r3','imageUrl': 'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=200','videoUrl': 'https://media.w3.org/2010/05/sintel/trailer.mp4', 'title': 'Dear','time': 'Monday 10:10 PM'},
            {'id': 'r4','imageUrl': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=200','videoUrl': 'https://www.w3schools.com/html/mov_bbb.mp4', 'title': 'Snake ','time': 'sunday 5:10 AM'},
          ],
        ),
      ];

      reelsList.assignAll(dummyData);
    } finally {
      isLoading(false);
    }
  }

}