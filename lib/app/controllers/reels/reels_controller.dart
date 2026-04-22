import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';
import '../../models/comment_model.dart';
import '../../models/reel_model.dart';
import '../../modules/me/settings/about/legal_view.dart';
import '../../modules/reels/comments/report_comment_sheet.dart';
import '../../modules/reels/three_dot/report_reels_sheet.dart';
import 'package:share_plus/share_plus.dart';
import '../auth_controller.dart';
import 'package:flutter/services.dart';

class ReelsController extends GetxController {

  final TextEditingController commentTextController = TextEditingController();

//  Reels Data
  var reelsList = <ReelModel>[].obs;
  var isLoading = true.obs;
  var savedReels = <int>[].obs;
  var currentIndex = 0.obs;
  var selectedImage = Rx<File?>(null);
  var isGifPickerMode = false.obs;
  var selectedGifUrl = RxnString();
  var isSendingComment = false.obs;

  late PageController pageController;

  // Comments Data
  var commentsList = <CommentModel>[].obs;
  var isCommentsLoading = false.obs;

  final String mediaAccountLabel = 'Media account';
  final String checkOutPrefix = 'Check out ';
  final String sendStoryLabel = 'Send this story';

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
    fetchReels();
  }

  @override
  void onClose() {
    commentTextController.dispose();
    pageController.dispose();
    super.onClose();
  }

  String formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  void onAddMedia() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      selectedGifUrl.value = null;
    }
  }

  void selectGif(String url) {
    selectedGifUrl.value = url;
    selectedImage.value = null;
    isGifPickerMode.value = false;
  }

  Future<void> submitComment(int reelId, String? gifUrl) async {
    String text = commentTextController.text.trim();
    if (text.isEmpty && gifUrl == null && selectedImage.value == null) return;
    isSendingComment.value = true;
    final user = Get.find<AuthController>().user.value;
    var newComment = CommentModel(
        id: DateTime.now().millisecondsSinceEpoch,
        userName: user?.name ?? 'Guest',
        location: user?.location ?? 'Online',
        text: text,
        gifUrl: gifUrl,
        imagePath: selectedImage.value?.path,
        userProfileImage: user?.profileImageUrl ?? '',
        likes: 0,
        createdAt: 'Just now');
    commentsList.insert(0, newComment);
    incrementComment(reelId);
    commentTextController.clear();
    selectedGifUrl.value = null;
    selectedImage.value = null;
    isSendingComment.value = false;
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
  }


  void incrementComment(int reelId) {
    int index = reelsList.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      reelsList[index].comments++;
      reelsList.refresh();
    }
  }


  void updatePage(int index) {
    currentIndex.value = index;
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
  }

  void toggleLike(int index) {
    reelsList[index].isLiked = !reelsList[index].isLiked;
    reelsList[index].isLiked ? reelsList[index].likes++ : reelsList[index].likes--;
    reelsList.refresh();
  }

  void toggleCommentLike(int commentId) {
    int index = commentsList.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      commentsList[index].isLiked = !commentsList[index].isLiked;
      commentsList[index].isLiked ? commentsList[index].likes++ : commentsList[index].likes--;
      commentsList.refresh();
    }
  }

  void incrementProfileView(dynamic user) {
    int currentViews = _parseStatCount(user.totalViews.toString());
    currentViews++;
    user.totalViews = formatCount(currentViews);
    reelsList.refresh();
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


  void toggleFollow(dynamic item) {
    if (item == null) return;
    item.isFollowing = !(item.isFollowing ?? false);
    try {
      if (item.totalFollowers != null) {
        int currentFollowers = _parseStatCount(item.totalFollowers.toString());
        if (item.isFollowing) {
          currentFollowers++;
        } else {
          currentFollowers = currentFollowers > 0 ? currentFollowers - 1 : 0;
        }
        item.totalFollowers = formatCount(currentFollowers);
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

  void copyComment(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.back();
    AppSnackbar.success(message:'Copied to clipboard');
  }

  void onShareOptionTap(int reelId, String platform) async {
    int index = reelsList.indexWhere((r) => r.id == reelId);
    if (index == -1) return;
    if (platform == 'Copy link') {
      Clipboard.setData(ClipboardData(text: 'https://newsbreak.com/reels/$reelId'));
      Get.back();
      AppSnackbar.success(message: "Link copied!");
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
      AppSnackbar.success(message:'Removed from saved reels');
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
    AppSnackbar.success(message:'Content from $userName hidden');
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
          userName: '@Good Times',
          description: 'what a Trail!',
          source: '3month',
          location: 'Chicago, USA',
          userSince: 'Mar 2026',
          totalPosts: '45',
          totalViews: '12k',
          totalFollowers: '1.5k',
          likes: 2500,
          comments: 3500,
          shares: 1200,
          isFollowing: false,
          isLiked: false,
        userVideos: [
          {'id': 'v1','imageUrl': 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400','videoUrl': 'https://www.w3schools.com/html/mov_bbb.mp4', 'title': 'Coding Life', 'views': '2.5k'},
          {'id': 'v2','imageUrl': 'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=400','videoUrl': 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4', 'title': 'Beautiful Nature', 'views': '1.1k'},
          {'id': 'v3','imageUrl': 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=400','videoUrl': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', 'title': 'Morning Walk', 'views': '850'},
          {'id': 'v4','imageUrl': 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400','videoUrl': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4', 'title': 'Forest Adventure', 'views': '3.2k'},
        ],
        userReactions: [
          {'id': 'r1','imageUrl': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=200','videoUrl': 'https://www.w3schools.com/html/movie.mp4', 'title': 'Laptop Review', 'time': 'Tuesday 11:30 AM'},
          {'id': 'r2','imageUrl': 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=200','videoUrl': 'https://www.example.com/video1.mp4', 'title': 'Music Studio', 'time': 'Wednesday 8:00 PM'},
          {'id': 'r3','imageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200','videoUrl': 'https://www.example.com/video1.mp4', 'title': 'Profile Portrait', 'time': 'Thursday 4:15 PM'},
          {'id': 'r4','imageUrl': 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=200','videoUrl': 'https://www.example.com/video1.mp4', 'title': 'Web Development', 'time': 'Monday 9:05 AM'},
        ],
      ),
        ReelModel(
          id: 2,
          imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
          videoUrl:'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
          userProfileImage: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200',
          userName: 'Aliana',
          description: 'Discover exclusive content and updates from this creator!',
          source: '2month',
          location: 'New York, USA',
          userSince: 'january 2026',
          totalPosts: '25',
          totalViews: '5k',
          totalFollowers: '2.5k',
          likes: 1500,
          comments: 800,
          shares: 450,
          isFollowing: true,
          isLiked: true,
          userVideos: [
            {'id': 'v1','imageUrl': 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?w=400','videoUrl': 'https://www.w3schools.com/html/mov_bbb.mp4', 'title': 'Love for animals', 'views': '904'},
            {'id': 'v2','imageUrl': 'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=400','videoUrl': 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4', 'title': ' Dear', 'views': '1024'},
            {'id': 'v3','imageUrl': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=400','videoUrl': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4','title': 'Love for animals', 'views': '570'},
            {'id': 'v4','imageUrl': 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=400','videoUrl': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4', 'title': 'Tiger','views': '420'},
          ],
          userReactions: [
            {'id': 'r1','imageUrl': 'https://images.unsplash.com/photo-1546182990-dffeafbe841d?w=200','videoUrl': 'https://www.w3schools.com/html/movie.mp4', 'title': 'Snake Venom', 'time': 'Friday 5:10 PM'},
            {'id': 'r2','imageUrl': 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?w=200','videoUrl': 'https://www.example.com/video1.mp4', 'title': 'Animal', 'time': 'Saturday 2:10 PM'},
            {'id': 'r3','imageUrl': 'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=200','videoUrl': 'https://www.example.com/video1.mp4', 'title': 'Dear','time': 'Monday 10:10 PM'},
            {'id': 'r4','imageUrl': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=200','videoUrl': 'https://www.example.com/video1.mp4', 'title': 'Snake ','time': 'sunday 5:10 AM'},
          ],
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

}