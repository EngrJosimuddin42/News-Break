import 'package:get/get.dart';

class PremiumController extends GetxController {
  // Plan selection
  final isYearly = true.obs;

  // Payment method selection
  final selectedMethod = RxnString();

  // Loading state
  final isLoading = false.obs;

  void selectPlan(bool yearly) => isYearly.value = yearly;

  void selectPaymentMethod(String method) => selectedMethod.value = method;

  Future<void> processPayment() async {
    if (selectedMethod.value == null) return;

    try {
      isLoading.value = true;

      // TODO: API call here
      await Future.delayed(const Duration(seconds: 2)); // simulate

      isLoading.value = false;
      Get.toNamed('/congrats');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Payment failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}