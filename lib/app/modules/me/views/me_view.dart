import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../core/controllers/auth_controller.dart';
import '../../../widgets/premium_banner.dart';
import '../controllers/me_controller.dart';
import 'history_item.dart';
import 'creator_onboard_view.dart';

// ── AppBar
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
          onPressed: () => Get.find<MeController>().onAI(),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () => Get.find<MeController>().onSettings(),
        ),
      ],
    );
  }
}

// ── Body
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

  // ── Logged Out ──────────────────────────────
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
                  child:Text('Log in or sign up',
                    style: AppTextStyles.bodySmall),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Keep your preferences, articles, and topics saved in your NewsBreak account.',
                  style: AppTextStyles.labelSmall.copyWith(color:AppColors.info),
                ),
              ),

              const SizedBox(height: 16),

              // Premium banner
              const PremiumBanner(),

              const SizedBox(height: 16),
              const Divider(color: Colors.white12, height: 1),
              const SizedBox(height: 16),

              // Tabs
              _buildTabBar(context, ['Saved', 'History']),

              Obx(() => _buildLoggedOutTabContent(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoggedOutTabContent(BuildContext context) {
    final tab = controller.selectedTab.value;
    if (tab == 0) {
      // Saved
      return Column(
        children: [
          Obx(() => Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                _chip('All',
                  controller.selectedChipIndex.value == 0,() => controller.updateChip(0),
                ),
                const SizedBox(width: 8),
                _chip('Mini Drama',
                  controller.selectedChipIndex.value == 1,() => controller.updateChip(1),
                ),
              ],
            ),
          )),
          const SizedBox(height: 40),
          Text('No  Saved articles',
             style:AppTextStyles.bodyMedium),
          const SizedBox(height: 8),
          Text("You haven't saved anything. Yet.",
              style:AppTextStyles.overline),
          const SizedBox(height: 40),
        ],
      );
    } else {
      // History
      return Obx(() => controller.hasHistory.value
          ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                const Icon(Icons.visibility_off_outlined,
                    color: Colors.grey, size: 16),
                const SizedBox(width: 6),
                Text('Visible only to you',
                    style:AppTextStyles.labelMedium.copyWith(color: AppColors.info)),
                const Spacer(),
                GestureDetector(
                  onTap: () => controller.onClearAll(context),
                  child:Text('Clear All',
                      style:AppTextStyles.small.copyWith(color:Color(0xFF3498FA))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 16),
          ...controller.historyItems.map((item) => Column(
            key: ValueKey(item['id']),
            children: [
              HistoryItem(
                id: item['id']!,
                title: item['title']!,
                source: item['source']!,
                timeAgo: item['timeAgo']!,
                videoUrl: item['videoUrl']!,
                thumbnailUrl: item['thumbnailUrl']!,
              ),
              const Divider( color: Colors.white12, height: 1),
            ],
          )),
        ],
      )
          : _buildNoHistoryView());
    }
  }

  // ── Logged In ───────────────────────────────
  Widget _buildLoggedIn(BuildContext context) {
    return ListView(
      children: [
        // Profile header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent.withOpacity(0.3),
                ),
                child: const Icon(Icons.person,
                    color: Colors.blueAccent, size: 36),
              ),
              const SizedBox(width: 16),
              // Stats
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statItem('0', 'Subscribed'),
                    _statItem('0', 'Followers'),
                    _statItem('0', 'Following'),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Name + meta
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Malia',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Row(
            children: [
              const Icon(Icons.person_outline,
                  color: Colors.grey, size: 14),
              const SizedBox(width: 4),
              const Text('user since Mar 2026',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(width: 12),
              const Icon(Icons.location_on_outlined,
                  color: Colors.grey, size: 14),
              const SizedBox(width: 4),
              const Text('New York',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),

        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() => Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      Get.to(() => const CreatorOnboardView()),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white38),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                    const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    controller.selectedTab.value == 0 &&
                        controller.tabs[0] == 'Content'
                        ? 'Creator dashboard'
                        : 'Become a creator',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.onCompleteProfile,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white38),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                    const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text('Complete profile',
                      style: TextStyle(
                          color: Colors.white, fontSize: 13)),
                ),
              ),
            ],
          )),
        ),

        const SizedBox(height: 16),

        // Premium banner
        const PremiumBanner(),

        const SizedBox(height: 16),

        // Tabs
        _buildTabBar(context, controller.tabs),

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
        return const Padding(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Text('No Content',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Text("You haven't posted anything. Yet.",
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
        );
      case 'Reactions':
        return const Padding(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Text('No Reactions',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Text(
                "This user hasn't commented on\nor reacted to any articles. Yet.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        );
      case 'Saved':
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Obx(() => Row(
                children: [
                      _chip( 'All',
                           controller.selectedChipIndex.value == 0,() => controller.updateChip(0)
                      ),
                  const SizedBox(width: 8),
                  _chip('Mini Drama',
                      controller.selectedChipIndex.value == 1, () => controller.updateChip(1)
                  ),
                ],
                )),
            ),
            const SizedBox(height: 40),
            const Text('No  Saved articles',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text("You haven't saved anything. Yet.",
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 40),
          ],
        );
      case 'History':
        return Obx(() => controller.hasHistory.value
            ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: [
                  const Icon(Icons.visibility_off_outlined,
                      color: Colors.grey, size: 16),
                  const SizedBox(width: 6),
                  const Text('Visible only to you',
                      style: TextStyle(
                          color: Colors.grey, fontSize: 12)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () =>
                        controller.onClearAll(context),
                    child: const Text('Clear All',
                        style: TextStyle(
                            color: Colors.blue, fontSize: 12)),
                  ),
                ],
              ),
            ),
            ...controller.historyItems.map((item) => Column(
              key: ValueKey(item['id']),
              children: [
                HistoryItem(
                  id: item['id']!,
                  title: item['title']!,
                  source: item['source']!,
                  timeAgo: item['timeAgo']!,
                  videoUrl: item['videoUrl']!,
                  thumbnailUrl: item['thumbnailUrl']!,
                ),
                const Divider(color: Colors.white12, height: 1),
              ],
            )),
          ],
        )
            : _buildNoHistoryView());
      default:
        return const SizedBox();
    }
  }

  Widget _buildTabBar(BuildContext context, List<String> tabs) {
    return Obx(() => Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(tabs.length, (i) {
              final selected = controller.selectedTab.value == i;
              return GestureDetector(
                onTap: () => controller.selectedTab.value = i,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Column(
                    children: [
                      Text(
                        tabs[i],
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 14,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (selected)
                        Container(
                          height: 2,
                          width: 24,
                          color: Colors.white,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        const Divider(color: Colors.white12, height: 1),
        const SizedBox(height: 16),
      ],
    ));
  }

  Widget _chip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : Colors.black,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Text(label,style: AppTextStyles.labelSmall.copyWith(color: isSelected ? AppColors.background: Colors.grey)),
      ),
    );
  }


  Widget _buildNoHistoryView() {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Text('No History',
              style: AppTextStyles.bodyMedium),
          SizedBox(height: 8),
          Text('Nothing yet. Start reading!',
              style:AppTextStyles.overline),
        ],
      ),
    );
  }


  Widget _statItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        Text(label,
            style:
            const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}