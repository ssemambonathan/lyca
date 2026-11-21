import 'package:flutter/material.dart';
import 'buybundles screen.dart';

class OffersScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;

  const OffersScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
  });

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  int _selectedNavIndex = 3; // "More" tab selected in reference screenshot
  final int _activeCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildAppBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Featured Special Offer Hero Card
                    _buildHeroOfferCard(),

                    const SizedBox(height: 16),

                    // Page Indicator Dots
                    _buildPageIndicator(),

                    const SizedBox(height: 24),

                    // "Other Offers" Section Header
                    _buildSectionHeader(),

                    const SizedBox(height: 16),

                    // List of Offer Cards
                    _buildOfferCard(
                      title: '5 GB',
                      subtitle: 'UGX 7,000',
                      validity: '7 Days',
                      icon: _buildGroupIcon(),
                      onTapGet: () => _navigateToBuyBundle(
                        title: '5 GB Data Offer',
                        validity: '7 Days',
                        price: 'UGX 7,000',
                        features: const [
                          '5 GB High Speed Data',
                          '7 Days Validity',
                          'Superfast 4G/LTE',
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    _buildOfferCard(
                      title: '100 Min',
                      subtitle: 'UGX 5,000',
                      validity: '7 Days',
                      icon: _buildVoiceIcon(),
                      onTapGet: () => _navigateToBuyBundle(
                        title: '100 Min Voice Offer',
                        validity: '7 Days',
                        price: 'UGX 5,000',
                        features: const [
                          '100 Local Minutes',
                          '7 Days Validity',
                          'All Networks',
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    _buildOfferCard(
                      title: 'Combo',
                      subtitle: '5 GB + 100 Min',
                      validity: 'UGX 12,000',
                      icon: _buildComboIcon(),
                      onTapGet: () => _navigateToBuyBundle(
                        title: 'Combo Offer (Data + Voice)',
                        validity: '7 Days',
                        price: 'UGX 12,000',
                        features: const [
                          '5 GB Data',
                          '100 Minutes Voice',
                          '7 Days Validity',
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),
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

  // ---------------------------------------------------------------------------
  // 1. TOP APP BAR
  // ---------------------------------------------------------------------------
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (widget.onBackToHome != null) {
                widget.onBackToHome!();
              } else if (context.mounted && Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF081C42),
              size: 26,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 16),
          const Text(
            'Offers',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF081C42),
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. HERO SPECIAL OFFER CARD
  // ---------------------------------------------------------------------------
  Widget _buildHeroOfferCard() {
    return Container(
      width: double.infinity,
      height: 195,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF033F4F),
            Color(0xFF052A40),
            Color(0xFF071B33),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF042B38).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Decorative background light radial glow
            Positioned(
              top: -40,
              right: 60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF00C775).withValues(alpha: 0.18),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00C775).withValues(alpha: 0.18),
                      blurRadius: 60,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),

            // Main Layout Row (Left Text + Right Image)
            Row(
              children: [
                // Left Column Content
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 18.0, bottom: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Special Offer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '10 GB',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                            letterSpacing: -0.8,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'for only UGX 10,000',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // "Get Offer" Pill Button
                        GestureDetector(
                          onTap: () => _navigateToBuyBundle(
                            title: 'Special Offer 10 GB',
                            validity: '30 Days',
                            price: 'UGX 10,000',
                            features: const [
                              '10 GB Ultra Data',
                              'UGX 10,000 Only',
                              'Valid for 30 Days',
                              'Free Lyca to Lyca minutes',
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF00E676),
                                  Color(0xFF00C775),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF00C775).withValues(alpha: 0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Get Offer',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right Image / Custom Painter illustration
                Expanded(
                  flex: 9,
                  child: SizedBox(
                    height: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // Custom Painter artwork as robust background & fallback
                        const CustomPaint(
                          size: Size(160, 195),
                          painter: SpecialOfferWomanPainter(),
                        ),

                        // High resolution image network overlay if available
                        Image.network(
                          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=600',
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to the CustomPaint illustration gracefully
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. PAGE INDICATOR DOTS
  // ---------------------------------------------------------------------------
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Active dot 1
        _buildDot(color: const Color(0xFF00C775), isSelected: _activeCarouselIndex == 0),
        const SizedBox(width: 8),
        // Active dot 2
        _buildDot(color: const Color(0xFF00A896), isSelected: _activeCarouselIndex == 1),
        const SizedBox(width: 8),
        // Active dot 3
        _buildDot(color: const Color(0xFF9EAEC7), isSelected: _activeCarouselIndex == 2),
      ],
    );
  }

  Widget _buildDot({required Color color, required bool isSelected}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSelected ? 24 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isSelected ? color : color.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. SECTION HEADER
  // ---------------------------------------------------------------------------
  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Other Offers',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF081C42),
            letterSpacing: -0.4,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Showing all promotional offers...'),
                backgroundColor: Color(0xFF00A896),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
              SizedBox(width: 3),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: Color(0xFF2563EB),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. OFFER CARD ITEM WIDGET
  // ---------------------------------------------------------------------------
  Widget _buildOfferCard({
    required String title,
    required String subtitle,
    required String validity,
    required Widget icon,
    required VoidCallback onTapGet,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left Squircle Icon Container
          icon,

          const SizedBox(width: 16),

          // Offer Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF081C42),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF081C42),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  validity,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // "Get" Action Button
          GestureDetector(
            onTap: onTapGet,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFD1FADF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Get',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF00C775),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. ICONS FOR OFFER CARDS
  // ---------------------------------------------------------------------------

  // Card 1: 5 GB Group Icon (Blue Border Squircle with 4 colorful avatars)
  Widget _buildGroupIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2563EB),
          width: 1.8,
        ),
      ),
      child: const CustomPaint(
        painter: OfferGroupIconPainter(),
      ),
    );
  }

  // Card 2: 100 Min Voice Icon (Soft Cream Squircle with Orange Phone receiver)
  Widget _buildVoiceIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const CustomPaint(
            painter: OfferPhoneIconPainter(),
          ),
        ),
      ),
    );
  }

  // Card 3: Combo Icon (Soft Pink Squircle with Red Circle/Arc loop)
  Widget _buildComboIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: const CustomPaint(
            painter: OfferComboIconPainter(),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 7. BOTTOM NAVIGATION BAR
  // ---------------------------------------------------------------------------
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8F0),
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
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
        if (widget.onSelectTab != null) {
          widget.onSelectTab!(index);
        } else if (index == 0 && widget.onBackToHome != null) {
          widget.onBackToHome!();
        }
      },
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

  // ---------------------------------------------------------------------------
  // NAVIGATION HELPER
  // ---------------------------------------------------------------------------
  void _navigateToBuyBundle({
    required String title,
    required String validity,
    required String price,
    required List<String> features,
  }) {
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BuyBundlesScreen(
          bundleTitle: title,
          validity: validity,
          price: price,
          features: features,
        ),
      ),
    );
  }
}

