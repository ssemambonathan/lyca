import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;

  const SupportScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
  });

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  int _selectedNavIndex = 2; // 2 = Support tab active
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase().trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Top Header Bar (Lyca Mobile Logo + Tagline)
                    _buildTopHeader(),

                    const SizedBox(height: 16),

                    // Hero Banner Card: "How can we help you today?"
                    _buildHeroBannerCard(),

                    const SizedBox(height: 16),

                    // 2x2 Quick Action Cards
                    _buildQuickActionCardsGrid(),

                    const SizedBox(height: 20),

                    // Popular Help Topics Section
                    _buildPopularTopicsSection(),

                    const SizedBox(height: 20),

                    // "Need more help?" Support Agent Banner
                    _buildNeedMoreHelpBanner(),

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
  // 1. TOP HEADER (Lyca Mobile Logo + Tagline)
  // ---------------------------------------------------------------------------
  Widget _buildTopHeader() {
    return Column(
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
            CustomPaint(
              size: const Size(22, 20),
              painter: SupportHeartPainter(),
            ),
          ],
        ),
        const Text(
          'Mobile',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF081C42),
            height: 1.0,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Connect your world',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5A6E85),
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. HERO BANNER CARD: "How can we help you today?"
  // ---------------------------------------------------------------------------
  Widget _buildHeroBannerCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF03223A),
            Color(0xFF025263),
            Color(0xFF00A376),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A00A376),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Decorative Wave Background
            Positioned.fill(
              child: CustomPaint(
                painter: HeroWaveBgPainter(),
              ),
            ),

            // Content Padding
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How can we help you today?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Get quick answers, chat with us or find the\nright support.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFE2F1F8),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Pill Search Bar
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x12000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF081C42),
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(
                              color: Color(0xFF081C42),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Search for help...',
                              hintStyle: TextStyle(
                                color: Color(0xFF8C9BAE),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        if (_searchQuery.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: Color(0xFF8C9BAE),
                              ),
                            ),
                          ),
                        const SizedBox(width: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. 2x2 QUICK ACTION CARDS
  // ---------------------------------------------------------------------------
  Widget _buildQuickActionCardsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.chat_bubble_outline_rounded,
                iconBgColor: const Color(0xFFEBF3FF),
                iconColor: const Color(0xFF00529C),
                title: 'Live Chat',
                description: 'Chat with our support team 24/7',
                onTap: () => _showSupportModal(
                  'Live Chat',
                  'Connecting you with a Lyca representative...',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.call_outlined,
                iconBgColor: const Color(0xFFE6F7F0),
                iconColor: const Color(0xFF00A878),
                title: 'Call Us',
                customSubtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '+256 800 777 999',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF081C42),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '(Free from Lyca)',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7C93),
                      ),
                    ),
                  ],
                ),
                onTap: () => _showSupportModal(
                  'Call Us',
                  'Dialing +256 800 777 999 (Toll Free)...',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.help_outline_rounded,
                iconBgColor: const Color(0xFFEBF3FF),
                iconColor: const Color(0xFF0066CC),
                title: 'FAQs',
                description: 'Find answers to common questions',
                onTap: () => _showSupportModal(
                  'FAQs',
                  'Browsing Lyca Mobile Frequently Asked Questions...',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.warning_amber_rounded,
                iconBgColor: const Color(0xFFFFF0F0),
                iconColor: const Color(0xFFE53935),
                title: 'Report a Problem',
                description: 'Let us know about an issue',
                onTap: () => _showSupportModal(
                  'Report a Problem',
                  'Please describe the technical or service issue...',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    String? description,
    Widget? customSubtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 128,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE8EEF5),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon Circle
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
                  size: 22,
                ),
              ),

              // Title & Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF081C42),
                    ),
                  ),
                  const SizedBox(height: 3),
                  if (customSubtitle != null)
                    customSubtitle
                  else if (description != null)
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7C93),
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. POPULAR HELP TOPICS SECTION
  // ---------------------------------------------------------------------------
  Widget _buildPopularTopicsSection() {
    final topics = [
      {
        'title': 'Data Bundles & Internet',
        'icon': Icons.article_outlined,
      },
      {
        'title': 'Airtime & Calls',
        'icon': Icons.phone_android_outlined,
      },
      {
        'title': 'International Calling',
        'icon': Icons.info_outlined,
      },
      {
        'title': 'SIM & Activation',
        'icon': Icons.sim_card_outlined,
      },
      {
        'title': 'Payments & Top Up',
        'icon': Icons.account_balance_wallet_outlined,
      },
      {
        'title': 'Account & Security',
        'icon': Icons.lock_outline_rounded,
      },
    ];

    final filteredTopics = _searchQuery.isEmpty
        ? topics
        : topics
            .where((t) =>
                (t['title'] as String).toLowerCase().contains(_searchQuery))
            .toList();

    return Column(
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Help Topics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF081C42),
              ),
            ),
            InkWell(
              onTap: () => _showSupportModal(
                'All Topics',
                'Displaying all support categories and user guides.',
              ),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0066CC),
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: Color(0xFF0066CC),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // List Container Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE8EEF5),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: List.generate(filteredTopics.length, (index) {
              final topic = filteredTopics[index];
              final isLast = index == filteredTopics.length - 1;

              return Column(
                children: [
                  InkWell(
                    onTap: () => _showSupportModal(
                      topic['title'] as String,
                      'Detailed information and options for ${topic['title']}.',
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: index == 0 ? const Radius.circular(16) : Radius.zero,
                      bottom: isLast ? const Radius.circular(16) : Radius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            topic['icon'] as IconData,
                            size: 20,
                            color: const Color(0xFF081C42),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              topic['title'] as String,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF081C42),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: Color(0xFF8A9AAD),
                          ),
                        ],
                      ),
                    ),
                  ),
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
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. "NEED MORE HELP?" SUPPORT AGENT BANNER
  // ---------------------------------------------------------------------------
  Widget _buildNeedMoreHelpBanner() {
    return Container(
      width: double.infinity,
      height: 148,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF031A35),
            Color(0xFF02525A),
            Color(0xFF00A878),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A00A878),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Right Side Support Agent Illustration
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 170,
              child: CustomPaint(
                painter: SupportAgentPainter(),
              ),
            ),

            // Left Side Text & Start Live Chat Button
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Need more help?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Our support team is here for you.',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFD0E8F2),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Pill Button: Start Live Chat
                          Material(
                            color: const Color(0xFF00D084),
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () => _showSupportModal(
                                'Live Chat',
                                'Starting live chat session with a customer support agent...',
                              ),
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 9,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      size: 17,
                                      color: Color(0xFF003828),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Start Live Chat',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF003828),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 4,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. BOTTOM NAVIGATION BAR
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
      onTap: () => _handleTabTap(index),
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

          // Active tab indicator line
          if (isSelected)
            Container(
              width: 36,
              height: 3,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(2),
              ),
            )
          else
            const SizedBox(height: 3),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER MODAL DIALOG
  // ---------------------------------------------------------------------------
  void _showSupportModal(String title, String message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE6F7F0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.headset_mic_rounded,
                      color: Color(0xFF00A878),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF081C42),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5A6E85),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A878),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Got it',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

