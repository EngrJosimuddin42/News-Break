import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final dynamic user;
  final String postCount;
  final String followerCount;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.postCount,
    required this.followerCount,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 30,
              backgroundImage:
              NetworkImage(user?.userProfileImage ?? ""),
              backgroundColor: Colors.grey[800]),
          const SizedBox(height: 16),
          Text(user?.userName ?? "Unknown",
              style: AppTextStyles.bodySmall
                  .copyWith(color: const Color(0xFFEAEAEA))),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/calender.png',
                  height: 14, width: 14),
              const SizedBox(width: 4),
              Text('user since ${user?.userSince ?? "Unknown"}',
                  style: AppTextStyles.overline
                      .copyWith(color: AppColors.info)),
              const SizedBox(width: 12),
              Image.asset('assets/icons/location1.png',
                  height: 14, width: 14),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                    user?.location ?? "Unknown Location",
                    style: AppTextStyles.overline,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statItem(postCount.toString(), 'Post'),
              _buildVerticalDivider(),
              _statItem(
                  user?.totalViews?.toString() ?? '0',
                  'Views'),
              _buildVerticalDivider(),
              _statItem(followerCount, 'Followers'),
            ],
          ),
        ],
      ),
    );
  }

  // Helper Widget for Stats
  Widget _statItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: AppTextStyles.bodyMedium),
        Text(label, style: AppTextStyles.overline),
      ],
    );
  }

  // Helper Widget for Divider
  Widget _buildVerticalDivider() {
    return Container(height: 30, width: 1, color: const Color(0xFF333333));
  }
}