// =============================================================================
// CUSTOM PAINTERS FOR ARTWORK & CARDS
// =============================================================================

/// Custom painter for Special Offer Hero Banner woman illustration
class SpecialOfferWomanPainter extends CustomPainter {
  const SpecialOfferWomanPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Skin Tone
    final skinPaint = Paint()
      ..color = const Color(0xFF6B4226)
      ..style = PaintingStyle.fill;

    // Denim Jacket
    final denimPaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.fill;

    // White Top
    final whiteTopPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Hair / Braids
    final hairPaint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..style = PaintingStyle.fill;

    // Head circle
    final headCenter = Offset(w * 0.62, h * 0.28);
    canvas.drawCircle(headCenter, 22, skinPaint);

    // Hair / Braids strands
    for (int i = -3; i <= 4; i++) {
      final path = Path();
      path.moveTo(w * 0.55 + i * 4, h * 0.15);
      path.quadraticBezierTo(
        w * 0.48 + i * 5,
        h * 0.35,
        w * 0.52 + i * 4,
        h * 0.55,
      );
      path.lineTo(w * 0.55 + i * 4, h * 0.55);
      path.close();
      canvas.drawPath(path, hairPaint);
    }

    // Body / White Top
    final topPath = Path();
    topPath.moveTo(w * 0.40, h);
    topPath.lineTo(w * 0.52, h * 0.48);
    topPath.lineTo(w * 0.72, h * 0.48);
    topPath.lineTo(w * 0.85, h);
    topPath.close();
    canvas.drawPath(topPath, whiteTopPaint);

    // Denim Jacket Sleeves & Body
    final jacketPath = Path();
    jacketPath.moveTo(w * 0.32, h);
    jacketPath.lineTo(w * 0.46, h * 0.52);
    jacketPath.lineTo(w * 0.54, h * 0.52);
    jacketPath.lineTo(w * 0.45, h);
    jacketPath.close();
    canvas.drawPath(jacketPath, denimPaint);

