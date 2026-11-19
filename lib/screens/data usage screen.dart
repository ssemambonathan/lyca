import 'dart:math' as math;
import 'package:flutter/material.dart';

class DataUsageScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;

  const DataUsageScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
  });

  @override
  State<DataUsageScreen> createState() => _DataUsageScreenState();
}

class _DataUsageScreenState extends State<DataUsageScreen> {
  int _selectedPeriodIndex = 2; // 0: Daily, 1: Weekly, 2: Monthly (Selected in reference image)
  int _selectedNavIndex = 3; // 3 = More tab active in reference image

  // Chart data for different periods
  final List<ChartPeriodData> _periodData = [
    // Daily
    ChartPeriodData(
      labels: ['6AM', '9AM', '12PM', '3PM', '6PM'],
      values: [0.25, 0.45, 0.60, 0.75, 0.90],
      maxLabel: '2.1 GB',
      maxIndex: 4,
      totalUsage: '2.1 GB',
      totalCapacity: '4 GB',
      percent: '52%',
    ),
    // Weekly
    ChartPeriodData(
      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
      values: [0.30, 0.42, 0.58, 0.72, 0.88],
      maxLabel: '3.4 GB',
      maxIndex: 4,
      totalUsage: '4.2 GB',
      totalCapacity: '8 GB',
      percent: '53%',
    ),
    // Monthly (Reference design)
    ChartPeriodData(
      labels: ['1', '7', '14', '21', '30'],
      values: [0.30, 0.40, 0.55, 0.70, 0.85],
      maxLabel: '8.6 GB',
      maxIndex: 4,
      totalUsage: '8.4 GB',
      totalCapacity: '12 GB',
      percent: '70%',
    ),
  ];

