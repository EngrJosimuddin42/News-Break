import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ── Shared View ────────────────────────
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

  static const List<String> _tabs = [
    'Company',
    'Partners',
    'Solutions',
    'Resources',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          indicatorWeight: 2,
          labelStyle: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          _tabs.length,
              (i) => i == 0 ? _buildContent() : _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Title
        Text(widget.subtitle,
            style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.3)),
        const SizedBox(height: 8),

        // Last updated
        Text(widget.lastUpdated,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 16),

        // Important notice
        Text(widget.importantNotice,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                height: 1.5)),
        const SizedBox(height: 16),

        // Body
        Text(widget.body,
            style: const TextStyle(
                color: Colors.black87, fontSize: 13, height: 1.6)),
      ],
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