import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/me/me_controller.dart';

class CreatorDashboardView extends StatefulWidget {
  const CreatorDashboardView({super.key});

  @override
  State<CreatorDashboardView> createState() => _CreatorDashboardViewState();
}

class _CreatorDashboardViewState extends State<CreatorDashboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final controller = Get.find<MeController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      controller.selectedDashboardTab.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:Icon(Icons.arrow_back_ios,color:AppColors.textOnDark, size: 20)),
         title: Text('Creator Dashboard',
          style: AppTextStyles.displaySmall),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: ColoredBox(
              color: Colors.white,
              child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.grey,
          indicatorWeight: 2,
          labelStyle: AppTextStyles.bodySmall,
          unselectedLabelStyle:AppTextStyles.caption.copyWith(color:AppColors.background),
          tabs: const [Tab(text: 'Engagement'), Tab(text: 'Followers')])))),

      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEngagementTab(),
          _buildFollowersTab(),
        ],
      ),
    );
  }

  // Engagement Tab
  Widget _buildEngagementTab() {
    return Obx(() {
      final selectedStat = controller.engagementStats.firstWhere(
            (element) => element['isSelected'] == true,
        orElse: () => controller.engagementStats[0]);
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDateRow(),
          const SizedBox(height: 16),
          Row(
            children: controller.engagementStats.asMap().entries.map((entry) {
              int idx = entry.key;
              var stat = entry.value;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: idx == controller.engagementStats.length - 1 ? 0 : 12),
                  child: GestureDetector(
                    onTap: () => controller.selectStat(idx, true),
                    child: _statCard(
                      label: stat['label'],
                      value: stat['value'],
                      percent: stat['percent'],
                      isSelected: stat['isSelected'],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

        const SizedBox(height: 16),
          _buildChart(
            title: selectedStat['label'],
            value: selectedStat['value'],
          ),
        ],
      );
    });
  }

  // Followers Tab
  Widget _buildFollowersTab() {
    return Obx(() {
      final selectedFollowerStat = controller.followerStats.firstWhere(
            (element) => element['isSelected'] == true,
        orElse: () => controller.followerStats[0],
      );
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDateRow(),
          const SizedBox(height: 16),
          Row(
            children: controller.followerStats.asMap().entries.map((entry) {
              int idx = entry.key;
              var stat = entry.value;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: idx == controller.followerStats.length - 1 ? 0 : 12),
                  child: GestureDetector(
                    onTap: () => controller.selectStat(idx, false),
                    child: _statCard(
                      label: stat['label'],
                      value: stat['value'],
                      percent: stat['percent'],
                      isSelected: stat['isSelected'],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          _buildChart(
            title: selectedFollowerStat['label'],
            value: selectedFollowerStat['value'],
          ),
        ],
      );
    });
  }

  //  Date row
  Widget _buildDateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => Text(
          controller.currentDateRange.value,
          style: AppTextStyles.caption.copyWith(color: AppColors.textOnDark))),
        GestureDetector(
          onTap: _showDateRangePicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(38),
            ),
            child: Row(
              children: [
                Obx(() => Text(controller.currentLabel.value,
                    style: AppTextStyles.caption.copyWith(color: const Color(0xFF606060)))),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF636363)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //  Stat card
  Widget _statCard({
    required String label,
    required String value,
    required String percent,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFE6F2FE)
            : const Color(0xFFFFFFFF),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF3498FA)
              : const Color(0xFFE5E5E5),
          width: 1),
        borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label,
                style: AppTextStyles.bodySmall.copyWith(color: isSelected?AppColors.textGreen :AppColors.background)),
              const SizedBox(width: 4),
              Icon(Icons.info_outline, size: 16, color: isSelected ? AppColors.textGreen : AppColors.background),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
            style: AppTextStyles.headlineLarge.copyWith(color: isSelected ? AppColors.textGreen :AppColors.background)),
          Text(percent,
            style: AppTextStyles.caption.copyWith(color: isSelected ? AppColors.textGreen :AppColors.background)),
        ],
      ),
    );
  }

  //  Chart
  Widget _buildChart({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE4E4E4)),
        borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w400)),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyles.chart),
          const SizedBox(height: 32),
          SizedBox(height: 160,
            child: CustomPaint(
              size: const Size(double.infinity, 160),
              painter: _ChartPainter())),
          const SizedBox(height: 8),
          Center(
            child: Obx(() => Text(controller.currentDateRange.value, style: AppTextStyles.overline)),
          ),
        ],
      ),
    );
  }

  // Date range picker
  void _showDateRangePicker() {

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          backgroundColor: const Color(0xFF252525),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container( width: 36, height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(2))),
                          const SizedBox(height: 12),
                          Text('Select Date Range', style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close,color:AppColors.surface, size: 20),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: controller.dateRanges.map((range) {
                      return Obx(() {
                        final isSelected = controller.currentLabel.value == range['label'];
                        return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color:Color(0xFF333333),
                          borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          onTap: () {
                            controller.updateDateRange(range['label']!, range['sub']!);
                            Get.back();
                          },
                          title: Text( range['label']!,
                            style:AppTextStyles.caption),
                          subtitle: Text(range['sub']!,
                            style:AppTextStyles.caption),
                          trailing: Icon( isSelected ? Icons.check_circle_outline: Icons.radio_button_unchecked,
                            color: isSelected ? AppColors.linkColor: Color(0xFFA6A7AC),
                            size: 20,
                          )
                        )
                        );
                            }
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// Chart painter
class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Color(0xFFCFCFCF)
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = Color(0xFFCFCFCF)
      ..strokeWidth = 1;

    // Y-axis labels
    final labels = ['4', '3', '2', '1', '0'];
    final textStyle = AppTextStyles.overline.copyWith(color: AppColors.textTertiary);

    for (int i = 0; i < labels.length; i++) {
      final y = (size.height / (labels.length - 1)) * i;

      canvas.drawLine(
        Offset(30, y),
        Offset(size.width + 10, y),
        gridPaint,
      );

      // Y-axis
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(5, y - 6));
    }


    double startX = 60;
    double endX = size.width - 30;
    double midX = (startX + endX) / 2;

    List<double> xPositions = [startX, midX, endX];
    for (double x in xPositions) {
      canvas.drawLine(
        Offset(x, -20),
        Offset(x, size.height),
        gridPaint,
      );
    }

    // X-axis
    canvas.drawLine(
      Offset(startX - 10, size.height),
      Offset(size.width + 10, size.height),
      axisPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}