  void _handleTabTap(int index) {
    if (index == 0 && widget.onBackToHome != null) {
      widget.onBackToHome!();
    } else if (widget.onSelectTab != null) {
      widget.onSelectTab!(index);
    } else {
      setState(() {
        _selectedNavIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentData = _periodData[_selectedPeriodIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: SafeArea(
        child: Column(
          children: [
            // Top Header
            _buildTopHeader(context),

            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Remaining Data Hero Card
                    _buildRemainingDataCard(currentData),

                    const SizedBox(height: 20),

                    // Period Toggle Buttons (Daily, Weekly, Monthly)
                    _buildPeriodToggle(),

                    const SizedBox(height: 16),

                    // Usage Chart Card
                    _buildChartCard(currentData),

                    const SizedBox(height: 24),

                    // Usage Breakdown Section Title
                    const Text(
                      'Usage Breakdown',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0A1C47),
                        letterSpacing: -0.2,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Usage Breakdown List
                    _buildUsageBreakdownList(),

                    const SizedBox(height: 20),

                    // View Detailed Usage Button
                    _buildViewDetailedUsageButton(context),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  // Header with back arrow and title
  Widget _buildTopHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 16.0, top: 4.0, bottom: 4.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF0A1C47),
              size: 26,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else if (widget.onBackToHome != null) {
                widget.onBackToHome!();
              }
            },
          ),
          const SizedBox(width: 4),
          const Text(
            'Data Usage',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0A1C47),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  // Hero Card showing remaining data & circular gauge
  Widget _buildRemainingDataCard(ChartPeriodData currentData) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF052368),
            Color(0xFF042B76),
            Color(0xFF007A8A),
            Color(0xFF00A391),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.35, 0.75, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF042B76).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background abstract glowing waves
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomPaint(
                painter: CardGlowPainter(),
              ),
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Remaining Data',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        currentData.totalUsage,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'of ${currentData.totalCapacity}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Valid for tag
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.4),
                                width: 1.2,
                              ),
                            ),
                            child: const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Valid for: 30 Days',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Right Side Circular Progress Gauge
                Column(
                  children: [
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(96, 96),
                            painter: CircularProgressPainter(
                              progress: 0.70, // 70% as shown in reference
                            ),
                          ),
                          const Text(
                            '70%',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Period segmented toggle (Daily, Weekly, Monthly)
  Widget _buildPeriodToggle() {
    final periods = ['Daily', 'Weekly', 'Monthly'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(periods.length, (index) {
        final isSelected = _selectedPeriodIndex == index;
        return Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedPeriodIndex = index;
              });
            },
            borderRadius: BorderRadius.circular(25),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF00C853) : const Color(0xFFEFF3F8),
                borderRadius: BorderRadius.circular(25),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00C853).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: Text(
                periods[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF0A1C47),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // Data Usage Chart Card with columns and tooltip
  Widget _buildChartCard(ChartPeriodData currentData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8EEF5),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Chart Graphic Area
          SizedBox(
            height: 180,
            child: LayoutBuilder(
              builder: (context, constraints) {
                const barWidth = 20.0;
                final availableWidth = constraints.maxWidth;
                final step = availableWidth / currentData.labels.length;

                return Stack(
                  children: [
                    // Tooltip over the peak bar (Bar index 4 - label 30)
                    Positioned(
                      left: (step * currentData.maxIndex) + (step / 2) - 34,
                      top: 4,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF3FE),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              currentData.maxLabel,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          Container(
                            width: 1.5,
                            height: 6,
                            color: const Color(0xFF2563EB),
                          ),
                        ],
                      ),
                    ),

                    // Bars Row
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 36,
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(currentData.values.length, (index) {
                          final value = currentData.values[index];
                          return Container(
                            width: barWidth,
                            height: 130,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.bottomCenter,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: barWidth,
                              height: 130 * value,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00C853),
                                    Color(0xFF00E676),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Baseline horizontal line
          Container(
            height: 1,
            color: const Color(0xFFE2E8F0),
          ),

          const SizedBox(height: 10),

          // X-Axis Labels (1, 7, 14, 21, 30)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: currentData.labels.map((label) {
              return SizedBox(
                width: 30,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A1C47),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Breakdown items (Data, Voice, SMS)
  Widget _buildUsageBreakdownList() {
    return Column(
      children: [
        _buildBreakdownRow(
          icon: Icons.public_rounded,
          iconBgColor: const Color(0xFFE8F1FF),
          iconColor: const Color(0xFF1D61E7),
          title: 'Data',
          value: '8.4 GB',
          percentage: '70%',
        ),
        const Divider(height: 16, thickness: 1, color: Color(0xFFF1F5F9)),
        _buildBreakdownRow(
          icon: Icons.call_rounded,
          iconBgColor: const Color(0xFFE6F8EF),
          iconColor: const Color(0xFF00C853),
          title: 'Voice',
          value: '120 Min',
          percentage: '20%',
        ),
        const Divider(height: 16, thickness: 1, color: Color(0xFFF1F5F9)),
        _buildBreakdownRow(
          icon: Icons.chat_bubble_rounded,
          iconBgColor: const Color(0xFFE8F1FF),
          iconColor: const Color(0xFF1D61E7),
          title: 'SMS',
          value: '85 SMS',
          percentage: '10%',
        ),
      ],
    );
  }

  Widget _buildBreakdownRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String value,
    required String percentage,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Icon inside rounded circle
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),

          // Title (Data, Voice, SMS)
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1C47),
            ),
          ),

          const Spacer(),

          // Middle Value (8.4 GB, 120 Min, 85 SMS)
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1C47),
            ),
          ),

          const SizedBox(width: 28),

          // Right Percentage (70%, 20%, 10%)
          SizedBox(
            width: 40,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                percentage,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1C47),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // View Detailed Usage outlined green button
  Widget _buildViewDetailedUsageButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Displaying detailed usage breakdown...'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF00C853), width: 1.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          'View Detailed Usage',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00C853),
          ),
        ),
      ),
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0),
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            icon: Icons.home_rounded,
            label: 'Home',
          ),
          _buildNavItem(
            index: 1,
            icon: Icons.account_balance_wallet_rounded,
            label: 'Wallet',
          ),
          _buildNavItem(
            index: 2,
            icon: Icons.headset_mic_rounded,
            label: 'Support',
          ),
          _buildNavItem(
            index: 3,
            icon: Icons.notes_rounded,
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedNavIndex == index;
    const activeColor = Color(0xFF00A896);
    const inactiveColor = Color(0xFF94A3B8);

    return InkWell(
      onTap: () => _handleTabTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? activeColor : inactiveColor,
            size: 24,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 20,
              height: 2,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    );
  }
}

// Data class for periods
class ChartPeriodData {
  final List<String> labels;
  final List<double> values;
  final String maxLabel;
  final int maxIndex;
  final String totalUsage;
  final String totalCapacity;
  final String percent;

  ChartPeriodData({
    required this.labels,
    required this.values,
    required this.maxLabel,
    required this.maxIndex,
    required this.totalUsage,
    required this.totalCapacity,
    required this.percent,
  });
}

// Custom Painter for circular progress gauge in hero card
class CircularProgressPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0

  CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 8.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle track
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, bgPaint);

    // Active progress arc
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF00E676),
          Color(0xFF00B0FF),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Start angle from top (-pi / 2)
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom Painter for subtle background glowing shapes in the top card
class CardGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF00B4D8).withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color(0xFF00E676).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    // Top right glow circle behind progress bar
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.3),
      size.width * 0.45,
      paint1,
    );

    // Bottom right soft green highlight
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.9),
      size.width * 0.35,
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
