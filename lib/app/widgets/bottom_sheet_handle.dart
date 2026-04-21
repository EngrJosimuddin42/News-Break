import 'package:flutter/material.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 5,
          decoration: BoxDecoration(
            color:Color(0xFF444444),
            borderRadius: BorderRadius.circular(20))),
      ],
    );
  }
}