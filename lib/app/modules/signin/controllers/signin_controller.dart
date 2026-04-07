import 'package:get/get.dart';
import 'package:news_break/app/widgets/app_snackbar.dart';

import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  final RxBool isExpanded = false.obs;

  void toggleExpand() => isExpanded.value = true;

  void continueWithFacebook() {
   AppSnackbar.facebook(message: 'Signing in with Facebook...');
  }

  void continueWithGoogle() {
   AppSnackbar.google(message: 'Signing in with Google...');
  }

  void continueWithEmail() {
  AppSnackbar.email(message: 'Signing in with Email...');
  }

  void onSkip() {
     Get.offNamed(Routes.HOME);
  }

  void onTermsTap() {
    // launch terms URL
  }

  void onPrivacyTap() {
    // launch privacy URL
  }
}