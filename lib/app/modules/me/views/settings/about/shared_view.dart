import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ── Tab items data ───────────────────────────
const Map<String, List<String>> _tabItems = {
  'Company': ['What we do', 'Who are we', 'Careers'],
  'Partners': ['Contributors', 'Publishers', 'Advertisers'],
  'Solutions': ['For News', 'For Brands', 'For Publishers'],
  'Resources': ['Podcast', 'Blog'],
};

class SharedView extends StatefulWidget {
  final String title;
  final String subtitle;
  final String lastUpdated;
  final String importantNotice;
  final String body;

  const SharedView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.lastUpdated,
    required this.importantNotice,
    required this.body,
  });

  @override
  State<SharedView> createState() => _SharedViewState();
}

class _SharedViewState extends State<SharedView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  OverlayEntry? _overlayEntry;
  final List<GlobalKey> _tabKeys = List.generate(4, (_) => GlobalKey());

  static const List<String> _tabs = [
    'Company', 'Partners', 'Solutions', 'Resources',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _removeOverlay();
    _tabController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showDropdown(int tabIndex) {
    _removeOverlay();

    final RenderBox? renderBox =
    _tabKeys[tabIndex].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final items = _tabItems[_tabs[tabIndex]] ?? [];

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          // Dismiss area
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
          ),
          // Dropdown
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
                            Get.to(() => LegalSubPageView(title: item));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: Text(item,
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 14)),
                          ),
                        ),
                        if (item != items.last)
                          Divider(
                              height: 1, color: Colors.grey.shade200),
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.black, size: 18),
        ),
        title: Text(widget.title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            children: List.generate(_tabs.length, (i) {
              return GestureDetector(
                key: _tabKeys[i],
                onTap: () => _showDropdown(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Text(_tabs[i],
                      style: const TextStyle(
                          color: Colors.black, fontSize: 13)),
                ),
              );
            }),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _removeOverlay,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(widget.subtitle,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.3)),
            const SizedBox(height: 8),
            Text(widget.lastUpdated,
                style:
                const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 16),
            Text(widget.importantNotice,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1.5)),
            const SizedBox(height: 16),
            Text(widget.body,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    height: 1.6)),
          ],
        ),
      ),
    );
  }
}

// ── Sub page ─────────────────────────────────
class LegalSubPageView extends StatelessWidget {
  final String title;
  const LegalSubPageView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.black, size: 18),
        ),
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          const Text(
            'Lorem ipsum dolor sit amet consectetur. Quis vel scelerisque dignissim nulla urna tellus. Et molestie fusce purus amet in dignissim. Pharetra donec habitasse lectus ultrices lobortis egestas donec non varius. Nisl ornare tellus risus varius arcu. Purus aliquam scelerisque ut quis.',
            style: TextStyle(
                color: Colors.black87, fontSize: 13, height: 1.6),
          ),
        ],
      ),
    );
  }
}

// ── Terms of Use ─────────────────────────────
class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({super.key});
  @override
  Widget build(BuildContext context) {
    return const SharedView(
      title: 'Terms of Use',
      subtitle: 'NewsBreak\nTerms of Use',
      lastUpdated: 'Last Updated: october 13, 2025',
      importantNotice:
      'IMPORTANT NOTICE:\nDISPUTES ABOUT THESE TERMS ARE SUBJECT TO BINDING ARBITRATION AND A WAIVER OF CLASS ACTION RIGHTS AS DETAILED IN THE "MANDATORY ARBITRATION AND CLASS ACTION WAIVER" PROVISIONS BELOW IN SECTION 14.',
      body:
      'Lorem ipsum dolor sit amet consectetur. Quis vel scelerisque dignissim nulla urna tellus. Et molestie fusce purus amet in dignissim. Pharetra donec habitasse lectus ultrices lobortis egestas donec non varius. Nisl ornare tellus risus varius arcu. Purus aliquam scelerisque ut quis.',
    );
  }
}

// ── Privacy Policy ───────────────────────────
class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) {
    return const SharedView(
      title: 'Privacy Policy',
      subtitle: 'Privacy Policy',
      lastUpdated: 'Last Updated: october 13, 2025',
      importantNotice:
      'IMPORTANT NOTICE:\nDISPUTES ABOUT THESE TERMS ARE SUBJECT TO BINDING ARBITRATION AND A WAIVER OF CLASS ACTION RIGHTS AS DETAILED IN THE "MANDATORY ARBITRATION AND CLASS ACTION WAIVER" PROVISIONS BELOW IN SECTION 14.',
      body:
      'Lorem ipsum dolor sit amet consectetur. Quis vel scelerisque dignissim nulla urna tellus. Et molestie fusce purus amet in dignissim. Pharetra donec habitasse lectus ultrices lobortis egestas donec non varius. Nisl ornare tellus risus varius arcu. Purus aliquam scelerisque ut quis.',
    );
  }
}

// ── Legal Notice ─────────────────────────────
class LegalNoticeView extends StatelessWidget {
  const LegalNoticeView({super.key});
  @override
  Widget build(BuildContext context) {
    return const SharedView(
      title: 'Legal Notice',
      subtitle: 'Legal Notice',
      lastUpdated: 'Last Updated: october 13, 2025',
      importantNotice:
      'IMPORTANT NOTICE:\nDISPUTES ABOUT THESE TERMS ARE SUBJECT TO BINDING ARBITRATION AND A WAIVER OF CLASS ACTION RIGHTS AS DETAILED IN THE "MANDATORY ARBITRATION AND CLASS ACTION WAIVER" PROVISIONS BELOW IN SECTION 14.',
      body:
      'Lorem ipsum dolor sit amet consectetur. Quis vel scelerisque dignissim nulla urna tellus. Et molestie fusce purus amet in dignissim. Pharetra donec habitasse lectus ultrices lobortis egestas donec non varius. Nisl ornare tellus risus varius arcu. Purus aliquam scelerisque ut quis.',
    );
  }
}