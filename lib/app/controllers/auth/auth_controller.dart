import 'package:get/get.dart';
import '../../models/user_model.dart';
import '../../bindings/signin_binding.dart';
import '../../modules/signin/signin_view.dart';

class AuthController extends GetxController {

  static AuthController get to => Get.find();
  final user = Rxn<UserModel>();
  bool get isLoggedIn => user.value != null;

  String get userInitial =>
      user.value?.name.isNotEmpty == true
          ? user.value!.name[0].toUpperCase()
          : 'A';

  void loginWithUser({required String name, required String email}) {     // Dummy data — after replace by API
    user.value = UserModel(
      name: 'Amalia',
      username: 'amalia_rose',
      bio: 'Flutter Enthusiast & Content Creator',
      website: 'https://www.amaliarose.dev',
      email: 'amalia@example.com',
      profileImageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      location: 'Dhaka, Bangladesh',
    );
  }

  void logout() {
    user.value = null;

    Get.offAll( () => const SignInView(),
      binding: SignInBinding(),
    );
  }

  void updateProfile({
    required String name,
    String? username,
    required String email,
    String? bio,
    String? website,
    String? gender,
    String? birthYear,
    String? newImageUrl,
  }) {
    user.value = UserModel(
      name: name,
      username: username,
      email: email,
      bio: bio,
      website: website,
      gender: gender,
      birthYear: birthYear,
      profileImageUrl: newImageUrl ?? user.value?.profileImageUrl,
    );
  }
}

