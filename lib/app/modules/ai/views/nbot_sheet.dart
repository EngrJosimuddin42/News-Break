import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class NBotSheet extends StatefulWidget {
  const NBotSheet({super.key});

  @override
  State<NBotSheet> createState() => _NBotSheetState();
}

class _NBotSheetState extends State<NBotSheet> {
  final TextEditingController _textController = TextEditingController();

  static const List<String> _suggestions = [
    'what legal consequences will the man face next in this case',
    'what legal consequences will',
    'what legal consequences',
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: const BoxDecoration(
        color: Color(0xFF252525),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Center content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/nbot.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 16),
                Text(
                  'NBot: Always Gets You',
                  style: AppTextStyles.bodyMedium),
              ],
            ),
          ),

          // Suggestions
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('People also ask/request/report',
                  style:AppTextStyles.overline,
                ),
                const SizedBox(height: 16),
                Wrap(spacing: 14,runSpacing: 14,
                  children: _suggestions.map((s) => GestureDetector(
                    onTap: () => setState(() => _textController.text = s),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF383838),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Text(s,
                          style: AppTextStyles.labelMedium.copyWith(fontSize: 11)),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          // Input bar
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: AppTextStyles.labelMedium,
                      decoration: const InputDecoration(
                        hintText: 'Ask/Request/Report anything',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset('assets/icons/send.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}