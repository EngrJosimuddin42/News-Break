import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../controllers/signin_controller.dart';

class SignInView extends GetView<SignInController> {
  final bool isSheet;
  const SignInView({super.key, this.isSheet = false});

  @override
  Widget build(BuildContext context) {
    return isSheet ? _buildSheet(context) : _buildFullScreen(context);
  }

  // Full screen
  Widget _buildFullScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              // Skip
              Align( alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.onSkip,
                  child: Text('Skip', style: AppTextStyles.bodyMedium))),
              const Spacer(),
              Image.asset('assets/images/newsbreak_logo.png',width: 80, height: 80),
              const SizedBox(height: 14),
              Text('Newsbreak', style: AppTextStyles.displayMedium.copyWith(fontSize: 18)),
              const SizedBox(height: 6),
              Text("The Nation's Leading Local News App",style: AppTextStyles.bodyLarge),
              const SizedBox(height: 52),
              _buttons(),
              const SizedBox(height: 10),
              _terms(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  //Bottom sheet (From news detail)
  Widget _buildSheet(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close
          Align(alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.close, color: Colors.white, size: 20))),
          const SizedBox(height: 8),

          // Logo
          Image.asset('assets/images/newsbreak_logo.png', width: 60, height: 60),
          const SizedBox(height: 12),

          // Title
          Text('Create an account', style: AppTextStyles.displaySmall),
          const SizedBox(height: 12),

          // Subtitle
          Text('Log in or sign up to comment', style: AppTextStyles.overline),
          const SizedBox(height: 48),

          _buttons(),
          const SizedBox(height: 10),
          _terms(),
        ],
      ),
    );
  }

  // Shared widgets
  Widget _buttons() {
    return Column(
      children: [
        Obx(() => _SocialButton(
          label: 'Continue with Facebook',
          onTap: controller.continueWithFacebook,
          iconWidget: Image.asset('assets/icons/facebook.png', width: 22, height: 22),
          isLoading: controller.isLoading.value)),
        const SizedBox(height: 14),
        Obx(() => _SocialButton(
          label: 'Continue with Google',
          onTap: controller.continueWithGoogle,
          iconWidget: Image.asset('assets/icons/google.png',width: 22, height: 22),
            isLoading: controller.isLoading.value)),

        Obx(() => AnimatedSize(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOut,
          child: controller.isExpanded.value
              ? Padding(
            padding: const EdgeInsets.only(top: 14),
            child: _SocialButton(
              label: 'Continue with Email',
              onTap: controller.continueWithEmail,
              iconWidget: Image.asset('assets/icons/email.png',width: 22, height: 22),
              isLoading: controller.isLoading.value))
              : const SizedBox.shrink())),

        const SizedBox(height: 20),
        Obx(() => AnimatedOpacity(
          opacity: controller.isExpanded.value ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: controller.toggleExpand,
            behavior: HitTestBehavior.opaque,
            child: SizedBox( height: 32,
              child: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.surface, size: 30))))),
      ],
    );
  }

  //Reusable Terms
  Widget _terms() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(style: AppTextStyles.labelMedium,
        children: [
          const TextSpan(text: 'By using NewsBreak, you agree to our '),
          TextSpan( text: 'Terms of use',  style: TextStyle(color: AppColors.linkColor),
            recognizer: TapGestureRecognizer()
              ..onTap = controller.onTermsTap),
          const TextSpan(text: ' and\n'),
          TextSpan(text: 'Privacy Policy', style: const TextStyle(color: AppColors.linkColor),
            recognizer: TapGestureRecognizer()
              ..onTap = controller.onPrivacyTap),
        ],
      ),
    );
  }
}

// Reusable social button
class _SocialButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Widget iconWidget;
  final bool isLoading;

  const _SocialButton({
    required this.label,
    required this.onTap,
    required this.iconWidget,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 335, height: 48,
      child: OutlinedButton(
        onPressed: isLoading ? null : onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.background,
          side: const BorderSide(color: AppColors.surface, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100))),
        child:isLoading
            ? const SizedBox(height: 20, width: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: 10),
            Text(label, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}