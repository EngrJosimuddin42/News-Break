import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../../core/controllers/auth_controller.dart';
import 'category_news_card.dart';

class WeatherTab extends StatefulWidget {
  const WeatherTab({super.key});

  @override
  State<WeatherTab> createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  bool _isHourly = true;

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'shefinds',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1601297183305-6df142704ea2?w=800',
      label: 'OPINION',
      timeAgo: '19h',
      title:
      "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    CategoryNewsItem(
      publisherName: 'Weather Channel',
      publisherType: 'Partner publisher',
      followerCount: '3.2M',
      imageUrl: 'https://images.unsplash.com/photo-1561484930-998b6a7b22e8?w=800',
      label: 'FORECAST',
      timeAgo: '4h',
      title:
      'El Niño Pattern Expected to Bring Above-Average Temperatures to Much of the Country Through Summer',
      reactions: '2.3K',
      likes: '3.9K',
      comments: '1.4K',
    ),
    CategoryNewsItem(
      publisherName: 'AccuWeather',
      publisherType: 'Partner publisher',
      followerCount: '1.5M',
      imageUrl: 'https://images.unsplash.com/photo-1530908295418-a12e326966ba?w=800',
      label: 'CLIMATE',
      timeAgo: '8h',
      title:
      'Record-Breaking Heat Wave Sweeps Across Southern States — Tips for Staying Cool and Healthy During Extreme Temperatures',
      reactions: '4.7K',
      likes: '6.8K',
      comments: '3.2K',
    ),
  ];

  static const List<Map<String, String>> _hourlyForecast = [
    {'time': 'Now', 'icon': 'assets/icons/weather_cloudy.png', 'temp': '30°'},
    {'time': '03AM', 'icon': 'assets/icons/weather_night.png', 'temp': '30°'},
    {'time': '04AM', 'icon': 'assets/icons/weather_night.png', 'temp': '30°'},
    {'time': '05AM', 'icon': 'assets/icons/weather_cloudy.png', 'temp': '30°'},
    {'time': '06AM', 'icon': 'assets/icons/weather_storm.png', 'temp': '30°'},
  ];

  static const List<Map<String, String>> _dailyForecast = [
    {'time': 'Today', 'icon': 'assets/icons/weather_cloudy.png', 'temp': '30°/40°'},
    {'time': 'Mon', 'icon': 'assets/icons/weather_sunny.png', 'temp': '28°/38°'},
    {'time': 'Tue', 'icon': 'assets/icons/sunrise.png', 'temp': '25°/35°'},
    {'time': 'Wed', 'icon': 'assets/icons/weather_storm.png', 'temp': '22°/32°'},
    {'time': 'Thu', 'icon': 'assets/icons/weather_sunny.png', 'temp': '27°/37°'},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loggedIn = AuthController.to.user.value != null;
      return loggedIn ? _buildLoggedIn() : _buildLoggedOut();
    });
  }

  Widget _buildLoggedOut() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      itemCount: _items.length,
      itemBuilder: (context, index) => CategoryNewsCard(item: _items[index]),
    );
  }

  Widget _buildLoggedIn() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        _buildWeatherWidget(),

        const SizedBox(height: 16),
        const Divider(color: Colors.white12, height: 6),
        const SizedBox(height: 16),


        ..._items.map((item) => CategoryNewsCard(item: item)),
      ],
    );
  }

  Widget _buildWeatherWidget() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Temperature + icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('44°',
                          style: AppTextStyles.tagline),
                      const SizedBox(width: 6),
                      Image.asset(
                        'assets/icons/weather_cloudy.png',
                        width: 48,
                        height: 48,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '30°/40°',
                          style: AppTextStyles.overline),
                        TextSpan(text: '  Cloudy',
                          style: AppTextStyles.small.copyWith(color: Color(0xFFC4C4C4)))
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Activities
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _activityItem(
                'assets/icons/emoji.png',
                'assets/icons/mountain.png',
                'Hiking',
              ),
              const SizedBox(width: 16),
              _activityItem(
                'assets/icons/emoji.png',      // topIconPath
                'assets/icons/leaves.png',   // bottomIconPath
                'Gardening',                    // label
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: Colors.white12, height: 6),
          const SizedBox(height: 16),

          // Forecasts header
          Row(
            children: [
              Text('Forecasts',
                  style: AppTextStyles.bodyMedium),
              const Spacer(),
              Image.asset('assets/icons/sunrise.png'),
              const SizedBox(width: 6),
              Text('4:48 PM',
                  style:AppTextStyles.display.copyWith(color: Color(0xFFC4C4C4))),
              const SizedBox(width: 24),
              Image.asset('assets/icons/sunset.png'),
              const SizedBox(width: 6),
              Text('5:48 AM',
                  style:AppTextStyles.display.copyWith(color: Color(0xFFC4C4C4)))
            ],
          ),

          const SizedBox(height: 12),

          // Hourly / Daily toggle
          Row(
            children: [
              _toggleChip('Hourly', _isHourly),
              const SizedBox(width: 8),
              _toggleChip('Daily', !_isHourly),
            ],
          ),

          const SizedBox(height: 12),

          // Forecast scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: (_isHourly ? _hourlyForecast : _dailyForecast)
                  .map((item) => _forecastItem(item))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }


  Widget _activityItem(String topIcon, String bottomIcon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF4C4C4C), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                topIcon,
                width: 24,
                height: 24,
              ),
              Image.asset(
                bottomIcon,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        Text(label,
          style:AppTextStyles.overline
        ),
      ],
    );
  }

  Widget _toggleChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _isHourly = label == 'Hourly'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ?AppColors.surface: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
              color: isSelected ?AppColors.background: AppColors.surface,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }

  Widget _forecastItem(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        border: Border.all(color: Color(0xFF333333)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(item['time']!,
              style: AppTextStyles.display.copyWith(color: AppColors.textOnDark)),
          const SizedBox(height: 6),
          Image.asset(item['icon']!, width: 24, height: 24),
          const SizedBox(height: 6),
          Text(item['temp']!,
              style:AppTextStyles.display),
        ],
      ),
    );
  }
}