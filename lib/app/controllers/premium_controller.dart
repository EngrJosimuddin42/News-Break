import 'package:get/get.dart';
import 'package:news_break/app/controllers/auth/auth_controller.dart';

import '../modules/premium/congrats_screen.dart';

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


/*import 'package:get/get.dart';
import '../../widgets/app_snackbar.dart';

class PremiumController extends GetxController {
  var selectedPlan = 'yearly'.obs;

  final List<Map<String, String>> features = [
    {'title': 'Ad-free in App', 'subtitle': 'Millions of articles, videos, local Tvs, etc'},
    {'title': 'Personalized recommendations', 'subtitle': 'See more stories that match your interest'},
    {'title': 'Comment Boost', 'subtitle': 'Receive enhances visibility for your comments'},
    {'title': 'Avatar ring', 'subtitle': 'Make your premium membership shine'},
    {'title': 'Priority support', 'subtitle': 'Email: premium-support@news.com'},
  ];

  void selectPlan(String plan) => selectedPlan.value = plan;

  void onStartTrial() {
    // ✅ API: await ApiService.startTrial(selectedPlan.value);
    AppSnackbar.success(message: '7-day free trial started!');
  }
}*/