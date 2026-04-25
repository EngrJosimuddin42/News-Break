import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../theme/app_colors.dart';

class HomeWeekBar extends GetView<HomeController> {
  const HomeWeekBar({super.key});

  static const List<String> _days = [
    'Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat'
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedDay = controller.selectedDayIndex.value;
      return Container(
        color: AppColors.background,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            // Day names row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_days.length, (i) {
                final bool isSelected = i == selectedDay;
                return GestureDetector(
                  onTap: () => controller.selectDay(i),
                  child: Text(
                    _days[i],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 6),
            // Month & Day
            Text(
              controller.monthAndDay,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Divider(color: Colors.white12, height: 1),
          ],
        ),
      );
    });
  }
}