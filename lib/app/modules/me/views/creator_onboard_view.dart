import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800',
      'title': 'Be a Voice',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Tempus consectetur placerat facilisis sed diam malesuada libero interdum. Elit nulla non sit et cursus.',
      'likes': '2.5k',
      'comments': '1.2k',
    },
    {
      'imageUrl': 'https://images.unsplash.com/photo-1452780212442-1b8b41d4a5b9?w=800',
      'title': 'Capture Moments',
      'subtitle': 'Lorem ipsum dolor sit amet consectetur. Tempus consectetur placerat facilisis sed diam malesuada libero interdum. Elit nulla non sit et cursus.',
      'likes': '2.5k',
      'comments': '1.2k',
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
                        Container(
                          width: 44,
                          height: 44,
                          child: Image.asset('assets/images/timer.png'),
                        ),
                        const SizedBox(height: 16),
                        // Like
                        const Icon(Icons.thumb_up_outlined, color: Colors.white, size: 32),
                        Text(slide['likes'] ?? '0',
                            style: TextStyle(
                                color: Colors.white, fontSize: 12)),
                        const SizedBox(height: 16),
                        // Comment
                        Image.asset('assets/icons/comment.png', color: Colors.white, width: 44,height: 44),
                        Text(slide['comments'] ?? '0',
                            style: TextStyle(
                                color: Colors.white, fontSize: 12)),
                        const SizedBox(height: 16),
                        // Share
                        const Icon(Icons.share_outlined,
                            color: Colors.white, size: 24),
                        const Text('Share',
                            style: TextStyle(
                                color: Colors.white, fontSize: 12)),
                        const SizedBox(height: 16),
                        // More
                        const Icon(Icons.more_horiz,
                            color: Colors.white, size: 24),
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
                        const Text(
                          '1.3k Followers',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          slide['title']!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          slide['subtitle']!,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              height: 1.4),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Page indicators
                  Positioned(
                    bottom: 72,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _slides.length,
                            (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _currentPage == i ? 16 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? Colors.white
                                : Colors.white38,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Create Now button
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding:
                        const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Create Now',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),

                  // Back button
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 20),
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