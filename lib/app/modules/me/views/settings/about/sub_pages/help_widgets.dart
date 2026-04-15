import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/me/views/settings/about/sub_pages/what_we_do_view.dart';
import 'package:news_break/app/modules/me/views/settings/about/sub_pages/who_are_we_view.dart';

import 'blog_view.dart';
import 'creator_page_view.dart';

class HelpWidgets {
  // ── Shared AppBar ────────────────────────────
  static AppBar helpAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600)),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.close, color: Colors.black, size: 20),
          ),
        ),
      ],
    );
  }

// ── Shared Footer ────────────────────────────
  static Widget helpFooter() {
    return Column(
      children: [
        const Divider(height: 1, color: Color(0xFFEEEEEE)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Terms of Use',
                  style: TextStyle(color: Colors.grey, fontSize: 11)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('|',
                    style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
              Text('Privacy Policy',
                  style: TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ),
        const Text('© 2020 Particle Media. All Rights Reserved.',
            style: TextStyle(color: Colors.grey, fontSize: 10)),
        const SizedBox(height: 6),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('English (US)',
                style: TextStyle(color: Colors.grey, fontSize: 11)),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

// ── Red chip ─────────────────────────────────
  static Widget redChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.red, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }
}

// ── Shared Tab Bar with Dropdown ───────────────────────────
class HelpTabBar extends StatefulWidget {
  const HelpTabBar({super.key});

  @override
  State<HelpTabBar> createState() => _HelpTabBarState();
}

class _HelpTabBarState extends State<HelpTabBar> {
  OverlayEntry? _overlayEntry;
  final List<GlobalKey> _tabKeys = List.generate(4, (_) => GlobalKey());

  static const List<String> _tabs = ['Company', 'Partners', 'Solutions', 'Resources'];

  final Map<String, List<String>> _tabItems = {
    'Company': ['What we do', 'Who are we', 'Careers'],
    'Partners': ['Contributors', 'Publishers', 'Advertisers'],
    'Resources': ['Podcast', 'Blog'],
  };

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showDropdown(int tabIndex) {
    _removeOverlay();

    final RenderBox? renderBox = _tabKeys[tabIndex].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final items = _tabItems[_tabs[tabIndex]] ?? [];

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy + renderBox.size.height,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items.map((item) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _removeOverlay();
                            switch (item) {
                              case 'What we do':
                                Get.to(() => const WhatWeDoView());
                                break;
                              case 'Who are we':
                                Get.to(() => const WhoAreWeView());
                                break;
                              case 'Careers':
                                Get.to(() => const CreatorPageView(pageKey: 'careers'));
                                break;
                              case 'Contributors':
                                Get.to(() => const CreatorPageView(pageKey: 'default'));
                                break;
                              case 'Publishers':
                                Get.to(() => const CreatorPageView(pageKey: 'default'));
                                break;
                              case 'Advertisers':
                                Get.to(() => const CreatorPageView(pageKey: 'default'));
                                break;
                              case 'Podcast':
                                Get.to(() => const CreatorPageView(pageKey: 'default'));
                                break;
                              case 'Blog':
                               Get.to(() => const BlogView());
                                break;
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            color: Colors.transparent,
                            child: Text(item, style: const TextStyle(color: Colors.black87, fontSize: 14)),
                          ),
                        ),
                        if (item != items.last) Divider(height: 1, color: Colors.grey.shade200),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 48,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_tabs.length, (i) {
            return GestureDetector(
              key: _tabKeys[i],
              onTap: () => _showDropdown(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(_tabs[i],
                    style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ),
            );
          }),
        ),
      ),
    );
  }
}