    final jacketRightPath = Path();
    jacketRightPath.moveTo(w * 0.70, h * 0.52);
    jacketRightPath.lineTo(w * 0.78, h * 0.52);
    jacketRightPath.lineTo(w * 0.95, h);
    jacketRightPath.lineTo(w * 0.82, h);
    jacketRightPath.close();
    canvas.drawPath(jacketRightPath, denimPaint);

    // Phone handset held in hands
    final phonePaint = Paint()
      ..color = const Color(0xFF1F2937)
      ..style = PaintingStyle.fill;

    final phoneRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.48, h * 0.56, 24, 42),
      const Radius.circular(5),
    );
    canvas.drawRRect(phoneRRect, phonePaint);

    // Screen light glow
    final screenPaint = Paint()
      ..color = const Color(0xFF60A5FA)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.50, h * 0.59, 20, 36),
        const Radius.circular(3),
      ),
      screenPaint,
    );

    // Hands holding phone
    canvas.drawCircle(Offset(w * 0.47, h * 0.74), 7, skinPaint);
    canvas.drawCircle(Offset(w * 0.73, h * 0.74), 7, skinPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Custom painter for Card 1 (5 GB Group Icon - 4 colorful avatars)
class OfferGroupIconPainter extends CustomPainter {
  const OfferGroupIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final orangePaint = Paint()..color = const Color(0xFFF97316);
    final greenPaint = Paint()..color = const Color(0xFF22C55E);
    final redPaint = Paint()..color = const Color(0xFFEF4444);
    final yellowPaint = Paint()..color = const Color(0xFFEAB308);

    // 4 Avatar figures placed in squircle
    // Top-Left (Green)
    canvas.drawCircle(Offset(w * 0.38, h * 0.35), 6, greenPaint);
    final greenBody = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(w * 0.38, h * 0.52), radius: 8),
        3.14,
        3.14,
      );
    canvas.drawPath(greenBody, greenPaint);

    // Top-Right (Orange/Red)
    canvas.drawCircle(Offset(w * 0.62, h * 0.35), 6, orangePaint);
    final orangeBody = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(w * 0.62, h * 0.52), radius: 8),
        3.14,
        3.14,
      );
    canvas.drawPath(orangeBody, orangePaint);

    // Bottom-Left (Yellow)
    canvas.drawCircle(Offset(w * 0.38, h * 0.62), 5, yellowPaint);
    final yellowBody = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(w * 0.38, h * 0.78), radius: 7),
        3.14,
        3.14,
      );
    canvas.drawPath(yellowBody, yellowPaint);

    // Bottom-Right (Red)
    canvas.drawCircle(Offset(w * 0.62, h * 0.62), 5, redPaint);
    final redBody = Path()
      ..addArc(
        Rect.fromCircle(center: Offset(w * 0.62, h * 0.78), radius: 7),
        3.14,
        3.14,
      );
    canvas.drawPath(redBody, redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Custom painter for Card 2 (100 Min Phone Handset Icon)
class OfferPhoneIconPainter extends CustomPainter {
  const OfferPhoneIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(w * 0.25, h * 0.35);
    path.cubicTo(w * 0.25, h * 0.20, w * 0.45, h * 0.20, w * 0.50, h * 0.35);
    path.lineTo(w * 0.40, h * 0.45);
    path.cubicTo(w * 0.45, h * 0.55, w * 0.55, h * 0.65, w * 0.65, h * 0.70);
    path.lineTo(w * 0.75, h * 0.60);
    path.cubicTo(w * 0.90, h * 0.65, w * 0.90, h * 0.85, w * 0.75, h * 0.85);
    path.cubicTo(w * 0.30, h * 0.85, w * 0.15, h * 0.70, w * 0.25, h * 0.35);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Custom painter for Card 3 (Combo Red Arc Loop Icon)
class OfferComboIconPainter extends CustomPainter {
  const OfferComboIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final strokePaint = Paint()
      ..color = const Color(0xFFEF4444)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.70, h * 0.70);
    canvas.drawArc(rect, 0.4, 4.8, false, strokePaint);

    // Arrow tip on arc
    final arrowPaint = Paint()
      ..color = const Color(0xFFEF4444)
      ..style = PaintingStyle.fill;

    final arrowPath = Path();
    arrowPath.moveTo(w * 0.75, h * 0.18);
    arrowPath.lineTo(w * 0.90, h * 0.32);
    arrowPath.lineTo(w * 0.68, h * 0.38);
    arrowPath.close();
    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
