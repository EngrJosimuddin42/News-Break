import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../theme/app_colors.dart';

class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  State<NotificationSettingsView> createState() =>
      _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {
  bool _allowNotification = true;
  bool _soundVibration = true;
  bool _localNews = true;
  bool _breakingNews = true;
  bool _recommendedReactions = true;
  bool _followedReactions = true;
  bool _forYou = true;
  bool _localDeals = true;
  bool _commentReplies = true;
  bool _doNotDisturb = true;
  double _frequency = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
        ),
        title:Text('Notification Settings',
        style:AppTextStyles.displaySmall),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _switchTile('Allow Notification', _allowNotification,
                  (val) => setState(() => _allowNotification = val)),

          // Frequency slider
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Number of Notification',
                     style: AppTextStyles.large),
                const SizedBox(height: 2),
                Text('Control the frequency of notifications',
                    style: AppTextStyles.overline),
                Slider(
                  value: _frequency,
                  divisions: 2,
                  onChanged: (val) {
                    setState(() {
                      _frequency = val;
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey[800],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Low Text
                    Text('Low',
                      style: _frequency == 0.0
                          ? AppTextStyles.small
                          : AppTextStyles.overline),

                    // Normal Text
                    Text('Normal',
                      style: _frequency == 0.5
                          ? AppTextStyles.small
                          : AppTextStyles.overline),

                    // High Text
                    Text('High',
                      style: _frequency == 1.0
                          ? AppTextStyles.small
                          : AppTextStyles.overline),
                  ],
                ),
              ],
            ),
          ),

          _switchTile('Sound & Vibration', _soundVibration,
                  (val) => setState(() => _soundVibration = val)),

          _sectionLabel('Notification Topics'),

          _labelWithToggle(
            'Local News',
            'Stay informed of local alerts, weather updates, news stories easily.',
            _localNews,
                (val) => setState(() => _localNews = val),
          ),

          _labelWithToggle(
            'Breaking News',
            'Get notified when a major story breaks out',
            _breakingNews,
                (val) => setState(() => _breakingNews = val),
          ),

          _labelWithToggle(
            'Recommended Reactions',
            'Reaction notifications from real people, based on your interests.',
            _recommendedReactions,
                (val) => setState(() => _recommendedReactions = val),
          ),

          _labelWithToggle(
            'Followed Reactions',
            'Reaction notifications from people you follow.',
            _followedReactions,
                (val) => setState(() => _followedReactions = val),
          ),

          _labelWithToggle(
            'For You',
            'Stories based on your interests and topics you follow.',
            _forYou,
                (val) => setState(() => _forYou = val),
          ),

          _labelWithToggle(
            'Local Deals and Events',
            'Promotions and upcoming events.',
            _localDeals,
                (val) => setState(() => _localDeals = val),
          ),

          _sectionLabel('Message'),

          _labelWithToggle(
            'Comment Replies',
            'Get notified when someone replied to comments you left.',
            _commentReplies,
                (val) => setState(() => _commentReplies = val),
          ),

          _sectionLabel('Other Settings'),

          _labelWithToggle(
            'Do Not Disturb',
            'Notifications will be silenced during the selected time.',
            _doNotDisturb,
                (val) => setState(() => _doNotDisturb = val),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lock Screen Notifications',
                    style: AppTextStyles.large),
                const SizedBox(height: 2),
                 Text('Enable to display latest news stories on lock screen',
                  style: AppTextStyles.overline),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    side: BorderSide(color:AppColors.textGreen),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                  child: Text('Enable',
                      style: AppTextStyles.large.copyWith(color: AppColors.textGreen)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _switchTile(String label, bool value, ValueChanged<bool> onChanged,
      {bool showLabel = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showLabel) Text(label, style: AppTextStyles.large),
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
      ),
    );
  }

  Widget _labelWithToggle(
      String title,
      String subtitle,
      bool value,
      ValueChanged<bool> onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.large),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: AppTextStyles.overline),
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
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(label,
          style: AppTextStyles.button.copyWith(color:AppColors.textOnDark)),
    );
  }
}