import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/bottom_sheet_handle.dart';
import '../../controllers/nbot_controller.dart';

class NBotSheet extends GetView<NBotController> {
  const NBotSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NBotController());

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.84,
      decoration: const BoxDecoration(
          color: Color(0xFF252525),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          const BottomSheetHandle(),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Image.asset('assets/images/nbot.png', width: 80, height: 80),
                  const SizedBox(height: 16),
                  Text('NBot: Always Gets You', style: AppTextStyles.bodyMedium),

                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.chatMessages.length,
                    itemBuilder: (context, index) {
                      var chat = controller.chatMessages[index];
                      bool isUser = chat['sender'] == 'user';
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blueGrey[700] : const Color(0xFF383838),
                            borderRadius: BorderRadius.circular(15)),
                          child: Text(chat['message']!, style: const TextStyle(color: Colors.white))));
                    },
                  )),

                  const SizedBox(height: 200),

                  // Suggestions Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('People also ask/request/report', style: AppTextStyles.overline),
                        const SizedBox(height: 16),
                        Obx(() => Wrap( spacing: 14,  runSpacing: 14,
                          children: controller.suggestions.map((s) => GestureDetector(
                            onTap: () => controller.onSuggestionTap(s),
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF383838),
                                    borderRadius: BorderRadius.circular(60)),
                                child: Text(s, style: AppTextStyles.labelMedium.copyWith(fontSize: 11))),
                          )).toList(),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Input bar
          Padding(
            padding: EdgeInsets.only( left: 16, right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      style: AppTextStyles.labelMedium,
                      decoration: const InputDecoration(
                        hintText: 'Ask/Request/Report anything',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none))),
                  Obx(() => GestureDetector(
                    onTap: controller.isResponding.value
                        ? null
                        : () => controller.sendMessage(),
                    child: controller.isResponding.value
                        ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.green))
                        : Image.asset('assets/icons/send.png', width: 32, height: 32))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}