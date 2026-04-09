import 'package:get/get.dart';
import '../views/community_create_post_view.dart';

class CommunityController extends GetxController {
  final userName = "Amalia".obs;
  final userProfilePic = "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100".obs;

  void onCreatePost() => Get.to(() => const CommunityCreatePostView());
  void onCreateImage() => Get.to(() => const CommunityCreatePostView(
    openImagePicker: true,
  ));

  void submitPost(String content) {}
}