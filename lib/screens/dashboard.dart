import 'package:flutter/material.dart';
import 'detailed.dart';
import 'support.dart';
import 'wallet.dart';
import 'paymentprocessingscreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (_selectedNavIndex == 1) {
      return WalletScreen(
        onBackToHome: () {
          setState(() {
            _selectedNavIndex = 0;
          });
        },
      );
    }

    if (_selectedNavIndex == 2) {
      return SupportScreen(
        onBackToHome: () {
          setState(() {
            _selectedNavIndex = 0;
          });
        },
        onSelectTab: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
      );
    }

    if (_selectedNavIndex == 3) {
      return DetailedScreen(
        onBackToHome: () {
          setState(() {
            _selectedNavIndex = 0;
          });
        },
        onSelectTab: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
      );
    }

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
                    // Status Bar / Top Navigation
                    _buildTopHeader(),

                    const SizedBox(height: 16),
                    // Account Balance & Gradient Card
                    _buildAccountCard(),

                    const SizedBox(height: 20),
                    // Quick Actions Section
                    _buildQuickActionsSection(),

                    const SizedBox(height: 20),
                    // Promotional Banner Carousel
                    _buildPromoBanner(),

                    const SizedBox(height: 20),
                    // My Bundles Section
                    _buildMyBundlesSection(),

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
  // 1. TOP HEADER (Lyca Logo + Notifications & Profile)
  // ---------------------------------------------------------------------------
  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    painter: DashboardHeartPainter(),
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

        // Action Icons (Bell & Profile)
        Row(
          children: [
            // Bell Button with Notification Dot
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF081C42),
                    size: 22,
                  ),
                  Positioned(
                    top: 10,
                    right: 11,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF3B30),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Profile Button
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: Color(0xFF081C42),
                size: 22,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. ACCOUNT CARD (Gradient Container + Balance Stats & Buttons)
  // ---------------------------------------------------------------------------
  Widget _buildAccountCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF052B4D),
            Color(0xFF005370),
            Color(0xFF007572),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF005370).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Decorative Green Heart Flourish
          Positioned(
            right: -20,
            bottom: 40,
            child: Opacity(
              opacity: 0.35,
              child: SizedBox(
                width: 160,
                height: 160,
                child: CustomPaint(
                  painter: CardBackgroundHeartPainter(),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting & Active Badge Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Good morning,',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Nathan',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),

                    // Active Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C88C).withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF00FFB3).withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.circle,
                            size: 7,
                            color: Color(0xFF00FFB3),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Active',
                            style: TextStyle(
                              color: Color(0xFF00FFB3),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Phone Number with arrow
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '+256 7XX XXX XXX',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Inner White Card containing Balance Stats & Action Buttons
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Balance Details Row (Data | Airtime | SMS)
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            // 1. Data Stat
                            Expanded(
                              child: _buildStatItem(
                                icon: Icons.language_rounded,
                                label: 'Data',
                                value: '8.4 GB',
                                subtext: 'Expires 28 Oct 2025',
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.withValues(alpha: 0.25),
                              thickness: 1,
                              width: 16,
                            ),

                            // 2. Airtime Stat
                            Expanded(
                              child: _buildStatItem(
                                icon: Icons.phone_in_talk_outlined,
                                label: 'Airtime',
                                value: 'UGX 25,000',
                                subtext: 'Valid for 30 days',
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.grey.withValues(alpha: 0.25),
                              thickness: 1,
                              width: 16,
                            ),

                            // 3. SMS Stat
                            Expanded(
                              child: _buildStatItem(
                                icon: Icons.chat_bubble_outline_rounded,
                                label: 'SMS',
                                value: '150',
                                subtext: 'Valid for 30 days',
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Action Buttons Row
                      Row(
                        children: [
                          // Buy Bundle Button (Solid Green)
                          Expanded(
                            child: SizedBox(
                              height: 42,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF008C75),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PaymentProcessingScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.layers_rounded, size: 18),
                                    SizedBox(width: 6),
                                    Text(
                                      'Buy Bundle',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Buy Airtime Button (Outlined Green)
                          Expanded(
                            child: SizedBox(
                              height: 42,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF008C75),
                                  side: const BorderSide(
                                    color: Color(0xFF008C75),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.account_balance_wallet_outlined, size: 18),
                                    SizedBox(width: 6),
                                    Text(
                                      'Buy Airtime',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required String subtext,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: const Color(0xFF008C75),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF5A6E85),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF081C42),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtext,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF8A9AAD),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 3. QUICK ACTIONS SECTION
  // ---------------------------------------------------------------------------
  Widget _buildQuickActionsSection() {
    return Column(
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF081C42),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: const [
                  Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF00529C),
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                    color: Color(0xFF00529C),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Grid 2x4
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.92,
          children: [
            _buildQuickActionTile(
              icon: Icons.phonelink_ring_rounded,
              label: 'Send Airtime',
              color: const Color(0xFF00B286),
            ),
            _buildQuickActionTile(
              icon: Icons.language_rounded,
              label: 'Buy Bundles',
              color: const Color(0xFF007AFF),
            ),
            _buildQuickActionTile(
              icon: Icons.storefront_rounded,
              label: 'Pay Merchant',
              color: const Color(0xFF6C5CE7),
            ),
            _buildQuickActionTile(
              icon: Icons.account_balance_wallet_rounded,
              label: 'Withdraw Cash',
              color: const Color(0xFFFF9500),
            ),
            _buildQuickActionTile(
              icon: Icons.flight_takeoff_rounded,
              label: 'International',
              color: const Color(0xFF00C7FF),
            ),
            _buildQuickActionTile(
              icon: Icons.local_offer_rounded,
              label: 'Offers',
              color: const Color(0xFFFF3B30),
            ),
            _buildQuickActionTile(
              icon: Icons.bar_chart_rounded,
              label: 'Usage',
              color: const Color(0xFF00A896),
            ),
            _buildQuickActionTile(
              icon: Icons.grid_view_rounded,
              label: 'More',
              color: const Color(0xFF5A6E85),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionTile({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFEBF0F5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 22,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF081C42),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. PROMOTIONAL BANNER
  // ---------------------------------------------------------------------------
  Widget _buildPromoBanner() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF081C42),
                Color(0xFF004068),
                Color(0xFF00666C),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Right Side Vector Illustration / Decorative Background
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: 180,
                  child: CustomPaint(
                    painter: PromoBannerPainter(),
                  ),
                ),

                // Left Banner Text & Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 14.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'STAY CONNECTED',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF00FFB3),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Better Data. More Value.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Get the best bundles for your\ninternet, calls and more.',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // CTA Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D09C),
                          foregroundColor: const Color(0xFF081C42),
                          elevation: 0,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Explore Bundles',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 13,
                              color: Color(0xFF081C42),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Carousel Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Color(0xFF00C88C),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: const Color(0xFF00529C).withValues(alpha: 0.35),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: const Color(0xFF00529C).withValues(alpha: 0.35),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 5. MY BUNDLES SECTION
  // ---------------------------------------------------------------------------
  Widget _buildMyBundlesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEBF0F5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Section Header inside card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.layers_rounded,
                    size: 18,
                    color: Color(0xFF081C42),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'My Bundles',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF081C42),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00529C),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Bundle Item Row
          Row(
            children: [
              // Icon Container
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0F7F1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.language_rounded,
                  color: Color(0xFF00A878),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Title and Expiry Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '10 GB Data Bundle',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF081C42),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Expires 28 Oct 2025',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8A9AAD),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Remaining Badge & Chevron
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F7F1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  '8.4 GB left',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF00A878),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF8A9AAD),
                size: 20,
              ),
            ],
          ),
        ],
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
                    icon: Icons.grid_view_rounded,
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
    final activeColor = const Color(0xFF00A878);
    final inactiveColor = const Color(0xFF8A9AAD);

    return InkWell(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
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

// =============================================================================
// CUSTOM PAINTERS
// =============================================================================

/// Custom painter for the small Lyca Heart emblem in header
class DashboardHeartPainter extends CustomPainter {
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

/// Custom painter for decorative background heart flourish on card
class CardBackgroundHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final greenPaint = Paint()
      ..color = const Color(0xFF00C88C)
      ..style = PaintingStyle.fill;

    final heartPath = Path();
    final w = size.width;
    final h = size.height;

    final topCenter = Offset(w * 0.5, h * 0.3);
    final bottomTip = Offset(w * 0.5, h * 0.9);

    heartPath.moveTo(topCenter.dx, topCenter.dy);

    heartPath.cubicTo(
      0, 0,
      0, h * 0.6,
      bottomTip.dx, bottomTip.dy,
    );

    heartPath.cubicTo(
      w, h * 0.6,
      w, 0,
      topCenter.dx, topCenter.dy,
    );

    canvas.drawPath(heartPath, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for promo banner artwork (Heart flourish + Person Silhouette holding phone)
class PromoBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Green Background Heart Shape
    final greenPaint = Paint()
      ..color = const Color(0xFF00C88C)
      ..style = PaintingStyle.fill;

    final heartPath = Path();
    heartPath.moveTo(w * 0.5, h * 0.2);
    heartPath.cubicTo(w * 0.1, h * 0.0, w * 0.1, h * 0.7, w * 0.5, h * 0.95);
    heartPath.cubicTo(w * 0.9, h * 0.7, w * 0.9, h * 0.0, w * 0.5, h * 0.2);
    canvas.drawPath(heartPath, greenPaint);

    // Person Silhouette holding Phone
    final skinPaint = Paint()
      ..color = const Color(0xFF5D3A20)
      ..style = PaintingStyle.fill;

    final shirtPaint = Paint()
      ..color = const Color(0xFF00523C)
      ..style = PaintingStyle.fill;

    final phonePaint = Paint()
      ..color = const Color(0xFF2C2C2E)
      ..style = PaintingStyle.fill;

    final hairPaint = Paint()
      ..color = const Color(0xFF1C1C1E)
      ..style = PaintingStyle.fill;

    // Head
    canvas.drawCircle(Offset(w * 0.65, h * 0.32), 16, skinPaint);

    // Hair
    final hairPath = Path();
    hairPath.addArc(
      Rect.fromCircle(center: Offset(w * 0.65, h * 0.30), radius: 17),
      3.14,
      3.14,
    );
    canvas.drawPath(hairPath, hairPaint);

    // Body / Hoodie
    final bodyPath = Path();
    bodyPath.moveTo(w * 0.45, h);
    bodyPath.lineTo(w * 0.55, h * 0.52);
    bodyPath.cubicTo(w * 0.60, h * 0.48, w * 0.70, h * 0.48, w * 0.75, h * 0.52);
    bodyPath.lineTo(w * 0.90, h);
    bodyPath.close();
    canvas.drawPath(bodyPath, shirtPaint);

    // Phone in hand
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.38, h * 0.58, 16, 28),
      const Radius.circular(3),
    );
    canvas.drawRRect(phoneRect, phonePaint);

    // Hand holding phone
    canvas.drawCircle(Offset(w * 0.42, h * 0.72), 6, skinPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
