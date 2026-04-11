import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatorDashboardView extends StatefulWidget {
  const CreatorDashboardView({super.key});

  @override
  State<CreatorDashboardView> createState() => _CreatorDashboardViewState();
}

class _CreatorDashboardViewState extends State<CreatorDashboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;
  String _selectedRange = 'Last 7 Days';

  static const List<Map<String, String>> _dateRanges = [
    {'label': 'Last 7 days', 'sub': 'Mar 25 - Mar 31'},
    {'label': 'Last 28 days', 'sub': 'Mar 4 - Mar 31'},
    {'label': 'Last 60 days', 'sub': 'Jan 31 - Mar 31'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedTab = _tabController.index);
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.black, size: 18),
        ),
        title: const Text(
          'Creator Dashboard',
          style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          indicatorWeight: 2,
          labelStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Engagement'),
            Tab(text: 'Followers'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEngagementTab(),
          _buildFollowersTab(),
        ],
      ),
    );
  }

  // ── Engagement Tab ───────────────────────────
  Widget _buildEngagementTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildDateRow(),
        const SizedBox(height: 16),
        // Stats cards
        Row(
          children: [
            Expanded(
              child: _statCard(
                label: 'Impressions',
                value: '0',
                percent: '0.0%',
                isSelected: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                label: 'Likes',
                value: '0',
                percent: '0.0%',
                isSelected: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildChart(title: 'Impressions'),
      ],
    );
  }

  // ── Followers Tab ────────────────────────────
  Widget _buildFollowersTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildDateRow(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _statCard(
                label: 'Total Followers',
                value: '0',
                percent: '0.0%',
                isSelected: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                label: 'Followers',
                value: '0',
                percent: '0.0%',
                isSelected: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildChart(title: 'Total Followers'),
      ],
    );
  }

  // ── Date row ─────────────────────────────────
  Widget _buildDateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Mar 17 - Mar 17',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        GestureDetector(
          onTap: _showDateRangePicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(_selectedRange,
                    style: const TextStyle(
                        color: Colors.black, fontSize: 12)),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down,
                    size: 16, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Stat card ────────────────────────────────
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
            ? const Color(0xFFE8F0FE)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.info_outline,
                  size: 14,
                  color:
                  isSelected ? Colors.blue : Colors.grey),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            percent,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ── Chart ────────────────────────────────────
  Widget _buildChart({required String title}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          const Text('0',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: CustomPaint(
              size: const Size(double.infinity, 160),
              painter: _ChartPainter(),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text('March 17',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  // ── Date range picker ────────────────────────
  void _showDateRangePicker() {
    String tempSelected = _selectedRange;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (_, setModalState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select Date Range',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12, height: 1),
            ..._dateRanges.map((range) {
              final isSelected = tempSelected == range['label'];
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      setModalState(
                              () => tempSelected = range['label']!);
                      setState(
                              () => _selectedRange = range['label']!);
                      Navigator.pop(context);
                    },
                    title: Text(range['label']!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14)),
                    subtitle: Text(range['sub']!,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12)),
                    trailing: Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color:
                      isSelected ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                ],
              );
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Chart painter ────────────────────────────────
class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    // Y-axis labels
    final labels = ['4', '3', '2', '1', '0'];
    final textStyle = TextStyle(color: Colors.grey.shade400, fontSize: 10);

    for (int i = 0; i < labels.length; i++) {
      final y = (size.height / (labels.length - 1)) * i;
      // Grid line
      canvas.drawLine(
        Offset(20, y),
        Offset(size.width, y),
        gridPaint,
      );
      // Label
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    // X-axis line
    final axisPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(20, size.height),
      Offset(size.width, size.height),
      axisPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}