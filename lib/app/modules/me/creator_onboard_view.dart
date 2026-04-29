import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/me/me_controller.dart';

class CreatorOnboardView extends StatefulWidget {
  const CreatorOnboardView({super.key});

  @override
  State<CreatorOnboardView> createState() => _CreatorOnboardViewState();
}

class _CreatorOnboardViewState extends State<CreatorOnboardView> {
  final PageController _pageController = PageController();
  final controller = Get.find<MeController>();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildPageView(),

          _buildBackButton(),

          _buildBottomActions(),
        ],
      ),
    );
  }


  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: controller.onboardSlides.length,
      onPageChanged: (i) => setState(() => _currentPage = i),
      itemBuilder: (_, i) {
        final slide = controller.onboardSlides[i];
        return Stack(
          children: [
            _buildBackgroundImage(slide['imageUrl'] ?? ''),
            _buildDarkOverlay(),
            _buildRightActions(slide),
            _buildBottomContent(slide),
          ],
        );
      },
    );
  }


  Widget _buildBackgroundImage(String url) {
    return Positioned.fill(
      child: url.isNotEmpty
          ? Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
        errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[900], child: const Icon(Icons.broken_image, color: Colors.white24)))
          : Container(color: Colors.grey[900]),
    );
  }


  Widget _buildDarkOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black87],
            stops: [0.4, 1.0]))),
    );
  }

  Widget _buildRightActions(Map<String, String> slide) {
    return Positioned(
      right: 16,
      top: MediaQuery.of(context).size.height * 0.43,
      child: Column(
        children: [
          _buildAvatarWithPlus(),
          const SizedBox(height: 16),
          _buildActionButton(Icons.thumb_up_outlined, slide['likes'] ?? '0'),
          const SizedBox(height: 16),
          _buildImageButton('assets/icons/comment2.png', slide['comments'] ?? '0'),
          const SizedBox(height: 16),
          _buildImageButton('assets/icons/share1.png', 'Share'),
          const SizedBox(height: 16),
          const Icon(Icons.more_vert, color: Colors.white, size: 32),
        ],
      ),
    );
  }


  Widget _buildBottomContent(Map<String, String> slide) {
    return Positioned( bottom: 140, left: 16,  right: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text('${slide['followers'] ?? '0'} Followers', textAlign: TextAlign.center,
              style: AppTextStyles.displayMedium.copyWith(fontWeight: FontWeight.w500))),
          const SizedBox(height: 32),
          Text( slide['title'] ?? '', style: AppTextStyles.tagline.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(slide['subtitle'] ?? '', style: AppTextStyles.display.copyWith(color: Color(0xFFB4B4B4)), maxLines: 3,
            overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }


  Widget _buildBottomActions() {
    return Positioned( bottom: 5, left: 0, right: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.onboardSlides.length,
                  (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == i ? Colors.white : Color(0xFF6E6D6D),
                  shape: BoxShape.circle)))),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  controller.completeOnboarding();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: Text('Create Now', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.background))))),
        ],
      ),
    );
  }


  Widget _buildBackButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10, left: 16,
      child: GestureDetector(
      onTap: () => Get.back(),
      child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
    );
  }

  Widget _buildAvatarWithPlus() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('assets/images/timer.png')),
        Positioned( bottom: -5, left: 13,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(color: AppColors.textGreen, shape: BoxShape.circle),
            child: const Icon(Icons.add, color: Colors.white, size: 14))),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 35),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.buttonOutline.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildImageButton(String path, String label) {
    return Column(
      children: [
        Image.asset(path, color: Colors.white, width: 35, height: 35),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.buttonOutline.copyWith(fontSize: 12)),
      ],
    );
  }
}