// =============================================================================
// CUSTOM PAINTERS
// =============================================================================

/// Custom painter for the small Lyca Heart emblem in header
class SupportHeartPainter extends CustomPainter {
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

/// Abstract wave background painter for the Hero Banner Card
class HeroWaveBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final wavePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;

    final wavePath1 = Path();
    wavePath1.moveTo(w * 0.45, 0);
    wavePath1.cubicTo(w * 0.55, h * 0.3, w * 0.75, h * 0.2, w, h * 0.6);
    wavePath1.lineTo(w, 0);
    wavePath1.close();
    canvas.drawPath(wavePath1, wavePaint);

    final tealGlowPaint = Paint()
      ..color = const Color(0xFF00D084).withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final wavePath2 = Path();
    wavePath2.moveTo(w * 0.6, h);
    wavePath2.cubicTo(w * 0.7, h * 0.4, w * 0.85, h * 0.5, w, h * 0.1);
    wavePath2.lineTo(w, h);
    wavePath2.close();
    canvas.drawPath(wavePath2, tealGlowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for rendering the female support agent with headset
class SupportAgentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Teal Ambient Glow Circle in Background
    final glowPaint = Paint()
      ..color = const Color(0xFF00A878)
      ..style = PaintingStyle.fill;

    final bgPath = Path();
    bgPath.moveTo(w * 0.2, h);
    bgPath.cubicTo(w * 0.1, h * 0.5, w * 0.4, h * 0.1, w, h * 0.2);
    bgPath.lineTo(w, h);
    bgPath.close();
    canvas.drawPath(bgPath, glowPaint);

    // 2. Woman Skin Tone
    final skinPaint = Paint()
      ..color = const Color(0xFF6D4C41)
      ..style = PaintingStyle.fill;

    // 3. Hair (Afro/curly style)
    final hairPaint = Paint()
      ..color = const Color(0xFF1F1F1F)
      ..style = PaintingStyle.fill;

    // Draw Hair Background Volume
    final hairCenter = Offset(w * 0.62, h * 0.38);
    canvas.drawCircle(hairCenter, 34, hairPaint);
    canvas.drawCircle(Offset(w * 0.52, h * 0.35), 26, hairPaint);
    canvas.drawCircle(Offset(w * 0.72, h * 0.35), 26, hairPaint);

    // Draw Neck
    final neckPath = Path();
    neckPath.moveTo(w * 0.58, h * 0.52);
    neckPath.lineTo(w * 0.66, h * 0.52);
    neckPath.lineTo(w * 0.66, h * 0.66);
    neckPath.lineTo(w * 0.58, h * 0.66);
    neckPath.close();
    canvas.drawPath(neckPath, skinPaint);

    // Draw Head Oval
    final headCenter = Offset(w * 0.62, h * 0.42);
    canvas.drawOval(
      Rect.fromCenter(center: headCenter, width: 38, height: 46),
      skinPaint,
    );

    // Smile / Lips
    final smilePaint = Paint()
      ..color = const Color(0xFFD81B60)
      ..style = PaintingStyle.fill;

    final smilePath = Path();
    smilePath.addArc(
      Rect.fromCenter(
        center: Offset(w * 0.58, h * 0.48),
        width: 14,
        height: 10,
      ),
      0.1,
      2.9,
    );
    canvas.drawPath(smilePath, smilePaint);

    // Eyes
    final eyePaint = Paint()
      ..color = const Color(0xFF212121)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w * 0.56, h * 0.41), 2.2, eyePaint);
    canvas.drawCircle(Offset(w * 0.66, h * 0.41), 2.2, eyePaint);

    // 4. Blazer / Outfit
    final blazerPaint = Paint()
      ..color = const Color(0xFF00385E)
      ..style = PaintingStyle.fill;

    final collarPaint = Paint()
      ..color = const Color(0xFF0072C6)
      ..style = PaintingStyle.fill;

    final bodyPath = Path();
    bodyPath.moveTo(w * 0.35, h);
    bodyPath.cubicTo(w * 0.45, h * 0.66, w * 0.55, h * 0.64, w * 0.62, h * 0.65);
    bodyPath.cubicTo(w * 0.72, h * 0.64, w * 0.85, h * 0.68, w * 0.95, h);
    bodyPath.close();
    canvas.drawPath(bodyPath, blazerPaint);

    // Inner Shirt Collar
    final shirtPath = Path();
    shirtPath.moveTo(w * 0.58, h * 0.65);
    shirtPath.lineTo(w * 0.62, h * 0.78);
    shirtPath.lineTo(w * 0.66, h * 0.65);
    shirtPath.close();
    canvas.drawPath(shirtPath, collarPaint);

    // 5. Call Center Headset
    final headsetPaint = Paint()
      ..color = const Color(0xFF2C2C2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Headband
    final headbandPath = Path();
    headbandPath.addArc(
      Rect.fromCenter(
        center: Offset(w * 0.62, h * 0.36),
        width: 44,
        height: 40,
      ),
      3.14,
      3.14,
    );
    canvas.drawPath(headbandPath, headsetPaint);

    // Earpiece
    final earpiecePaint = Paint()
      ..color = const Color(0xFF3A3A3C)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.68, h * 0.38, 8, 16),
        const Radius.circular(4),
      ),
      earpiecePaint,
    );

    // Microphone Boom Arm
    final micArmPath = Path();
    micArmPath.moveTo(w * 0.71, h * 0.45);
    micArmPath.cubicTo(w * 0.68, h * 0.52, w * 0.62, h * 0.53, w * 0.55, h * 0.50);

    canvas.drawPath(micArmPath, headsetPaint);

    // Microphone Foam
    canvas.drawCircle(Offset(w * 0.54, h * 0.50), 4, earpiecePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
