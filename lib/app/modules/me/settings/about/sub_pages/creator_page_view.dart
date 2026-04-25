import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../../widgets/help_widgets.dart';

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
                        style:AppTextStyles.chart.copyWith(color: Colors.black)),
                    const SizedBox(height: 8),
                    Text('Share your perspective on local life and turn everyday moments into stories your readers can\'t wait to open. Build a loyal community, deepen your connection, and keep your neighbors informed-on your terms.',
                      style:AppTextStyles.overline.copyWith(color: Color(0xFF6C6C6C))),

                    // Primary Button Logic
                    if (primaryButtonLabel != null) ...[
                      const SizedBox(height: 24),
                    Center(child: _customButton(primaryButtonLabel, primaryOnTap, isPrimary: true)),
                    ],

                    // Secondary Button Logic
                    if (secondaryButtonLabel != null) ...[
                      const SizedBox(height: 10),
                    Center(child:_customButton(secondaryButtonLabel, secondaryOnTap ?? () {}, isPrimary: false)),
                    ],
                  ],
                ),
              ),

              // Mission Section
              _buildMissionSection(chipLabel),

              // Stats Section
             Center(child:Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text('What NewsBreak brings to you?',
                    style:AppTextStyles.head))),
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
    width: 335,
    height: 48,
    child: isPrimary
        ? ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.linkColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(68)),
      ),
      child: Text(label, style: AppTextStyles.buttonOutline),
    )
        : OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Color(0xFFEDEDED),
          side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(68)),
      ),
      child: Text(label, style: AppTextStyles.buttonOutline.copyWith(color: AppColors.linkColor)),
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
        Text('Calling all writers & video content creators.',
            style: AppTextStyles.chart.copyWith(color: Colors.black)),
        const SizedBox(height: 8),
        Text('Share your perspective on local life and turn everyday moments into stories your readers can’t wait to open. Build a loyal community, deepen your connection, and keep your neighbors informed-on your terms',
            style:AppTextStyles.overline.copyWith(color: Color(0xFF6C6C6C))),
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: double.infinity,
            height: 180,
            child:Image.asset('assets/images/help_person.png'),
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
        Text(stat['number']!, style:AppTextStyles.headlineLarge.copyWith(color: Colors.black)),
        const SizedBox(height: 4),
        Text(stat['label']!, style: AppTextStyles.label),
        const SizedBox(height: 8),
        const Divider(color: Color(0xFFEDEDED), height: 1),
        const SizedBox(height: 8),
        Text(stat['desc']!, style:AppTextStyles.caption.copyWith(color: Colors.black)),
        const SizedBox(height: 8),
      ],
    ),
  );
}