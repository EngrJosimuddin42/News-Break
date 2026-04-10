import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final user = Rxn<UserModel>();

  String get userInitial =>
      user.value?.name.isNotEmpty == true
          ? user.value!.name[0].toUpperCase()
          : 'A';

  // TODO: এখানে API থেকে user load
  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  void _loadUser() {
    // Dummy data — পরে API দিয়ে replace
    user.value = UserModel(
      name: 'Amalia',
      email: 'amalia@example.com',
    );
  }

  void logout() {
    user.value = null;
    Get.offAllNamed('/login');
  }
}

class UserModel {
  final String name;
  final String email;

  UserModel({required this.name, required this.email});
}