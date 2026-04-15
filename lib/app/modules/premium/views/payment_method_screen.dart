import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../controllers/premium_controller.dart';

class PaymentMethodScreen extends GetView<PremiumController> {
  const PaymentMethodScreen({super.key});

  static const _methods = ['Bkash', 'Nagad', 'Rocket'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        ),
        title: Text('Payment Method', style: AppTextStyles.displaySmall),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Obx(() => Column(
              children: _methods.map((method) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => controller.selectPaymentMethod(method),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF333333),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(method, style: AppTextStyles.caption),
                        Icon(
                          controller.selectedMethod.value == method
                              ? Icons.check_circle_outline
                              : Icons.radio_button_unchecked,
                          color: controller.selectedMethod.value == method
                              ? AppColors.linkColor
                              : AppColors.gray,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              )).toList(),
            )),
            const Spacer(),

            Obx(() => controller.selectedMethod.value == null
                ? const SizedBox.shrink()
                : SizedBox(
              width: 311,
              height: 48,
              child: ElevatedButton(
                onPressed: () => controller.processPayment(),
                style: ElevatedButton.styleFrom(
                  backgroundColor:AppColors.linkColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : Text('Continue',
                    style: AppTextStyles.caption),
              ),
            ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}