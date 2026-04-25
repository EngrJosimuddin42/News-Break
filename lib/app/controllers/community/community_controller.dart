import 'package:get/get.dart';
import '../../models/community_post_model.dart';
import '../../modules/me/edit_profile_view.dart';
import '../../modules/community/community_create_post_view.dart';
import '../../widgets/app_snackbar.dart';

class CommunityController extends GetxController {
  final userName = "Amalia".obs;
  final userProfilePic = "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100".obs;
  var posts = <CommunityPostModel>[].obs;
  bool isJoined(int index) => joinedCommunityIds.contains(index);
  final joinedCommunityIds = <int>{}.obs;


  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void onCreatePost() => Get.to(() => const CommunityCreatePostView(openImagePicker: true));
  void onEditProfile() => Get.to(() => const EditProfileView());

  void submitPost(String content) {}

  void toggleJoin(int index) {
    if (joinedCommunityIds.contains(index)) {
      joinedCommunityIds.remove(index);
      AppSnackbar.success(message: 'Left community');
    } else {
      joinedCommunityIds.add(index);
      AppSnackbar.success(message: 'Joined community!');
    }
  }


  void fetchPosts() {
    var data = [
      CommunityPostModel(
        id: 1,
        category: 'Iran',
        userName: 'Donald Trump',
        userRole: 'The guardian',
        timeAgo: '2d ago',
        userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        text: 'Lorem ipsum dolor sit amet consectetur. Ut sed elementum pellentesque erat. In nisl facilisis ornare felis cras purus amet cursus.',
        imageUrls:
        ['https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=600',
        'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=600',
        ],
      likes: '1.4K',
      comments: '4K',
      shares: '67',
      ),

    CommunityPostModel(
      id: 2,
      category: 'Politics',
      userName: 'Jordan',
      userRole: 'Premium Member',
      timeAgo: '2h ago',
      userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      text: 'Lorem ipsum dolor sit amet consectetur. Ut sed elementum pellentesque erat. In nisl facilisis ornare felis cras purus amet cursus.',
      imageUrls: ['https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=600'],
      likes: '980',
      comments: '2.1K',
      shares: '34',
    )

    ];
    posts.assignAll(data);
  }
}