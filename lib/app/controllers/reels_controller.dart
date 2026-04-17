import 'package:get/get.dart';

import '../models/reel_model.dart';

class ReelsController extends GetxController {

  var reelsList = <ReelModel>[].obs;
  var isLoading = true.obs;

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
          userName: '@Good Times',
          description: 'what a Trail!',
          source: '3month',
          likes: 2500,
          comments: 3500,
          shares: 1200,
          isFollowing: false,
          isLiked: false,
      )
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
}