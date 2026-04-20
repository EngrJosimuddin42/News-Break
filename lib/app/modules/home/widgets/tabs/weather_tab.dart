import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../category_news_card.dart';

class WeatherTab extends GetView<HomeController> {
  const WeatherTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loggedIn = AuthController.to.user.value != null;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return loggedIn ? _buildLoggedIn() : _buildLoggedOut();
    });
  }

  Widget _buildLoggedOut() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      itemCount: controller.weatherNews.length,
      itemBuilder: (context, index) =>
          CategoryNewsCard(news: controller.weatherNews[index]),
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

        ...controller.weatherNews.map((news) => CategoryNewsCard(news: news)),
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
          Obx(() => Row(
            children: [
              _toggleChip('Hourly', controller.isHourly.value),
              const SizedBox(width: 8),
              _toggleChip('Daily', !controller.isHourly.value),
            ],
          )),

          const SizedBox(height: 12),

          // Forecast scroll
          Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: (controller.isHourly.value
                  ? controller.hourlyForecast
                  : controller.dailyForecast)
                  .map((item) => _forecastItem(item))
                  .toList(),
            ),
          )),
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
      onTap: () => controller.isHourly.value = (label == 'Hourly'),
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