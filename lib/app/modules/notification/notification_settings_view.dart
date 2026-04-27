import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../controllers/notification/notification_controller.dart';

class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20)),
        title:Text('Notification Settings', style:AppTextStyles.displaySmall),
        centerTitle: true),

        body: Obx(() => ListView(
        children: [

          // Allow Notification
        _buildRoundedBox(
        child:_switchTile('Allow Notification', controller.allowNotification.value,
                (val) => controller.allowNotification.value = val,
            showPadding: false )),

          // Frequency slider
      _buildRoundedBox(
         child:  Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Number of Notification', style: AppTextStyles.large),
                const SizedBox(height: 2),
                Text('Control the frequency of notifications', style: AppTextStyles.overline),
                Slider(
                  value: controller.frequency.value,
                  divisions: 2,
                  onChanged: (val) => controller.frequency.value = val,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey[800]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Low Text
                    Text('Low', style: controller.frequency.value == 0.0
                          ? AppTextStyles.small
                          : AppTextStyles.overline),

                    // Normal Text
                    Text('Normal', style: controller.frequency.value == 0.5
                          ? AppTextStyles.small
                          : AppTextStyles.overline),

                    // High Text
                    Text('High', style: controller.frequency.value == 1.0
                          ? AppTextStyles.small
                          : AppTextStyles.overline),
                  ],
                ),
              ],
            ),
          ),
      ),

     // Sound & Vibration
      _buildRoundedBox(
        child:
          _switchTile('Sound & Vibration', controller.soundVibration.value,
                (val) => controller.soundVibration.value = val,
              showPadding: false)),

          _sectionLabel('Notification Topics'),

          _buildRoundedBox(
           child:_labelWithToggle(
            'Local News',
            'Stay informed of local alerts, weather updates, news stories easily.',
            controller.localNews.value,
                (val) => controller.localNews.value = val,
            showPadding: false)),

           _buildRoundedBox(
            child: _labelWithToggle(
            'Breaking News',
            'Get notified when a major story breaks out',
            controller.breakingNews.value,
                (val) => controller.breakingNews.value = val,
            showPadding: false)),

             _buildRoundedBox(
             child: _labelWithToggle(
            'Recommended Reactions',
            'Reaction notifications from real people, based on your interests.',
            controller.recommendedReactions.value,
                (val) => controller.recommendedReactions.value = val,
              showPadding: false)),

           _buildRoundedBox(
              child: _labelWithToggle(
            'Followed Reactions',
            'Reaction notifications from people you follow.',
            controller.followedReactions.value,
                (val) => controller.followedReactions.value = val,
              showPadding: false)),

             _buildRoundedBox(
              child: _labelWithToggle(
            'For You',
            'Stories based on your interests and topics you follow.',
            controller.forYou.value,
                (val) => controller.forYou.value = val,
              showPadding: false)),

         _buildRoundedBox(
          child:_labelWithToggle(
            'Local Deals and Events',
            'Promotions and upcoming events.',
            controller.localDeals.value,
                (val) => controller.localDeals.value = val,
              showPadding: false)),

          _sectionLabel('Message'),

      _buildRoundedBox(
        child: _labelWithToggle(
            'Comment Replies',
            'Get notified when someone replied to comments you left.',
            controller.commentReplies.value,
                (val) => controller.commentReplies.value = val,
            showPadding: false)),

          _sectionLabel('Other Settings'),

          _buildRoundedBox(
              child: _labelWithToggle(
            'Do Not Disturb',
            'Notifications will be silenced during the selected time.',
            controller.doNotDisturb.value,
                (val) => controller.doNotDisturb.value = val,
              showPadding: false)),

          _buildRoundedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lock Screen Notifications', style: AppTextStyles.large),
                const SizedBox(height: 4),
                 Text('Enable to display latest news stories on lock screen', style: AppTextStyles.overline),
              ],
            ),
          ),

        // Enable/Disable Button Section
           Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Obx(() => Align(
                alignment: Alignment.centerLeft,
                child:OutlinedButton(
                  onPressed: () {
                    controller.toggleLockScreen();
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      side: BorderSide(
                          color: controller.isLockScreenEnabled.value
                              ? Colors.red
                              : AppColors.textGreen),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                  child: Text( controller.isLockScreenEnabled.value ? 'Disable' : 'Enable',
                    style: AppTextStyles.large.copyWith(color: controller.isLockScreenEnabled.value
                            ? Colors.red
                            : AppColors.textGreen)))))),
             ],
            ),
          ),
    );
  }

  Widget _buildRoundedBox({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0XFF26272D), width: 1.2),
      ),
      child: child,
    );
  }

  Widget _switchTile(String label, bool value, ValueChanged<bool> onChanged, {bool showLabel = true, bool showPadding = true}) {
    Widget content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        if (showLabel) Text(label, style: AppTextStyles.large),
        SizedBox(
         height: 24,
          child: Transform.scale(
            scale: 0.7,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.textGreen,
              thumbColor: const WidgetStatePropertyAll(Colors.black),
            ),
          ),
        ),
        ],
    );

    return showPadding ? Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), child: content) : content;
  }


  Widget _labelWithToggle(String title, String subtitle, bool value, ValueChanged<bool> onChanged, {bool showPadding = true}) {    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.large),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.overline.copyWith(color: Colors.grey)),
            ],
          ),
        ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.textGreen,
              thumbColor: const WidgetStatePropertyAll(Colors.black),
            ),
          ),
      ],
    );

    return showPadding ? Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: content) : content;
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(label,
          style: AppTextStyles.button.copyWith(color:AppColors.textOnDark)),
    );
  }
}