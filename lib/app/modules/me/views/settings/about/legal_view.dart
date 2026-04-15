import 'package:flutter/material.dart';
import 'package:news_break/app/modules/me/views/settings/about/sub_pages/help_widgets.dart';

enum LegalType { terms, privacy, notice }
const Map<LegalType, Map<String, String>> _legalData = {
  LegalType.terms: {
    'title': 'Terms of Use',
    'subtitle': 'NewsBreak\nTerms of Use',
  },
  LegalType.privacy: {
    'title': 'Privacy Policy',
    'subtitle': 'Privacy Policy',
  },
  LegalType.notice: {
    'title': 'Legal Notice',
    'subtitle': 'Legal Notice',
  },
};

class LegalView extends StatelessWidget {
  final LegalType type;

  const LegalView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final data = _legalData[type]!;
    return SharedView(
      title: data['title']!,
      subtitle: data['subtitle']!,
      lastUpdated: 'Last Updated: October 13, 2025',
      importantNotice: 'IMPORTANT NOTICE: IMPORTANT NOTICE:DISPUTES ABOUT THESE TERMS ARE SUBJECT TO BINDING ARBITRATION AND A WAIVER OF CLASS ACTION RIGHTS AS DETAILED IN THE "MANDATORY ARBITRATION AND CLASS ACTION WAIVER" PROVISIONS BELOW IN SECTION 14.',
      body: 'Lorem ipsum dolor sit amet consectetur. Quis vel scelerisque dignissim nulla urna tellus. Et molestie fusce purus amet in dignissim. Pharetra donec habitasse lectus ultrices lobortis egestas donec non varius. Nisl ornare tellus risus varius arcu. Purus aliquam scelerisque ut quis.'
    );
  }
}

// ── SharedView
class SharedView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelpWidgets.helpAppBar(title),
      body: Column(
          children: [
          const HelpTabBar(),
      const Divider(height: 1, color: Color(0xFFEEEEEE)),

      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(subtitle, style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w700, height: 1.3)),
            const SizedBox(height: 8),
            Text(lastUpdated, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 16),
            Text(importantNotice, style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700, height: 1.5)),
            const SizedBox(height: 16),
            Text(body, style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.6)),
          ],
        ),
      ),
      ],
    ),
    );
  }
}