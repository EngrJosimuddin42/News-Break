import 'package:get/get.dart';
import 'package:news_break/app/core/controllers/auth_controller.dart';

import '../views/congrats_screen.dart';

class PremiumController extends GetxController {
  final isYearly = true.obs;
  final selectedMethod = RxnString();
  final isLoading = false.obs;

  String get userInitial => Get.find<AuthController>().userInitial;

  void selectPlan(bool yearly) => isYearly.value = yearly;

  void selectPaymentMethod(String method) => selectedMethod.value = method;

  Future<void> processPayment() async {
    if (selectedMethod.value == null) return;

    try {
      isLoading.value = true;

      // TODO: API call here
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;
      Get.to(() => const CongratsScreen());
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Payment failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}