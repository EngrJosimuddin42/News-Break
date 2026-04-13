import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../../core/controllers/auth_controller.dart';
import '../../../../../theme/app_colors.dart';
import '../../../controllers/home_controller.dart';
import 'category_news_card.dart';


class LocalTab extends GetView<HomeController> {
  final String message;

  const LocalTab({
    super.key,
    this.message = 'No relevant articles',
  });

  static const List<CategoryNewsItem> _items = [
    CategoryNewsItem(
      publisherName: 'Daily news',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1588681664899-f142ff2dc9b1?w=800',
      videoUrl: 'https://www.youtube.com/watch?v=haqbBspQFS0',
      label: 'New York',
      timeAgo: '19h',
      title: "'The View' Fans Think Whoopi Goldberg Has 'Lost Her Mind' After She Suggests Donald Trump's Iran War Is A Distraction From Nancy Guthrie...",
      reactions: '1.4K',
      likes: '1.4K',
      comments: '4K',
    ),
    CategoryNewsItem(
      publisherName: 'Daily news',
      publisherType: 'Partner publisher',
      followerCount: '833.3K',
      imageUrl: 'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=800',
      videoUrl: 'https://www.youtube.com/watch?v=9bZkp7q19f0',
      label: 'New York',
      timeAgo: '2h',
      title: 'Local TV Coverage: Major Event Unfolds Across the City as Thousands Gather for Historic Moment',
      reactions: '2.1K',
      likes: '3.4K',
      comments: '1.8K',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loggedIn = AuthController.to.user.value != null;
      return loggedIn ? _buildLoggedIn() : _buildLoggedOut();
    });
  }

  // ── Logged out — existing UI ─────────────────
  Widget _buildLoggedOut() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/socket.png',
            width: 130,
            height: 130,
          ),
          const SizedBox(height: 16),
          Text(message,
            style: AppTextStyles.caption.copyWith(color: Color(0xFF9B9B9B)),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: controller.onTryAgain,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(20),
              minimumSize: const Size(90, 50),
              side: const BorderSide(color: AppColors.linkColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60))),
            child: Text('Try Again',
              style: AppTextStyles.caption.copyWith(color: AppColors.linkColor),
            ),
          ),
        ],
      ),
    );
  }

  // ── Logged in — video news cards ─────────────
  Widget _buildLoggedIn() {
    return ListView(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      children: [
        // Weather section
        _buildWeatherSection(),

        // News cards
        ..._items.map((item) => CategoryNewsCard(item: item)),
      ],
    );
  }

  Widget _buildWeatherSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Temperature row
          Row(
            children: [
              Text('44°F', style: AppTextStyles.displaySmall),
              const SizedBox(width: 8),
              Image.asset('assets/icons/weather_cloudy.png'),
              SizedBox(width: 24),
              // Forecast days
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _weatherDays.map((day) => Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        children: [
                          Text(day['day']!,
                              style: AppTextStyles.display.copyWith(color: AppColors.textOnDark)),
                          const SizedBox(height: 4),
                          Image.asset(day['icon']!, width: 20, height: 20),
                          const SizedBox(height: 4),
                          Text(day['temp']!,
                              style: AppTextStyles.display.copyWith(color: AppColors.textOnDark)),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Rain expected button
          GestureDetector(
            onTap: () => _showRainForecast(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF808080)),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icons/weather_storm.png',color: AppColors.textOnDark,height: 20,width: 20),
                  const SizedBox(width: 6),
                  Text('Rain expected',
                      style: AppTextStyles.overline),
                  const SizedBox(width: 6),
                  Icon(Icons.chevron_right, color:AppColors.textOnDark, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const List<Map<String, String>> _weatherDays = [
    {'day': 'Today', 'icon': 'assets/icons/weather_cloudy.png', 'temp': '30°/40°'},
    {'day': '04/11', 'icon': 'assets/icons/weather_sunny.png', 'temp': '30°/40°'},
    {'day': '04/10', 'icon': 'assets/icons/weather_sunny.png', 'temp': '30°/40°'},
    {'day': '04/09', 'icon': 'assets/icons/weather_storm.png', 'temp': '30°/40°'},
    {'day': '04/08', 'icon': 'assets/icons/weather_sunny.png', 'temp': '30°/40°'},
    {'day': '04/07', 'icon': 'assets/icons/weather_sunny.png', 'temp': '30°/40°'},
    {'day': '04/06', 'icon': 'assets/icons/weather_storm.png', 'temp': '30°/40°'},
  ];

  void _showRainForecast() {
    showDialog(
      context: Get.context!,
      builder: (_) =>
          Dialog(
            backgroundColor: const Color(0xFF252525),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 20),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text('Rain Forecast',
                      style: AppTextStyles.button),
                  const SizedBox(height: 6),
                  Text('The probability of precipitation is 71%',
                      style: AppTextStyles.labelMedium),
                  const SizedBox(height: 16),

                  // Chart
                  Container(
                    height: 250,
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 50),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFEBEBEB)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: _RainChartPainter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

class _RainChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final barPaint = Paint() ..color = AppColors.chart;
    final gridPaint = Paint() ..color = AppColors.stroke
      ..strokeWidth = 1;

// Grid lines
    for (int i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      final double currentMargin = (i == 0) ? 30.0 : 10.0;
      final Offset startPoint = Offset(currentMargin, y);
      final Offset endPoint = Offset(size.width - currentMargin, y);
      if (i == 3) {
        canvas.drawLine(startPoint, endPoint, gridPaint);
      } else {
        _drawDashedLine(canvas, startPoint, endPoint, gridPaint);
      }
    }

    // Bars
    final barData = [0.06, 0.02, 0.04, 0.03, 0.08, 0.02, 0.05];
    final double spacing = size.width / (barData.length);
    const barWidth = 18.0;

    for (int i = 0; i < barData.length; i++) {
      final x = (i * spacing) + (spacing / 2) - (barWidth / 2);
      final barHeight = size.height * (barData[i] / 0.08);
      final rect = Rect.fromLTWH(x, size.height - barHeight, barWidth, barHeight);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        barPaint,
      );
    }

    // X-axis Labels (Now, 10PM...)
    final labels = ['Now', '10 PM', '04 AM', '10 AM'];
    final labelStyle = TextStyle(color: Colors.white38, fontSize: 10);
    for (int i = 0; i < labels.length; i++) {
      final xPos = i * (size.width / (labels.length - 1));
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: labelStyle),
        textDirection: TextDirection.ltr)..layout();
      double xOffset = xPos - (tp.width / 2);
      if (i == 0) xOffset = 0;
      if (i == labels.length - 1) xOffset = size.width - tp.width;
      tp.paint(canvas, Offset(xOffset, size.height + 10));
    }


    // Y labels
    final yStyle = AppTextStyles.labelSmall.copyWith(color: const Color(0xFF9291A5));
    final yLabels = {'in': 0.0, '0.07': size.height * (0.08 / 0.08)};
    yLabels.forEach((text, yPos) {
      final tp = TextPainter(
        text: TextSpan(text: text, style: yStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      if (text == 'in') {
        tp.paint(canvas, const Offset(0, -55));
      } else {
        tp.paint(canvas, Offset(0, (size.height - yPos) - (tp.height / 2)));
      }
    });

    // Date label on tallest bar
    final dateLabel = '04/02';
    final dateTp = TextPainter(
      text: TextSpan(
        text: dateLabel,
        style: const TextStyle(color: Colors.white, fontSize: 9)),
      textDirection: TextDirection.ltr)..layout();
    final tallestIndex = 4; // 0.08 value
    final tallestX = tallestIndex * (size.width / barData.length) + barWidth / 2;
    final tallestHeight = size.height * barData[tallestIndex] / 0.08;
    dateTp.paint(canvas, Offset( tallestX + (barWidth / 2) - (dateTp.width / 2),
      size.height - tallestHeight - 14));
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double distance = (end - start).distance;
    double drawn = 0;
    final direction = (end - start) / distance;

    while (drawn < distance) {
      final dashEnd = drawn + dashWidth;
      canvas.drawLine(
        start + direction * drawn,
        start + direction * (dashEnd < distance ? dashEnd : distance),
        paint,
      );
      drawn += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}