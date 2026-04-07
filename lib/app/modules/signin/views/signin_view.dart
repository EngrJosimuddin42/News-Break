import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../controllers/signin_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              // Skip
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.onSkip,
                  child:Text(
                    'Skip',
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ),

              const Spacer(),

              // Logo
              Image.asset(
                'assets/images/newsbreak_logo.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 14),

               Text('Newsbreak',
               style: AppTextStyles.displayMedium.copyWith(fontSize: 18)),

              const SizedBox(height: 6),
              Text(
                "The Nation's Leading Local News App",
               style: AppTextStyles.bodyLarge,
              ),

              const SizedBox(height: 52),

              // Facebook
              _SocialButton(
                label: 'Continue with Facebook',
                onTap: controller.continueWithFacebook,
                iconWidget: Image.asset(
                  'assets/icons/facebook.png',
                  width: 22,
                  height: 22,
                ),
              ),
              const SizedBox(height: 14),

              // Google
              _SocialButton(
                label: 'Continue with Google',
                onTap: controller.continueWithGoogle,
                iconWidget: Image.asset(
                  'assets/icons/google.png',
                  width: 22,
                  height: 22,
                ),
              ),

              // Email (animated)
              Obx(
                    () => AnimatedSize(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeInOut,
                  child: controller.isExpanded.value
                      ? Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: _SocialButton(
                      label: 'Continue with Email',
                      onTap: controller.continueWithEmail,
                      iconWidget: Image.asset(
                        'assets/icons/email.png',
                        width: 22,
                        height: 22,
                      ),
                    ),
                  )
                      : const SizedBox.shrink(),
                ),
              ),

              const SizedBox(height: 20),

              // Arrow toggle
              Obx(
                    () => AnimatedOpacity(
                  opacity: controller.isExpanded.value ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: controller.toggleExpand,
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      height: 32,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.surface,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Terms
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                 style: AppTextStyles.labelMedium,
                  children: [
                    const TextSpan(text: 'By using NewsBreak, you agree to our '),
                    TextSpan(
                      text: 'Terms of use',
                      style: TextStyle(color: AppColors.linkColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.onTermsTap,
                    ),
                    const TextSpan(text: ' and\n'),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(color: AppColors.linkColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.onPrivacyTap,
                    ),
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable social button

class _SocialButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Widget iconWidget;

  const _SocialButton({
    required this.label,
    required this.onTap,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 48,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.background,
          side: const BorderSide(color: AppColors.surface, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}