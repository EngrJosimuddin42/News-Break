import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../widgets/about_profile_sheet.dart';
import '../premium/widgets/premium_banner.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/me/me_controller.dart';
import 'history_item.dart';

// AppBar
class MeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Image.asset('assets/icons/add.png', width: 22, height: 22),
          onPressed: () => Get.find<MeController>().onAI()),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white,size: 20),
          onPressed: () => Get.find<MeController>().onSettings()),
      ],
    );
  }
}

// Body
class MeBody extends GetView<MeController> {
  const MeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loggedIn = AuthController.to.user.value != null;
      return loggedIn
          ? _buildLoggedIn(context)
          : _buildLoggedOut(context);
    });
  }

  // Logged Out
  Widget _buildLoggedOut(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              // Login button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: ElevatedButton(
                  onPressed: controller.onLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:AppColors.surface,
                    minimumSize: const Size(335, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                  child:Text('Log in or sign up', style: AppTextStyles.bodySmall))),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Keep your preferences, articles, and topics saved in your NewsBreak account.',
                  style: AppTextStyles.labelSmall.copyWith(color:AppColors.info))),

              const SizedBox(height: 20),

              // Premium banner
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                child: PremiumBanner()),

              const SizedBox(height: 16),
              const Divider(color: Colors.white12, height: 1),
              const SizedBox(height: 16),

              // Tabs
              Obx(() => _buildTabBar(context, ['Saved', 'History'])),

              Obx(() => _buildLoggedOutTabContent(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoggedOutTabContent(BuildContext context) {
    final tab = controller.selectedTab.value;
    return tab == 0 ? _buildSharedSavedView() : _buildSharedHistoryView(context);
  }


  //  Logged In
  Widget _buildLoggedIn(BuildContext context) {
    return ListView(
      children: [

        // Profile header
        Padding(
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
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statItem('0', 'Subscribed'),
                    _buildVerticalDivider(),
                    _statItem('0', 'Followers'),
                    _buildVerticalDivider(),
                    _statItem('0', 'Following'),
                  ],
                ),
            ],
          ),
        ),

        SizedBox(height: 16),
        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() => Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.isCreator.value
                      ? controller.onCreatorDashboard
                      : controller.onBecomeCreator,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(160, 50),
                    backgroundColor: Color(0xFF1D1D1D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: Text(
                      controller.isCreator.value
                          ? 'Creator dashboard'
                          : 'Become a creator',
                    style: AppTextStyles.buttonOutline))),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.onCompleteProfile,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(160, 50),
                    backgroundColor: Color(0xFF1D1D1D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                  child:Text('Complete profile', style:AppTextStyles.buttonOutline))),
            ],
          )),
        ),

        const SizedBox(height: 16),

        // Premium banner
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
            child: PremiumBanner()),


        const SizedBox(height: 16),
        const Divider(color: Colors.white12, height: 1),
        const SizedBox(height: 16),
        // Tabs
        Obx(() => _buildTabBar(context, controller.tabs)),

        Obx(() => _buildLoggedInTabContent(context)),
      ],
    );
  }

  Widget _buildLoggedInTabContent(BuildContext context) {
    final tabs = controller.tabs;
    final tab = controller.selectedTab.value;
    final tabName = tab < tabs.length ? tabs[tab] : '';

    switch (tabName) {
      case 'Content':
        return Column(
          children: [
            // Sub chips
            Obx(() => Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  _chip('Reels',
                      controller.selectedChipIndex.value == 0,
                          () => controller.updateChip(0)),
                  const SizedBox(width: 8),
                  _chip('Posts',
                      controller.selectedChipIndex.value == 1,
                          () => controller.updateChip(1)),
                  const SizedBox(width: 8),
                  _chip('Community',
                      controller.selectedChipIndex.value == 2,
                          () => controller.updateChip(2)),
                ],
              ),
            )),

            const SizedBox(height: 40),
            Text('No Post', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 8),
            Text(' You haven`t posted anything.Yet.', style:AppTextStyles.overline ),
            const SizedBox(height: 40),
          ],
        );
      case 'Reactions':
        return Padding(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Text('No Reactions', style:AppTextStyles.bodyMedium),
              SizedBox(height: 8),
              Text("This user hasn't commented on\nor reacted to any articles. Yet.",
                textAlign: TextAlign.center, style:AppTextStyles.overline),
            ],
          ),
        );

      case 'Saved':
        return _buildSharedSavedView();

      case 'History':
        return _buildSharedHistoryView(context);
      default:
        return const SizedBox();
    }
  }

  Widget _buildTabBar(BuildContext context, List<String> tabs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(tabs.length, (i) {
              final selected = controller.selectedTab.value == i;
              return GestureDetector(
                onTap: () => controller.selectedTab.value = i,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tabs[i], style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      if (selected)
                        Container(height: 2, width: 50, color: AppColors.surface),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : Colors.black,
          borderRadius: BorderRadius.circular(60)),
        child: Text(label,style: AppTextStyles.labelSmall.copyWith(color: isSelected ? AppColors.background: Colors.grey))),
    );
  }


  Widget _buildNoHistoryView() {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Text('No History', style: AppTextStyles.bodyMedium),
          SizedBox(height: 8),
          Text('Nothing yet. Start reading!', style:AppTextStyles.overline),
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

  Widget _buildSharedSavedView() {
    return Column(
      children: [
        Obx(() {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                _chip('All',
                  controller.selectedChipIndex.value == 0,
                      () => controller.updateChip(0)),
              ],
            ),
          );
        }),
        const SizedBox(height: 40),
        Text('No Saved articles', style: AppTextStyles.bodyMedium),
        const SizedBox(height: 8),
        Text("You haven't saved anything. Yet.", style: AppTextStyles.overline),
        const SizedBox(height: 40),
      ],
    );
  }


  Widget _buildSharedHistoryView(BuildContext context) {
    return Obx(() => controller.hasHistory.value
        ? Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              const Icon(Icons.visibility_off_outlined,  color: Colors.grey, size: 16),
              const SizedBox(width: 6),
              Text('Visible only to you', style:AppTextStyles.labelMedium.copyWith(color: AppColors.info)),
              const Spacer(),
              GestureDetector(
                onTap: () => controller.onClearAll(context),
                child:Text('Clear All', style:AppTextStyles.small.copyWith(color:Color(0xFF3498FA)))),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(color: Colors.white12, height: 1),
        const SizedBox(height: 16),

        ...controller.historyItems.map((item) => Column(
          key: ValueKey(item.id),
          children: [
            HistoryItem(model: item),
            const Divider(color: Colors.white12, height: 1),
          ],
        )),
      ],
    )
        : _buildNoHistoryView());
  }

}