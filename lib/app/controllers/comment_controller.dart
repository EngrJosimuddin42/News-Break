import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/comment_model.dart';
import '../models/comment_source.dart';
import '../widgets/app_snackbar.dart';
import 'auth/auth_controller.dart';

class CommentController extends GetxController {
  final RxList<CommentModel> commentsList = <CommentModel>[].obs;
  final RxBool isCommentsLoading = false.obs;
  final RxBool isSendingComment = false.obs;
  final RxString gifSearchQuery = ''.obs;

  // Write comment
  final TextEditingController commentTextController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);
  final RxnString selectedGifUrl = RxnString();
  final RxBool isGifPickerMode = false.obs;

  // Current source tracking
  dynamic currentId;
  CommentSource? currentSource;

  List<String> get filteredGifImages {
    if (gifSearchQuery.value.isEmpty) return gifImages;
    return gifImages
        .where((url) => url.toLowerCase()
        .contains(gifSearchQuery.value.toLowerCase()))
        .toList();
  }

  @override
  void onClose() {
    commentTextController.dispose();
    super.onClose();
  }


  void loadComments(dynamic id, CommentSource source) {
    currentId = id;
    currentSource = source;
    fetchComments(id);
  }

  void toggleCommentLike(dynamic commentId) {
    final index = commentsList.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      commentsList[index].isLiked = !commentsList[index].isLiked;
      commentsList[index].isLiked
          ? commentsList[index].likes++
          : commentsList[index].likes--;
      commentsList.refresh();
    }
  }


  void toggleFollow(CommentModel comment) {
    comment.isFollowing = !(comment.isFollowing ?? false);
    commentsList.refresh();
  }


  Future<void> submitComment(dynamic id, String? gifUrl) async {
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
      createdAt: 'Just now',
    );

    commentsList.insert(0, newComment);
    commentTextController.clear();
    selectedGifUrl.value = null;
    selectedImage.value = null;
    selectedImageBytes.value = null;
    isSendingComment.value = false;
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
  }

  //  Media picker
  Future<void> onAddMedia() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      selectedImageBytes.value = bytes;
      selectedImage.value = kIsWeb ? null : File(image.path);
      selectedGifUrl.value = null;
    }
  }

  //  GIF select
  void selectGif(String url) {
    selectedGifUrl.value = url;
    selectedImage.value = null;
    isGifPickerMode.value = false;
  }

  //  Media clear
  void clearCommentMedia() {
    selectedImage.value = null;
    selectedImageBytes.value = null;
    selectedGifUrl.value = null;
    isGifPickerMode.value = false;
  }

  //  Copy comment
  void copyComment(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.back();
    AppSnackbar.success(message: 'Copied to clipboard');
  }

  //  Block user
  void blockUser(String userName) {
    commentsList.removeWhere((c) => c.userName == userName);
    commentsList.refresh();
    Get.back();
    AppSnackbar.success(message: 'Content from $userName hidden');
  }

  //  Format count
  String formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  int parseStatCount(String count) {
    count = count.toLowerCase().replaceAll(',', '');
    if (count.contains('k')) {
      return (double.parse(count.replaceAll('k', '')) * 1000).toInt();
    } else if (count.contains('m')) {
      return (double.parse(count.replaceAll('m', '')) * 1000000).toInt();
    }
    return int.tryParse(count) ?? 0;
  }

  void submitReport({
    dynamic id,
    required String reason,
    required String type, // 'reel' OR 'comment'
  }) {}


  Future<void> fetchComments(dynamic id) async {
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