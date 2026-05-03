import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/modules/notification/notification_item_card.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/social_interaction_controller.dart';
import '../../models/news_model.dart';
import '../../models/user_model.dart';
import '../premium/widgets/premium_banner.dart';
import '../../controllers/notification/notification_controller.dart';
import 'notification_settings_view.dart';

// AppBar
class NotificationAppBar extends GetView<NotificationController>
    implements PreferredSizeWidget {
  const NotificationAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text('Notifications', style: AppTextStyles.displaySmall),
      centerTitle: true,
      actions: [
        IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () => Get.to(() => const NotificationSettingsView())),
      ],
      bottom: TabBar(
          controller: controller.tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          indicatorColor: Colors.white,
          indicatorWeight: 2,
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: AppTextStyles.caption,
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          tabs: NotificationController.tabs.map((t) => Tab(text: t)).toList()),
    );
  }
}

// Body
class NotificationBody extends GetView<NotificationController> {
  const NotificationBody({super.key});

  List<NewsModel> _filteredItems() {
    final socialCtrl = Get.find<SocialInteractionController>();
    return controller.newsItems.where((news) {
      if (socialCtrl.blockedSources.contains(news.publisherName)) return false;
      if (socialCtrl.blockedTopics.contains(news.category)) return false;
      if (socialCtrl.blockedAuthors.contains(news.author)) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller.tabController,
      children: [
        _buildNewsTab(),
        _buildEmptyTab(),
        _buildEmptyTab(),
        _buildFollowsTab(),
        _buildEmptyTab(),
      ],
    );
  }

  Widget _buildFollowsTab() {
    return Obx(() {
      if (controller.followItems.isEmpty) return _buildEmptyTab();
      return ListView.separated(
        itemCount: controller.followItems.length,
        separatorBuilder: (context, index) =>
        const Divider(color: Colors.white12, height: 1),
        itemBuilder: (context, index) {
          final user = controller.followItems[index];
          return FollowNotificationItem(user: user);
        },
      );
    });
  }

  Widget _buildNewsTab() {
    final socialCtrl = Get.find<SocialInteractionController>();

    return Obx(() {
      socialCtrl.blockedSources.length;
      socialCtrl.blockedTopics.length;
      socialCtrl.blockedAuthors.length;

      final items = _filteredItems();

      if (items.isEmpty) return _buildEmptyTab();

      return ListView(
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: PremiumBanner(),
          ),
          const SizedBox(height: 16),

          if (items.isNotEmpty) ...[
            _sectionLabel('Today'),
            ...items.take(2).map((model) => Column(
              children: [
                NotificationItemCard(item: model),
                const Divider(color: Colors.white12, height: 1),
              ],
            )),
          ],

          if (items.length > 2) ...[
            _sectionLabel('Earlier'),
            ...items.skip(2).map((model) => Column(
              children: [
                NotificationItemCard(item: model),
                const Divider(color: Colors.white12, height: 1),
              ],
            )),
          ],
        ],
      );
    });
  }

  Widget _buildEmptyTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/message.png',
              width: 90, height: 90, fit: BoxFit.contain),
          const SizedBox(height: 16),
          Text('No messages yet', style: AppTextStyles.overline),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Color(0xFF212121)),
      child: Text(label, style: AppTextStyles.textSmall),
    );
  }
}

// Follow Notification Item
class FollowNotificationItem extends StatelessWidget {
  final UserModel user;
  const FollowNotificationItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: user.isHighlighted ? const Color(0xFF2C3C53) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[800],
              backgroundImage:
              (user.profileImageUrl != null && user.profileImageUrl!.isNotEmpty)
                  ? NetworkImage(user.profileImageUrl!)
                  : null,
              child: (user.profileImageUrl == null || user.profileImageUrl!.isEmpty)
                  ? Image.asset('assets/images/publisher.png')
                  : null),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: AppTextStyles.caption),
                const SizedBox(height: 2),
                Text('Started following you',
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.light)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset('assets/icons/location1.png'),
                    const SizedBox(width: 3),
                    Flexible(
                        flex: 2,
                        child: Text(user.publisherMeta ?? '',
                            style: AppTextStyles.labelSmall
                                .copyWith(color: AppColors.light),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1)),
                    const SizedBox(width: 12),
                    Image.asset('assets/icons/time.png'),
                    const SizedBox(width: 3),
                    Flexible(
                        flex: 2,
                        child: Text(user.formattedTime,
                            style: AppTextStyles.labelSmall
                                .copyWith(color: AppColors.light),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}