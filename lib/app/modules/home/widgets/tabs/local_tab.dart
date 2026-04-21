import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../theme/app_colors.dart';
import '../ad_video_card.dart';
import '../category_news_card.dart';

class LocalTab extends GetView<HomeController> {
  final String message;

  const LocalTab({
    super.key,
    this.message = 'No relevant articles',
  });

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

  // Logged out
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

  // Logged in video news cards
  Widget _buildLoggedIn() {
    return ListView(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      children: [
        // Weather section
        _buildWeatherSection(),

        // News cards
        ...controller.localNews.map((news) {
          if (news.publisherType == 'Ad') {
            return AdVideoCard(news: news);
          }
          return CategoryNewsCard(news: news);
        }),
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
             Obx(() => Text(controller.currentTemp.value, style: AppTextStyles.displaySmall)),
              const SizedBox(width: 8),
              Image.asset('assets/icons/weather_cloudy.png'),
              SizedBox(width: 24),
              // Forecast days
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.weatherDays.map((data) => Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        children: [
                          Text(data['day']!,
                              style: AppTextStyles.display.copyWith(color: AppColors.textOnDark)),
                          const SizedBox(height: 4),
                          Image.asset(data['icon']!, width: 20, height: 20),
                          const SizedBox(height: 4),
                          Text(data['temp']!,
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
                  Obx(() => Text(
                    '${controller.weatherCondition.value} expected',
                    style: AppTextStyles.overline)),
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
                  Obx(() => Text('The probability of precipitation is ${controller.rainProbability.value}',
                    style: AppTextStyles.labelMedium)),
                  const SizedBox(height: 16),

                  // Chart
                  Container(
                    height: 250,
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 50),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFEBEBEB)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Obx(() => CustomPaint(
                      size: Size.infinite,
                      painter: _RainChartPainter(data: controller.rainBarData),
                    )),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

class _RainChartPainter extends CustomPainter {
  final List<double> data;

  _RainChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final barPaint = Paint()
      ..color = AppColors.chart;
    final gridPaint = Paint()
      ..color = AppColors.stroke
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
    final double spacing = size.width / (data.length);
    const barWidth = 18.0;

    for (int i = 0; i < data.length; i++) {
      final x = (i * spacing) + (spacing / 2) - (barWidth / 2);
      final barHeight = size.height * (data[i] / 0.08);
      final rect = Rect.fromLTWH(
          x, size.height - barHeight, barWidth, barHeight);
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
          textDirection: TextDirection.ltr)
        ..layout();
      double xOffset = xPos - (tp.width / 2);
      if (i == 0) xOffset = 0;
      if (i == labels.length - 1) xOffset = size.width - tp.width;
      tp.paint(canvas, Offset(xOffset, size.height + 10));
    }


    // Y labels
    final yStyle = AppTextStyles.labelSmall.copyWith(
        color: const Color(0xFF9291A5));
    final yLabels = {'in': 0.0, '0.07': size.height * (0.08 / 0.08)};
    yLabels.forEach((text, yPos) {
      final tp = TextPainter(
        text: TextSpan(text: text, style: yStyle),
        textDirection: TextDirection.ltr,
      )
        ..layout();

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
        textDirection: TextDirection.ltr)
      ..layout();
    final tallestIndex = 4; // 0.08 value
    final tallestX = tallestIndex * (size.width / data.length) + barWidth / 2;
    final tallestHeight = size.height * data[tallestIndex] / 0.08;
    dateTp.paint(canvas, Offset(tallestX + (barWidth / 2) - (dateTp.width / 2),
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
  bool shouldRepaint(covariant _RainChartPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}