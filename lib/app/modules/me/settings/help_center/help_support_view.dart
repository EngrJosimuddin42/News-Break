import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../about/sub_pages/help_widgets.dart';
import 'help_detail_view.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _categories = [
    'Advertising',
    'Publishers',
    'Reading News',
    'Comments and Notification',
    'Account, Profile, and Privacy',
    'Contact Us',
  ];

  static const List<String> _promotedArticles = [
    'How to create an advertiser account',
    'Scale Faster. Reach Higher. Accelerate with Premium Inventory (MSP) this February',
    'Premium Partners (MSP) Overview',
    'Why is the article not loading?',
    'How do I request the removal of an article?',
    'How do I contact News Break?',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          Expanded(
            child:_buildNewsbreakTab()
          ),
        ],
      ),
    );
  }

  // Newsbreak Tab
  Widget _buildNewsbreakTab() {
    return ListView(
      children: [
        // Hero banner
        Stack(
          children: [
           Image.asset('assets/images/banar_bg.png',
             width: double.infinity,
             height: 150,
             fit: BoxFit.cover,),
            Positioned.fill(
              child: Container(color: Colors.black38),
            ),
            Positioned(
              left: 20, right: 20, top: 30,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hi, How Can We Help You?',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.displaySmall.copyWith(fontWeight: FontWeight.w400)),
                  const SizedBox(height: 20),
                  Container(
                    width: 306,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8)),
                    child: TextField(
                      controller: _searchController,
                      style: AppTextStyles.caption.copyWith(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'search issue keywords',
                        hintStyle: AppTextStyles.overline.copyWith(fontSize: 14),
                        prefixIcon: Icon(Icons.search, color:AppColors.textOnDark, size: 22),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Categories
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children:[
              const SizedBox(height: 32),
           ..._categories.map((cat) { bool isClickable = cat == 'Advertising' || cat == 'Publishers';
              return GestureDetector(
                onTap: isClickable
                    ? () => Get.to(() => HelpDetailView(title: cat))
                    : null,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color:AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x40888787),
                        blurRadius: 32,
                        offset: const Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(cat, style:AppTextStyles.caption.copyWith(color: AppColors.linkColor))
                  ),
                ),
              );
            }).toList(),
            ]
          ),
        ),

        const SizedBox(height: 16),

        // Promoted Articles
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text('Promoted Articles',
              style:AppTextStyles.displaySmall.copyWith(color: Colors.black))),

        ..._promotedArticles.map((article) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(article,
                    style:AppTextStyles.overline.copyWith(fontSize: 14)),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
          ],
        )),

        const SizedBox(height: 16),
        HelpWidgets.helpFooter(),
        const SizedBox(height: 24),
      ],
    );
  }
}