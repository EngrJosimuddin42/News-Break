import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/social_interaction_controller.dart';
import '../../../widgets/about_profile_sheet.dart';

class MeProfileHeader extends StatelessWidget {
  const MeProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(width: 60, height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF8DC0F9)),
              alignment: Alignment.center,
              child: Image.asset('assets/icons/person.png',height: 32,width: 32,fit: BoxFit.contain,color:AppColors.surface)),

          const SizedBox(height: 16),

          // Name + meta
          GestureDetector(
              onTap: () => AboutProfileSheet.show(
                  context,
                  publisherName: AuthController.to.user.value?.name ?? 'User',
                  publisherType: 'User',
                  publisherMeta: AuthController.to.user.value?.publisherMeta ?? 'Joined recently'),
              child: Text( AuthController.to.user.value?.name ?? 'User',
                  style:AppTextStyles.bodyMedium.copyWith(color: Color(0xFFC4C4C4)))),

          const SizedBox(height: 16),

          // Date and Location Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/calender.png',height: 14,width: 14),
              const SizedBox(width: 4),
              Text( AuthController.to.user.value?.publisherMeta ?? 'New User',
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.info)),
              const SizedBox(width: 12),
              Image.asset('assets/icons/location1.png',height: 14,width: 14),
              const SizedBox(width: 4),

              Flexible(
                child: Obx(() {
                  final hasHomeLoc = Get.find<HomeController>().selectedLocation.value != null;
                  return Text(
                    hasHomeLoc
                        ? Get.find<HomeController>().locationTitle
                        : (AuthController.to.user.value?.location ?? 'Choose Your Location'),
                    style: AppTextStyles.overline,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 16),
          // Stats
          Obx(() {
            final socialCtrl = Get.find<SocialInteractionController>();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statItem('0', 'Subscribed'),
                _buildVerticalDivider(),
                _statItem(socialCtrl.followersCount.value.toString(), 'Followers'),
                _buildVerticalDivider(),
                _statItem(socialCtrl.followingCount.value.toString(), 'Following'),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _statItem(String count, String label) {
    return Column(
      children: [
        Text(count, style:AppTextStyles.bodyMedium),
        const SizedBox(height: 2),
        Text(label, style:AppTextStyles.overline.copyWith(color: Color(0xFFA7A7A7))),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container( height: 30,  width: 1,  color: Color(0xFF333333));
  }
}