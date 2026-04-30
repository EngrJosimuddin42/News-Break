import 'package:get/get.dart';
import '../../models/socials_model.dart';
import '../../modules/me/edit_profile_view.dart';
import '../../routes/app_pages.dart';
import '../../widgets/app_snackbar.dart';
import '../auth/auth_controller.dart';

class SocialsController extends GetxController {

  // Posts
  var posts = <SocialsModel>[].obs;
  var isPostsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  //  Navigation
  void onCreatePost() {
    Get.toNamed(Routes.SOCIALS_CREATE_POST, arguments: 'social');
  }

  void onEditProfile() => Get.to(() => const EditProfileView());



  // Report Reasons
  final reportReasons = <String>[
    'Abusive or hateful',
    'Misleading or spam',
    'Violence or gory',
    'Sexual Content',
    'Minor safety',
    'Dangerous or criminal',
    'Others',
  ].obs;

  // Posts
  Future<void> fetchPosts() async {
    try {
      isPostsLoading.value = true;
      //  API: posts.assignAll(await ApiService.getCommunityPosts());
      await Future.delayed(const Duration(milliseconds: 300));
      posts.assignAll(_mockPosts());
    } catch (e) {
      AppSnackbar.error(message: 'Failed to load posts');
    } finally {
      isPostsLoading.value = false;
    }
  }

  Future<void> submitPost(String content, {String? imageUrl}) async {
    if (content.trim().isEmpty && imageUrl == null) return;

    final newPost = SocialsModel(
      id: DateTime.now().millisecondsSinceEpoch,
      category: 'General',
      userName: AuthController.to.user.value?.name ?? 'Me',
      userRole: 'Member',
      timeAgo: 'Just now',
      userImageUrl: AuthController.to.user.value?.profileImageUrl ?? '',
      text: content,
      imageUrls: imageUrl != null ? [imageUrl] : [],
    );
    posts.insert(0, newPost);
  }

  //  Mock Data
  List<SocialsModel> _mockPosts() => [
    SocialsModel(
      id: 1,
      category: 'Iran',
      userName: 'Donald Trump',
      userRole: 'The guardian',
      timeAgo: '2d ago',
      userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      text: 'Lorem ipsum dolor sit amet consectetur. Ut sed elementum pellentesque erat. In nisl facilisis ornare felis cras purus amet cursus.',
      imageUrls: [
        'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=600',
        'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=600',
      ],
      likes: '520',
      comments: '150',
      shares: '67',
    ),
    SocialsModel(
      id: 2,
      category: 'Politics',
      userName: 'Jordan',
      userRole: 'Premium Member',
      timeAgo: '2h ago',
      userImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      text: 'Lorem ipsum dolor sit amet consectetur. Ut sed elementum pellentesque erat. In nisl facilisis ornare felis cras purus amet cursus.',
      imageUrls: ['https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?w=600'],
      likes: '980',
      comments: '22',
      shares: '34',
    ),
  ];

  var communityInsights = <Map<String, String>>[
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200',
    },
    {
      'title': 'Become a "LeftoverHero"',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Id ipsum hac habitant',
      'imageUrl': 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=200',
    },
  ].obs;
}