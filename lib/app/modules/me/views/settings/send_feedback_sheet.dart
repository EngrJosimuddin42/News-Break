import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendFeedbackSheet extends StatefulWidget {
  const SendFeedbackSheet({super.key});

  @override
  State<SendFeedbackSheet> createState() => _SendFeedbackSheetState();
}

class _SendFeedbackSheetState extends State<SendFeedbackSheet> {
  final TextEditingController _feedbackController = TextEditingController();
  int _rating = 3;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Center(
            child: Text(
              'Share your feedback',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Star rating
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      i < _rating ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: 32,
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 16),

          // Label
          const Text('Write your feedback',
              style: TextStyle(color: Colors.black87, fontSize: 13)),
          const SizedBox(height: 8),

          // Text area
          Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _feedbackController,
              maxLines: null,
              expands: true,
              style: const TextStyle(color: Colors.black, fontSize: 13),
              decoration: const InputDecoration(
                hintText: 'Write your feedback here...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Send button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Get.snackbar('Thank you!', 'Your feedback has been sent.',
                    backgroundColor: Colors.green,
                    colorText: Colors.white);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE57373),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Send Feedback',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}