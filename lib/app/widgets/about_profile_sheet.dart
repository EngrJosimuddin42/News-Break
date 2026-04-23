import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../theme/app_text_styles.dart';

class AboutProfileSheet extends StatelessWidget {
  final String publisherName;
  final String publisherType;
  final String publisherMeta;

  const AboutProfileSheet({
    super.key,
    required this.publisherName,
    required this.publisherType,
    required this.publisherMeta,
  });

  static void show(BuildContext context, {
    required String publisherName,
    required String publisherType,
    required String publisherMeta,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      isScrollControlled: true,
      builder: (_) => AboutProfileSheet(
        publisherName: publisherName,
        publisherType: publisherType,
        publisherMeta: publisherMeta),
    );
  }

  static void showFromNews(BuildContext context, NewsModel news) {
    show(context,
      publisherName: news.publisherName,
      publisherType: news.publisherType ?? '',
      publisherMeta: news.publisherMeta);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF333333),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text('About this profile', style: AppTextStyles.headlineMedium, textAlign: TextAlign.center)),
          const SizedBox(height: 24),

          // Publisher Name
          Text(publisherName, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 16),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 16),

          // Publisher Type + Meta
          Row(
            children: [
              Text(publisherType, style: AppTextStyles.caption.copyWith(color: const Color(0xFFC4C4C4))),
              if (publisherType.isNotEmpty && publisherMeta.isNotEmpty)
                Text(' · ', style: AppTextStyles.caption.copyWith(color: const Color(0xFFC4C4C4))),
              Expanded(
                child: Text(publisherMeta, style: AppTextStyles.caption.copyWith(color: const Color(0xFFC4C4C4)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 12),

          RichText(
            text: TextSpan( style: AppTextStyles.overline,
              children: [
                const TextSpan(text: 'All content is required to comply with our '),
                TextSpan(text: 'Community Standards', style: AppTextStyles.overline.copyWith(color: const Color(0xFF56CCF2))),
                const TextSpan(text: '. Please help us keep our community safe by reporting any violations.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}