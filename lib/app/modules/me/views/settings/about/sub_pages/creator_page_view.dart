import 'package:flutter/material.dart';
import 'help_widgets.dart';

class HelpPageData {
  final String? primaryBtn;
  final String? secondaryBtn;
  final String chip;
  final String heroTitle;

  const HelpPageData({
    this.primaryBtn,
    this.secondaryBtn,
    this.chip = 'Our Mission',
    this.heroTitle = 'Become a NewsBreak creator!\nYour stories. Your spotlight',
  });
}

const Map<String, HelpPageData> _allPages = {
  'careers': HelpPageData(primaryBtn: 'Open positions'),
  'contributor': HelpPageData(primaryBtn: 'Become a Creator', secondaryBtn: 'Open NewsBreak', chip: 'Creator Program'),
  'publish': HelpPageData(primaryBtn: 'Apply to be a Partner', chip: 'Creator Program'),
  'advertise': HelpPageData(primaryBtn: 'Create an Ad', chip: 'Creator Program'),
  'default': HelpPageData(),
};

class CreatorPageView extends StatelessWidget {
  final String pageKey;

  const CreatorPageView({super.key, required this.pageKey});

  @override
  Widget build(BuildContext context) {
    final data = _allPages[pageKey] ?? _allPages['default']!;

    return _buildCreatorPage(
      context: context,
      primaryButtonLabel: data.primaryBtn,
      secondaryButtonLabel: data.secondaryBtn,
      chipLabel: data.chip,
      heroTitle: data.heroTitle,
      primaryOnTap: (){},
      secondaryOnTap: (){},
    );
  }
}

Widget _buildCreatorPage({
  required BuildContext context,
  String? primaryButtonLabel,
  required VoidCallback primaryOnTap,
  String? secondaryButtonLabel,
  VoidCallback? secondaryOnTap,
  required String heroTitle,
  String chipLabel = 'Our Mission',
}) {
  const stats = [
    {'number': '40+', 'label': 'Millions Users', 'desc': 'engage with NewsBreak every month across all touchpoints'},
    {'number': 'NO. 1', 'label': 'Ranked', 'desc': 'engage with NewsBreak every month across all touchpoints'},
    {'number': '1k+', 'label': 'Advertisers', 'desc': 'engage with NewsBreak every month across all touchpoints'},
  ];

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
              // Hero Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(heroTitle,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.3)),
                    const SizedBox(height: 8),
                    const Text(
                      'Share your perspective on local life and turn everyday moments into stories your readers can\'t wait to open. Build a loyal community, deepen your connection, and keep your neighbors informed-on your terms.',
                      style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.5),
                    ),

                    // Primary Button Logic
                    if (primaryButtonLabel != null) ...[
                      const SizedBox(height: 16),
                      _customButton(primaryButtonLabel, primaryOnTap, isPrimary: true),
                    ],

                    // Secondary Button Logic
                    if (secondaryButtonLabel != null) ...[
                      const SizedBox(height: 10),
                      _customButton(secondaryButtonLabel, secondaryOnTap ?? () {}, isPrimary: false),
                    ],
                  ],
                ),
              ),

              // Mission Section
              _buildMissionSection(chipLabel),

              // Stats Section
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text('What NewsBreak brings to you?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              ...stats.map((stat) => _buildStatTile(stat)),

              const SizedBox(height: 8),
              HelpWidgets.helpFooter(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _customButton(String label, VoidCallback onTap, {required bool isPrimary}) {
  return SizedBox(
    width: double.infinity,
    child: isPrimary
        ? ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
    )
        : OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(label, style: const TextStyle(color: Colors.black, fontSize: 14)),
    ),
  );
}

Widget _buildMissionSection(String chipLabel) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HelpWidgets.redChip(chipLabel),
        const SizedBox(height: 8),
        const Text('Calling all writers & video content creators.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text('Share your perspective on local life and turn everyday moments...',
            style: TextStyle(color: Colors.black54, fontSize: 13)),
        const SizedBox(height: 16),
        Center(
          child: Container(
            height: 160, width: 200,
            decoration: BoxDecoration(color: const Color(0xFFEEF4FF), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.person_outline, size: 80, color: Colors.blue),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatTile(Map<String, String> stat) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(stat['number']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        Text(stat['label']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(stat['desc']!, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        const SizedBox(height: 8),
        const Divider(color: Color(0xFFEEEEEE), height: 1),
      ],
    ),
  );
}