import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../../widgets/bottom_sheet_handle.dart';

class OptionsBottomSheet {
  static void show(BuildContext context, {required Widget reportSheet}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF252525),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetHandle(),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF444444),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _optionTile(
                  icon: Icons.thumb_down_outlined,
                  iconColor: Colors.white,
                  title: 'Show less about: Donald Trump',
                  onTap: () => Navigator.pop(context),
                ),
                _optionTile(
                  icon: Icons.thumb_down_outlined,
                  iconColor: Colors.white,
                  title: 'Show less about: Iran',
                  onTap: () => Navigator.pop(context),
                ),
                _optionTile(
                  icon: Icons.block,
                  iconColor: Colors.white,
                  title: 'Block source: The guardian',
                  onTap: () => Navigator.pop(context),
                ),
                _optionTile(
                  icon: Icons.error_outline,
                  iconColor: Colors.red,
                  title: 'Report',
                  titleColor: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      builder: (_) => reportSheet,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF000000),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _optionTile(
              icon: 'assets/icons/add.png',
              iconColor: Colors.blueAccent,
              title: 'Ask/request/report anything',
              onTap: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static Widget _optionTile({
    required dynamic icon,
    required Color iconColor,
    required String title,
    Color titleColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            icon is String
                ? Image.asset(icon, width: 20, height: 20, color: iconColor)
                : Icon(icon as IconData, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(title, style: AppTextStyles.caption.copyWith(color: titleColor)),
          ],
        ),
      ),
    );
  }
}