import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../widgets/help_widgets.dart';

class HelpDetailView extends StatelessWidget {
  final String title;
  const HelpDetailView({super.key, required this.title});

  static const List<Map<String, String>> _sections = [
    {
      'title': 'How to get started',
      'body': 'Lorem ipsum dolor sit amet consectetur. Nulla mauris etiam risus at congue. Cursus odio nunc quis congue magna integer enim fringilla.',
    },
    {
      'title': 'Creating a profile',
      'body': 'Lorem ipsum dolor sit amet consectetur. Nulla mauris etiam risus at congue. Cursus odio nunc quis congue magna integer enim fringilla.',
    },
    {
      'title': 'Troubleshooting',
      'body': 'Lorem ipsum dolor sit amet consectetur. Nulla mauris etiam risus at congue. Cursus odio nunc quis congue magna integer enim fringilla.',
    },
    {
      'title': 'App Campaigns',
      'body': 'Lorem ipsum dolor sit amet consectetur. Nulla mauris etiam risus at congue. Cursus odio nunc quis congue magna integer enim fringilla.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.surface,
      appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child:Icon(Icons.arrow_back_ios,color:AppColors.textOnDark, size: 20),
          ),
          title: Text('Help & Support',
              style: AppTextStyles.displaySmall),
          centerTitle: true),
      body: Column(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: AppColors.surface),
            child: Row(
              children: [
                Image.asset('assets/images/newsbreak_logo.png', width: 30, height: 30),
                const SizedBox(width: 8),
                Text('Newsbreak',
                    style: AppTextStyles.medium),
                const SizedBox(width: 30),
                Text('Help Center',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.background)),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: ListView(
              children: [
                // Breadcrumb
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      Text('NewsBreak Help Center',
                          style: AppTextStyles.caption.copyWith(color: AppColors.linkColor)),
                      Text(' > $title',
                          style:AppTextStyles.caption.copyWith(color: AppColors.textOnDark)),
                    ],
                  ),
                ),

                // Search
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFFDDDDDD)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:TextField(
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle:AppTextStyles.caption.copyWith(color: AppColors.textOnDark),
                        prefixIcon: Icon(Icons.search, color: AppColors.textOnDark, size: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(title,
                      style: AppTextStyles.tagline.copyWith(color: Colors.black)),
                ),

                // Sections
                ..._sections.map((section) => Padding(
                  padding:
                  const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(section['title']!,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 16)),
                      const SizedBox(height: 6),
                      Text(section['body']!,
                          style: AppTextStyles.large.copyWith(color: Color(0xFF6C6C6C))),
                    ],
                  ),
                )),

                const SizedBox(height: 120),
                HelpWidgets.helpFooter(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}