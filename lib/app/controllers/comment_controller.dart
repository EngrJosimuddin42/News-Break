import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_break/app/controllers/social_interaction_controller.dart';
import '../models/comment_model.dart';
import '../models/comment_source.dart';
import 'auth/auth_controller.dart';

class CommentController extends GetxController {
  final RxList<CommentModel> commentsList = <CommentModel>[].obs;
  final RxBool isCommentsLoading = false.obs;
  final RxBool isSendingComment = false.obs;

  // Write comment
  final TextEditingController commentTextController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Uint8List?> selectedImageBytes = Rx<Uint8List?>(null);
  final RxnString selectedGifUrl = RxnString();

  final Map<String, List<CommentModel>> _allCommentsCache = {};

  // Current source tracking
  dynamic currentId;
  CommentSource? currentSource;
  String currentTabType = 'news';

  @override
  void onClose() {
    commentTextController.dispose();
    super.onClose();
  }

  void loadComments(dynamic id, CommentSource source, {String tabType = 'news'}) {
    currentId = id;
    currentSource = source;
    currentTabType = tabType;
    final String key = _getCacheKey(id, tabType);

    if (_allCommentsCache.containsKey(key) && _allCommentsCache[key]!.isNotEmpty) {
      commentsList.assignAll(_allCommentsCache[key]!);
    } else {
      fetchComments(id, tabType: tabType);
    }
  }

  //tabType unique key
  String _getCacheKey(dynamic id, String tabType) {
    return '${tabType}_$id';
  }

  Future<void> submitComment(dynamic id, {String? gifUrl, String? imagePath}) async {
    final String text = commentTextController.text.trim();
    if (text.isEmpty && gifUrl == null && imagePath == null) return;

    isSendingComment.value = true;

    final user = Get.find<AuthController>().user.value;

    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch,
      userName: user?.name ?? 'Guest',
      location: user?.location ?? 'Online',
      text: text,
      gifUrl: gifUrl,
      imagePath: imagePath,
      userProfileImage: user?.profileImageUrl ?? '',
      likes: 0,
      createdAt: 'Just now',
    );

    commentsList.insert(0, newComment);

    // tabType  cache save
    final String key = _getCacheKey(id, currentTabType);
    _allCommentsCache[key] = List.from(commentsList);

    // tabType  count increment
    Get.find<SocialInteractionController>()
        .incrementCommentCount(id, source: currentTabType);

    // Reset UI
    commentTextController.clear();
    selectedGifUrl.value = null;
    selectedImage.value = null;
    selectedImageBytes.value = null;
    isSendingComment.value = false;
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
  }

  Future<void> fetchComments(dynamic id, {String tabType = 'news'}) async {
    try {
      isCommentsLoading(true);
      await Future.delayed(const Duration(milliseconds: 500));

      final dummyComments = [
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

      final String key = _getCacheKey(id, tabType);
      _allCommentsCache[key] = List.from(dummyComments);
    } finally {
      isCommentsLoading(false);
    }
  }

  final List<String> reportReasons = [
    'Abusive or hateful',
    'Misleading or spam',
    'Violence or gory',
    'Sexual Content',
    'Minor safety',
    'Dangerous or criminal',
  ];
}