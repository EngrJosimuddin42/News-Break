import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../controllers/me_controller.dart';

class CreatorOnboardView extends StatefulWidget {
  const CreatorOnboardView({super.key});

  @override
  State<CreatorOnboardView> createState() => _CreatorOnboardViewState();
}

class _CreatorOnboardViewState extends State<CreatorOnboardView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<Map<String, String>> _slides = [
    {
      'imageUrl': 'https://images.unsplash.com/photo-1504703395950-b89145a5425b?w=800',
      'title': 'Read Real News',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Tempus consectetur placerat facilisis sed diam malesuada libero interdum. Elit nulla non sit et cursus.',
      'likes': '2.5k',
      'comments': '1.2k',
      'followers': '1.3k',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
      'title': 'Be a Voice',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Tempus consectetur placerat facilisis sed diam malesuada libero interdum. Elit nulla non sit et cursus.',
      'likes': '2.5k',
      'comments': '1.2k',
      'followers': '1.3k',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1516321497487-e288fb19713f?w=800',
      'title': 'Capture Moments',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Tempus consectetur placerat facilisis sed diam malesuada libero interdum. Elit nulla non sit et cursus.',
      'likes': '2.5k',
      'comments': '1.2k',
      'followers': '1.3k',
    },
  ];

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
          // Full screen page view
          PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, i) {
              final slide = _slides[i];
              return Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.network(
                      slide['imageUrl']!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: Colors.grey[900]),
                    ),
                  ),
                  // Dark overlay
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black87,
                          ],
                          stops: [0.4, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Right side actions
                  Positioned(
                    right: 16,
                    top: MediaQuery.of(context).size.height * 0.35,
                    child: Column(
                      children: [
                        // Timer icon
                        Stack(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/timer.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color:AppColors.textGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.add, color: Colors.white, size: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Like
                        const Icon(Icons.thumb_up_outlined, color: Colors.white, size: 44),
                        Text(slide['likes'] ?? '0',
                            style:AppTextStyles.buttonOutline),
                        const SizedBox(height: 16),
                        // Comment
                        Image.asset('assets/icons/comment2.png', color: Colors.white, width: 44,height: 44),
                        Text(slide['comments'] ?? '0',
                            style:AppTextStyles.buttonOutline),
                        const SizedBox(height: 16),
                        // Share
                        Image.asset('assets/icons/share1.png',height: 44,width: 44),
                        Text('Share',
                            style:AppTextStyles.buttonOutline),
                        const SizedBox(height: 16),
                        // More
                        const Icon(Icons.more_vert, color: Colors.white, size: 32),
                      ],
                    ),
                  ),

                  // Bottom content
                  Positioned(
                    bottom: 100,
                    left: 16,
                    right: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text('${slide['followers'] ?? '0'} Followers',
                          style: AppTextStyles.button.copyWith(fontSize: 34),
                        )),
                        const SizedBox(height: 8),
                        Text(
                          slide['title']!,
                          style: AppTextStyles.button.copyWith(fontSize: 26),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          slide['subtitle']!,
                          style: AppTextStyles.display,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Page indicators
                  Positioned(
                    bottom: 82,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _slides.length,
                            (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _currentPage == i ? 8 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? Colors.white
                                : Color(0xFF6E6D6D),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Create Now button
                  Positioned(
                    bottom: 26,
                    left: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.find<MeController>().completeOnboarding();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding:
                        const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child:Text('Create Now',
                          style:AppTextStyles.bodyMedium.copyWith(color: AppColors.background)),
                    ),
                  ),

                  // Back button
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}