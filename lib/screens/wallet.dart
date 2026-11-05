import 'package:flutter/material.dart';
import 'detailed.dart';
import 'support.dart';

class WalletScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const WalletScreen({super.key, this.onBackToHome});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _selectedNavIndex = 1; // 1 = Wallet tab active

  @override
  Widget build(BuildContext context) {
    if (_selectedNavIndex == 2) {
      return SupportScreen(
        onBackToHome: () {
          if (widget.onBackToHome != null) {
            widget.onBackToHome!();
          } else {
            setState(() {
              _selectedNavIndex = 0;
            });
          }
        },
        onSelectTab: (index) {
          if (index == 0 && widget.onBackToHome != null) {
            widget.onBackToHome!();
          } else {
            setState(() {
              _selectedNavIndex = index;
            });
          }
        },
      );
    }

    if (_selectedNavIndex == 3) {
      return DetailedScreen(
        onBackToHome: () {
          if (widget.onBackToHome != null) {
            widget.onBackToHome!();
          } else {
            setState(() {
              _selectedNavIndex = 0;
            });
          }
        },
        onSelectTab: (index) {
          if (index == 0 && widget.onBackToHome != null) {
            widget.onBackToHome!();
          } else {
            setState(() {
              _selectedNavIndex = index;
            });
          }
        },
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Main Scrollable Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Top Header Bar (Lyca Mobile Logo + Status)
                    _buildTopHeader(),

                    const SizedBox(height: 16),

                    // Top Wallet Gradient Header Card with Floating Balance Card
                    _buildMyWalletCard(),

                    const SizedBox(height: 16),

                    // Metric Cards Row (Airtime, Data, SMS)
                    _buildMetricCardsRow(),

                    const SizedBox(height: 24),

                    // Recent Transactions Section Header
                    _buildRecentTransactionsHeader(),

                    const SizedBox(height: 12),

                    // Transactions List
                    _buildTransactionsList(),

                    const SizedBox(height: 20),

                    // Security Info Banner
                    _buildSecurityBanner(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. TOP HEADER (Lyca Logo + Tagline)
  // ---------------------------------------------------------------------------
  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Brand Logo & Tagline
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Lyca',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF081C42),
                    letterSpacing: -0.8,
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 22,
                  height: 22,
                  child: CustomPaint(
                    painter: WalletHeartPainter(),
                  ),
                ),
              ],
            ),
            const Text(
              'Mobile',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Color(0xFF081C42),
                letterSpacing: -0.3,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'Connect your world',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF081C42),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        // Signal / Status Bar Indicator Mockup
        Row(
          children: [
            const Icon(
              Icons.signal_cellular_alt_rounded,
              color: Color(0xFF081C42),
              size: 18,
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.wifi_rounded,
              color: Color(0xFF081C42),
              size: 18,
            ),
            const SizedBox(width: 4),
            Transform.rotate(
              angle: 1.5708, // 90 deg rotation for horizontal battery
              child: const Icon(
                Icons.battery_full_rounded,
                color: Color(0xFF081C42),
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. MY WALLET GRADIENT CARD & FLOATING MAIN BALANCE CARD
  // ---------------------------------------------------------------------------
  Widget _buildMyWalletCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF032830), // Deep Dark Teal Navy
            Color(0xFF01524C), // Rich Teal
            Color(0xFF007567), // Vibrant Emerald Teal
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF01524C).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'My Wallet',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),

          // Subtitle
          Text(
            'Manage your balance and transactions',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 20),

          // Inner Floating White Main Balance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Side: Wallet Icon + Balance Text
                Expanded(
                  child: Row(
                    children: [
                      // Wallet Icon Container
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4F8),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Color(0xFF0A2540),
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Balance Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Main Balance',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0A2540),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'UGX 25,000',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0A2540),
                                letterSpacing: -0.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Right Side: Top Up Button
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00A884),
                          Color(0xFF00C897),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00A884).withValues(alpha: 0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Top Up',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. METRIC CARDS ROW (Airtime, Data, SMS)
  // ---------------------------------------------------------------------------
  Widget _buildMetricCardsRow() {
    return Row(
      children: [
        // Airtime Card
        Expanded(
          child: _buildMetricCard(
            icon: Icons.call_outlined,
            iconColor: const Color(0xFF00A884),
            label: 'Airtime',
            value: 'UGX 25,000',
          ),
        ),
        const SizedBox(width: 10),

        // Data Card
        Expanded(
          child: _buildMetricCard(
            icon: Icons.language_rounded,
            iconColor: const Color(0xFF1073E5),
            label: 'Data',
            value: '8.4 GB',
          ),
        ),
        const SizedBox(width: 10),

        // SMS Card
        Expanded(
          child: _buildMetricCard(
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: const Color(0xFF1073E5),
            label: 'SMS',
            value: '150',
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEBF0F5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5A6E85),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF081C42),
              letterSpacing: -0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. RECENT TRANSACTIONS HEADER
  // ---------------------------------------------------------------------------
  Widget _buildRecentTransactionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent Transactions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF081C42),
            letterSpacing: -0.3,
          ),
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(4),
          child: Row(
            children: const [
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0070F3),
                ),
              ),
              SizedBox(width: 2),
              Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: Color(0xFF0070F3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. TRANSACTIONS LIST
  // ---------------------------------------------------------------------------
  Widget _buildTransactionsList() {
    final transactions = [
      _TransactionData(
        icon: Icons.language_rounded,
        title: 'Data Bundle Purchase',
        subtitle1: '10GB - 30 Days',
        subtitle2: '20 Oct 2025  •  10:24 AM',
        amount: 'UGX 15,000',
        status: 'Success',
      ),
      _TransactionData(
        icon: Icons.call_outlined,
        title: 'Airtime Top Up',
        subtitle1: '+256 7XX XXX XXX',
        subtitle2: '18 Oct 2025  •  02:15 PM',
        amount: 'UGX 5,000',
        status: 'Success',
      ),
      _TransactionData(
        icon: Icons.language_rounded,
        title: 'Payment (MTN Merchant)',
        subtitle1: null,
        subtitle2: '16 Oct 2025  •  11:47 AM',
        amount: 'UGX 20,000',
        status: 'Success',
      ),
      _TransactionData(
        icon: Icons.language_rounded,
        title: 'Data Bundle Purchase',
        subtitle1: '5GB - 7 Days',
        subtitle2: '12 Oct 2025  •  09:32 AM',
        amount: 'UGX 10,000',
        status: 'Success',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEBF0F5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: List.generate(transactions.length, (index) {
          final item = transactions[index];
          final isLast = index == transactions.length - 1;

          return Column(
            children: [
              _buildTransactionTile(item),
              if (!isLast)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFF0F4F8),
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTransactionTile(_TransactionData item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Icon Container
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F7F4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              color: const Color(0xFF00A884),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // Title & Subtitles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081C42),
                  ),
                ),
                if (item.subtitle1 != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle1!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF708090),
                    ),
                  ),
                ],
                const SizedBox(height: 2),
                Text(
                  item.subtitle2,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Amount & Status Badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF081C42),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF7EC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.status,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00A884),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. SECURITY INFO BANNER
  // ---------------------------------------------------------------------------
  Widget _buildSecurityBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD8E9FE),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Shield Icon Container
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF00897B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),

          // Banner Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Your transactions are secure',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081C42),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'We use industry-standard encryption to keep your information safe.',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF5A6E85),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 7. BOTTOM NAVIGATION BAR
  // ---------------------------------------------------------------------------
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    icon: Icons.menu_rounded,
                    label: 'More',
                  ),
                ],
              ),
            ),

            // Bottom Device Handle Bar
            Container(
              width: 120,
              height: 4,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedNavIndex == index;
    const activeColor = Color(0xFF00A884);
    const inactiveColor = Color(0xFF8A9AAD);

    return InkWell(
      onTap: () {
        if (index == 0 && widget.onBackToHome != null) {
          widget.onBackToHome!();
        } else {
          setState(() {
            _selectedNavIndex = index;
          });
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? activeColor : inactiveColor,
            size: 22,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
          const SizedBox(height: 4),

          // Active Line Indicator
          Container(
            height: 2,
            width: 24,
            decoration: BoxDecoration(
              color: isSelected ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}

// Data class for transactions
class _TransactionData {
  final IconData icon;
  final String title;
  final String? subtitle1;
  final String subtitle2;
  final String amount;
  final String status;

  _TransactionData({
    required this.icon,
    required this.title,
    this.subtitle1,
    required this.subtitle2,
    required this.amount,
    required this.status,
  });
}

// Heart emblem CustomPainter for Lyca Mobile logo
class WalletHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Blue L-Bracket
    final bluePaint = Paint()
      ..color = const Color(0xFF00529C)
      ..style = PaintingStyle.fill;

    final lPath = Path();
    final strokeW = w * 0.28;
    final cornerR = strokeW * 0.5;

    lPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, strokeW, h),
        Radius.circular(cornerR),
      ),
    );

    lPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, h - strokeW, w, strokeW),
        Radius.circular(cornerR),
      ),
    );

    canvas.drawPath(lPath, bluePaint);

    // 2. Green Heart
    final greenPaint = Paint()
      ..color = const Color(0xFF00C88C)
      ..style = PaintingStyle.fill;

    final heartPath = Path();
    final hx = w * 0.20;
    final hy = 0.0;
    final hw = w * 0.80;
    final hh = h * 0.80;

    final topCenter = Offset(hx + hw / 2, hy + hh * 0.32);
    final bottomTip = Offset(hx + hw / 2, hy + hh * 0.95);

    heartPath.moveTo(topCenter.dx, topCenter.dy);

    heartPath.cubicTo(
      hx + hw * 0.1, hy + hh * 0.0,
      hx + hw * 0.0, hy + hh * 0.5,
      bottomTip.dx, bottomTip.dy,
    );

    heartPath.cubicTo(
      hx + hw * 1.0, hy + hh * 0.5,
      hx + hw * 0.9, hy + hh * 0.0,
      topCenter.dx, topCenter.dy,
    );

    canvas.drawPath(heartPath, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
