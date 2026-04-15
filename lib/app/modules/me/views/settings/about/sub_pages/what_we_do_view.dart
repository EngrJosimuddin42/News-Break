import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'creator_page_view.dart';
import 'help_widgets.dart';

class WhatWeDoView extends StatelessWidget {
  const WhatWeDoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelpWidgets.helpAppBar('Help Center'),
      body: Column(
        children: [
          const HelpTabBar(),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Expanded(
            child: ListView(
              children: [
                // Hero section
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text('Over 50 Million Users',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      const Text('Welcome to the nation\'s\nleading news app',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _phoneImage(),
                          const SizedBox(width: 8),
                          _phoneImage(),
                        ],
                      ),
                    ],
                  ),
                ),

                // Stay alert section
                Container(
                  color: const Color(0xFFF8F8F8),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text('Stay alert,\nStay safe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      const Text(
                        'Stay safe and informed with immediate access to local crime and police alerts and incident reports in your neighborhood',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54, fontSize: 13, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      _phoneImage(wide: true),
                    ],
                  ),
                ),

                // Contributors
                _ctaSection(
                  tag: 'For Contributors',
                  title: 'Share Your Stories',
                  subtitle:
                  'Earn recognition and revenue by sharing important stories from your community',
                  buttonLabel: 'Become a contributor',
                  onTap: () => Get.to(() => const CreatorPageView(pageKey: 'contributor')),
                ),

                // Publishers
                _ctaSection(
                  tag: 'For Publishers',
                  title: 'Expand Your Reach',
                  subtitle:
                  'Broaden your audience and increase your visibility and revenue by sharing your content with millions of new readers on the platform',
                  buttonLabel: 'Publish on NewsBreak',
                  onTap: () => Get.to(() => const CreatorPageView(pageKey: 'publish')),
                ),

                // Advertisers
                _ctaSection(
                  tag: 'For Advertisers',
                  title: 'Connect Effectively',
                  subtitle:
                  'Reach more than 40 million users across the U.S. and engage with your target audience at the right moment.',
                  buttonLabel: 'Advertise on NewsBreak',
                  onTap: () => Get.to(() => const CreatorPageView(pageKey: 'advertise')),
                ),

                HelpWidgets.helpFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneImage({bool wide = false}) {
    return Container(
      width: wide ? 200 : 90,
      height: wide ? 130 : 160,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.phone_iphone, color: Colors.grey, size: 40),
    );
  }

  Widget _ctaSection({
    required String tag,
    required String title,
    required String subtitle,
    required String buttonLabel,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HelpWidgets.redChip(tag),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(subtitle,
              style: const TextStyle(
                  color: Colors.black54, fontSize: 13, height: 1.5)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(buttonLabel,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
