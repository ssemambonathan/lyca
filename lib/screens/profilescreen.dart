import 'package:flutter/material.dart';
import 'editprofilescreen.dart';
import 'sim managment screen.dart';
import 'support.dart';
import 'wallet.dart';
import 'notification screen.dart';
import 'settings screen.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;

  const ProfileScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedNavIndex = 3; // 3 = More / Profile tab active

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

  void _handleBack() {
    if (widget.onBackToHome != null) {
      widget.onBackToHome!();
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else if (widget.onSelectTab != null) {
      widget.onSelectTab!(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedNavIndex == 1) {
      return WalletScreen(
        onBackToHome: () {
          if (widget.onBackToHome != null) {
            widget.onBackToHome!();
          } else {
            setState(() {
              _selectedNavIndex = 0;
            });
          }
        },
      );
    }

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Top Bar + Hero Gradient Header Banner + Profile Picture
                    _buildHeaderSection(),

                    const SizedBox(height: 12),

                    // User Info: Name, Phone & Verified Pill
                    _buildUserInfoSection(),

                    const SizedBox(height: 20),

                    // Account Status Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _buildAccountStatusCard(),
                    ),

                    const SizedBox(height: 24),

                    // Menu Options List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _buildMenuItemsList(),
                    ),

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
  // 1. TOP HEADER SECTION (Top Bar + Curved Gradient Banner + Avatar)
  // ---------------------------------------------------------------------------
  Widget _buildHeaderSection() {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Wave Curved Gradient Background Banner
        ClipPath(
          clipper: HeaderWaveClipper(),
          child: Container(
            height: 210 + topPadding,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF031644), // Deep Lyca Navy
                  Color(0xFF093175), // Rich Royal Navy
                  Color(0xFF009688), // Teal Green Wave Transition
                  Color(0xFF00C853), // Vibrant Green Flourish Edge
                ],
                stops: [0.0, 0.45, 0.82, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Soft Cyan/Green Glowing Circle Flourish (Top Right)
                Positioned(
                  top: -20,
                  right: -30,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF00E676).withValues(alpha: 0.35),
                          const Color(0xFF00B0FF).withValues(alpha: 0.15),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),

                // Lyca Mobile Brand Logo in Banner Center
                Positioned(
                  top: topPadding + 44,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: _buildLycaLogo(),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Top Navigation Bar (Back Arrow, Title "Profile", Gear Icon)
        Positioned(
          top: topPadding + 4,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              IconButton(
                onPressed: _handleBack,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF0A1C3F),
                  size: 24,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),

              // Title "Profile"
              const Text(
                'Profile',
                style: TextStyle(
                  color: Color(0xFF0A1C3F),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),

              // Settings Gear Button
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Color(0xFF0A1C3F),
                  size: 24,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),

        // Profile Avatar Overlapping the Banner Wave
        Positioned(
          bottom: -48,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
              },
              child: Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE2EDFF), // Soft Halo Glow Border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD6E4FF), // Inner Soft Lavender/Blue Circle
                  ),
                  child: ClipOval(
                    child: CustomPaint(
                      painter: AvatarSilhouettePainter(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // LYCA MOBILE LOGO WITH ICONIC DOUBLE HEART
  // ---------------------------------------------------------------------------
  Widget _buildLycaLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Lyca',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 4),
                // Overlapping Cyan & Green Heart Icon
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CustomPaint(
                    painter: LycaHeartPainter(),
                  ),
                ),
              ],
            ),
            const Text(
              'Mobile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                height: 1.1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. USER INFO SECTION (Name, Phone Number, Verified Badge)
  // ---------------------------------------------------------------------------
  Widget _buildUserInfoSection() {
    return Column(
      children: [
        const SizedBox(height: 48), // Spacing for avatar overlap
        const Text(
          'Nathan Ssemmambo',
          style: TextStyle(
            color: Color(0xFF0A1C3F),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '+256 772 345678',
          style: TextStyle(
            color: Color(0xFF1E3A6E),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 10),
        // Verified Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFD2F7E2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF00C853),
                size: 18,
              ),
              SizedBox(width: 5),
              Text(
                'Verified',
                style: TextStyle(
                  color: Color(0xFF00A651),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 3. ACCOUNT STATUS CARD
  // ---------------------------------------------------------------------------
  Widget _buildAccountStatusCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Green Circular Checkmark Icon Badge
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF00E676),
                  Color(0xFF00C853),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x4000C853),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),

          // Account Status & Active Label
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Account Status',
                  style: TextStyle(
                    color: Color(0xFF3B5278),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Active',
                  style: TextStyle(
                    color: Color(0xFF00C853),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Status Right Details (Active / Since Jan 2024)
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Active',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Since Jan 2024',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. MENU ITEMS LIST
  // ---------------------------------------------------------------------------
  Widget _buildMenuItemsList() {
    final menuItems = [
      _MenuItemData(
        icon: Icons.person_rounded,
        title: 'My Information',
        chevronColor: const Color(0xFF0A1C3F),
      ),
      _MenuItemData(
        icon: Icons.sim_card_download_rounded,
        title: 'SIM Management',
        chevronColor: const Color(0xFF009688),
      ),
      _MenuItemData(
        icon: Icons.shield_rounded,
        title: 'Security',
        chevronColor: const Color(0xFF009688),
      ),
      _MenuItemData(
        icon: Icons.notifications_rounded,
        title: 'Notifications',
        chevronColor: const Color(0xFF009688),
      ),
      _MenuItemData(
        icon: Icons.language_rounded,
        title: 'Language',
        chevronColor: const Color(0xFF0A1C3F),
      ),
      _MenuItemData(
        icon: Icons.info_rounded,
        title: 'About Lyca',
        chevronColor: const Color(0xFF009688),
      ),
    ];

    return Column(
      children: menuItems.map((item) => _buildMenuItemRow(item)).toList(),
    );
  }

  Widget _buildMenuItemRow(_MenuItemData item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            if (item.title == 'My Information') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            } else if (item.title == 'SIM Management') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimManagementScreen(),
                ),
              );
            } else if (item.title == 'Notifications') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreen(
                    onBackToHome: widget.onBackToHome,
                    onSelectTab: widget.onSelectTab,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.title} tapped'),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Row(
              children: [
                // Icon inside small container
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  child: Icon(
                    item.icon,
                    color: const Color(0xFF0A1C3F),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Title
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: Color(0xFF0A1C3F),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),

                // Chevron Arrow Right
                Icon(
                  Icons.chevron_right_rounded,
                  color: item.chevronColor,
                  size: 26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 5. BOTTOM NAVIGATION BAR
  // ---------------------------------------------------------------------------
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_rounded, 'Home'),
              _buildNavItem(1, Icons.account_balance_wallet_rounded, 'Wallet'),
              _buildNavItem(2, Icons.support_agent_rounded, 'Support'),
              _buildNavItem(3, Icons.density_medium_rounded, 'More'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData iconData, String label) {
    final bool isActive = _selectedNavIndex == index;
    final Color activeColor = const Color(0xFF00C853);
    final Color inactiveColor = const Color(0xFF475569);

    return InkWell(
      onTap: () => _handleTabTap(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: isActive ? activeColor : inactiveColor,
            size: 24,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: isActive ? activeColor : inactiveColor,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          if (isActive) ...[
            const SizedBox(height: 2),
            Container(
              width: 20,
              height: 2.5,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HELPER MODELS & CUSTOM PAINTERS
// -----------------------------------------------------------------------------
class _MenuItemData {
  final IconData icon;
  final String title;
  final Color chevronColor;

  _MenuItemData({
    required this.icon,
    required this.title,
    required this.chevronColor,
  });
}

/// Custom Wave Clipper for Hero Banner Header
class HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);

    // Left Smooth Dip Curve
    final controlPoint1 = Offset(size.width * 0.28, size.height);
    final endPoint1 = Offset(size.width * 0.52, size.height - 25);
    path.quadraticBezierTo(
      controlPoint1.dx,
      controlPoint1.dy,
      endPoint1.dx,
      endPoint1.dy,
    );

    // Right Rising Curve into Cyan Flourish
    final controlPoint2 = Offset(size.width * 0.78, size.height - 50);
    final endPoint2 = Offset(size.width, size.height - 15);
    path.quadraticBezierTo(
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint2.dx,
      endPoint2.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// Custom Painter for Lyca Double Heart Emblem
class LycaHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintCyan = Paint()
      ..color = const Color(0xFF00B0FF)
      ..style = PaintingStyle.fill;

    final paintGreen = Paint()
      ..color = const Color(0xFF00C853)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Cyan Left Heart
    final pathCyan = Path();
    pathCyan.moveTo(w * 0.35, h * 0.75);
    pathCyan.cubicTo(
      w * 0.1, h * 0.5,
      w * 0.0, h * 0.25,
      w * 0.25, h * 0.15,
    );
    pathCyan.cubicTo(
      w * 0.45, h * 0.08,
      w * 0.5, h * 0.3,
      w * 0.5, h * 0.3,
    );
    pathCyan.cubicTo(
      w * 0.5, h * 0.3,
      w * 0.55, h * 0.08,
      w * 0.75, h * 0.15,
    );
    pathCyan.cubicTo(
      w * 1.0, h * 0.25,
      w * 0.9, h * 0.5,
      w * 0.35, h * 0.75,
    );
    pathCyan.close();

    // Draw Cyan Heart offset left
    canvas.save();
    canvas.translate(-w * 0.1, 0);
    canvas.drawPath(pathCyan, paintCyan);
    canvas.restore();

    // Draw Green Heart offset right
    canvas.save();
    canvas.translate(w * 0.15, -h * 0.1);
    canvas.scale(0.85);
    canvas.drawPath(pathCyan, paintGreen);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Custom Painter for Avatar Silhouette with Pigtails (matching screenshot)
class AvatarSilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintNavy = Paint()
      ..color = const Color(0xFF142B5C)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // 1. Head Circle
    final headRadius = size.width * 0.24;
    final headCenter = Offset(cx, cy - 8);
    canvas.drawCircle(headCenter, headRadius, paintNavy);

    // 2. Left Pigtail / Hair Bun
    canvas.drawCircle(
      Offset(cx - headRadius * 0.85, headCenter.dy - headRadius * 0.45),
      headRadius * 0.45,
      paintNavy,
    );

    // 3. Right Pigtail / Hair Bun
    canvas.drawCircle(
      Offset(cx + headRadius * 0.85, headCenter.dy - headRadius * 0.45),
      headRadius * 0.45,
      paintNavy,
    );

    // 4. Neck & Shoulder Bust Base
    final pathShoulders = Path();
    pathShoulders.moveTo(cx - headRadius * 1.6, size.height);
    pathShoulders.quadraticBezierTo(
      cx - headRadius * 1.2,
      headCenter.dy + headRadius * 0.9,
      cx,
      headCenter.dy + headRadius * 0.85,
    );
    pathShoulders.quadraticBezierTo(
      cx + headRadius * 1.2,
      headCenter.dy + headRadius * 0.9,
      cx + headRadius * 1.6,
      size.height,
    );
    pathShoulders.close();

    canvas.drawPath(pathShoulders, paintNavy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
