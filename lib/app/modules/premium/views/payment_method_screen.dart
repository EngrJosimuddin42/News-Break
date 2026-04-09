import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'congrats_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selected;

  static const _methods = ['Bkash', 'Nagad', 'Rocket'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
        ),
        title: Text('Payment Method', style: AppTextStyles.labelLarge),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            ..._methods.map((method) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => setState(() => _selected = method),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _selected == method
                          ? const Color(0xFFFD5F5C)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(method, style: AppTextStyles.caption),
                      Icon(
                        _selected == method
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: _selected == method
                            ? const Color(0xFFFD5F5C)
                            : Colors.grey,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            )),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _selected == null
                    ? null
                    : () => Get.to(() => const CongratsScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selected == null
                      ? const Color(0xFFFD5F5C).withOpacity(0.4)
                      : const Color(0xFFFD5F5C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Continue',
                    style: AppTextStyles.labelLarge.copyWith(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}