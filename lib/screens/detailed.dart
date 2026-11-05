import 'package:flutter/material.dart';
import 'support.dart';
import 'wallet.dart';

class DetailedScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;

  const DetailedScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
  });

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  int _selectedNavIndex = 3; // 3 = More tab active
  String _selectedLanguage = 'English';
  bool _pushNotifications = true;
  bool _smsNotifications = true;
  bool _emailNotifications = false;

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
      backgroundColor: const Color(0xFFF4F6F9),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Scrollable Body Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Top Device Status Bar (Mocked to match design)
                    _buildStatusBar(),

                    const SizedBox(height: 12),

                    // Brand Header & Settings
                    _buildTopHeader(),

                    const SizedBox(height: 20),

                    // Profile Summary Card
                    _buildProfileSection(),

                    const SizedBox(height: 24),

                    // Section 1: My Account
                    _buildMyAccountSection(),

                    const SizedBox(height: 20),

                    // Section 2: Services
                    _buildServicesSection(),

                    const SizedBox(height: 20),

                    // Section 3: About Lyca Mobile
                    _buildAboutSection(),

                    const SizedBox(height: 24),

                    // Log Out Button
                    _buildLogOutButton(),

                    const SizedBox(height: 28),
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
  // MOCK STATUS BAR (10:24, WiFi, Signal, Battery)
  // ---------------------------------------------------------------------------
  Widget _buildStatusBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '10:24',
            style: TextStyle(
              color: Color(0xFF0C2147),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.signal_cellular_alt_rounded,
                color: Color(0xFF0C2147),
                size: 18,
              ),
              SizedBox(width: 6),
              Icon(
                Icons.wifi_rounded,
                color: Color(0xFF0C2147),
                size: 18,
              ),
              SizedBox(width: 6),
              Icon(
                Icons.battery_full_rounded,
                color: Color(0xFF0C2147),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BRAND HEADER & SETTINGS
  // ---------------------------------------------------------------------------
  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    color: Color(0xFF0C2147),
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(width: 4),
                // Cyan Heart Accent Logo element
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00E5A3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFF00C896),
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              'Mobile',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0C2147),
                height: 0.9,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Connect your world',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),

        // Settings Icon
        InkWell(
          onTap: () {
            _showSettingsSheet();
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF0C2147),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // PROFILE SUMMARY SECTION
  // ---------------------------------------------------------------------------
  Widget _buildProfileSection() {
    return InkWell(
      onTap: () {
        _showProfileDetailsSheet();
      },
      borderRadius: BorderRadius.circular(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFF081C38),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'AN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // User Info & Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nathan Hamidu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C2147),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '+256 7XX XXX XXX',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF0C2147),
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Active Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA7F3D0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF065F46),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Active',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF065F46),
                        ),
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

  // ---------------------------------------------------------------------------
  // SECTION 1: MY ACCOUNT
  // ---------------------------------------------------------------------------
  Widget _buildMyAccountSection() {
    return _buildSectionCard(
      title: 'My Account',
      children: [
        _buildListTile(
          icon: Icons.person_outline_rounded,
          title: 'Profile & Settings',
          onTap: () => _showProfileDetailsSheet(),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.description_outlined,
          title: 'SIM Management',
          onTap: () => _showSimManagementSheet(),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.account_balance_wallet_outlined,
          title: 'My Plans & Bundles',
          onTap: () => _showPlansSheet(),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.notifications_none_rounded,
          title: 'Notification Preferences',
          onTap: () => _showNotificationsSheet(),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.language_rounded,
          title: 'Language',
          trailingText: _selectedLanguage,
          onTap: () => _showLanguagePicker(),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 2: SERVICES
  // ---------------------------------------------------------------------------
  Widget _buildServicesSection() {
    return _buildSectionCard(
      title: 'Services',
      children: [
        _buildListTile(
          icon: Icons.phone_outlined,
          title: 'International Calling',
          onTap: () => _showServiceDetail('International Calling'),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.language_rounded,
          title: 'Roaming',
          onTap: () => _showServiceDetail('Roaming Services'),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.developer_board_rounded,
          title: 'eSIM',
          onTap: () => _showServiceDetail('eSIM Activation & Management'),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.school_outlined,
          title: 'School Fees',
          onTap: () => _showServiceDetail('School Fees Payment'),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.loyalty_outlined,
          title: 'Lyca Rewards',
          onTap: () => _showServiceDetail('Lyca Rewards Program'),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 3: ABOUT LYCA MOBILE
  // ---------------------------------------------------------------------------
  Widget _buildAboutSection() {
    return _buildSectionCard(
      title: 'About Lyca Mobile',
      children: [
        _buildListTile(
          icon: Icons.link_rounded,
          title: 'Terms & Conditions',
          onTap: () => _showInfoModal('Terms & Conditions',
              'By using Lyca Mobile services, you agree to our standard terms and conditions regarding network usage, data rates, and account management.'),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.shield_outlined,
          title: 'Privacy Policy',
          onTap: () => _showInfoModal('Privacy Policy',
              'Your privacy is important to us. Lyca Mobile protects your personal data in accordance with international data protection regulations.'),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.info_outline_rounded,
          title: 'About Us',
          onTap: () => _showInfoModal('About Us',
              'Lyca Mobile is the world\'s largest international Mobile Virtual Network Operator (MVNO), providing low-cost, high-quality data and voice services to millions of customers globally.'),
        ),
        _buildDivider(),
        _buildListTile(
          icon: Icons.info_outline_rounded,
          title: 'App Version',
          trailingText: 'v1.0.0',
          showChevron: false,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lyca Mobile App Version 1.0.0 is up to date.'),
              duration: Duration(seconds: 2),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // LOG OUT BUTTON
  // ---------------------------------------------------------------------------
  Widget _buildLogOutButton() {
    return InkWell(
      onTap: () {
        _showLogOutDialog();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF00A878),
            width: 1.5,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              color: Color(0xFFFE346E),
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Log Out',
              style: TextStyle(
                color: Color(0xFFFE346E),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // REUSABLE CARD CONTAINER & LIST TILE HELPER WIDGETS
  // ---------------------------------------------------------------------------
  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C2147),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE2E8F0).withValues(alpha: 0.8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? trailingText,
    bool showChevron = true,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF0C2147),
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0C2147),
                ),
              ),
            ),
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
              if (showChevron) const SizedBox(width: 4),
            ],
            if (showChevron)
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF94A3B8),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.8,
      color: Color(0xFFF1F5F9),
      indent: 52,
      endIndent: 16,
    );
  }

  // ---------------------------------------------------------------------------
  // BOTTOM NAVIGATION BAR
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
    const activeColor = Color(0xFF00A878);
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
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
          const SizedBox(height: 4),

          // Active Line Indicator below "More"
          Container(
            height: 3,
            width: 32,
            decoration: BoxDecoration(
              color: isSelected ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INTERACTIVE BOTTOM SHEETS & DIALOGS
  // ---------------------------------------------------------------------------
  void _showProfileDetailsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFF081C38),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'AN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nathan Hamidu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0C2147),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '+256 7XX XXX XXX',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Account Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C2147),
                ),
              ),
              const SizedBox(height: 12),
              _buildDetailRow('Account Status', 'Active', Colors.green),
              _buildDetailRow('SIM Type', 'Prepaid Physical SIM', null),
              _buildDetailRow('Registered Name', 'Nathan Hamidu', null),
              _buildDetailRow('NIN / ID Status', 'Verified', Colors.blue),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A878),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, Color? valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? const Color(0xFF0C2147),
            ),
          ),
        ],
      ),
    );
  }

  void _showSimManagementSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SIM Management',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C2147),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.swap_calls_rounded,
                  color: Color(0xFF00A878)),
              title: const Text('Swap / Replace SIM'),
              subtitle: const Text('Request a new physical SIM card'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('SIM Swap request initiated.')),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.phonelink_setup, color: Color(0xFF00A878)),
              title: const Text('Convert to eSIM'),
              subtitle: const Text('Upgrade your physical SIM to eSIM'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('eSIM conversion workflow opened.')),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.block_rounded, color: Colors.redAccent),
              title: const Text('Report Stolen / Block SIM'),
              subtitle:
                  const Text('Temporarily block your SIM for security'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Contact support to block your SIM.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPlansSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Bundles & Subscriptions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C2147),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Monthly Mega Data 10GB',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C2147)),
                  ),
                  SizedBox(height: 4),
                  Text('4.2 GB remaining • Expires in 12 days',
                      style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A878),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Buy New Bundle',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notification Preferences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C2147),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('Receive bundle & offer alerts'),
                value: _pushNotifications,
                activeTrackColor: const Color(0xFF00A878),
                onChanged: (val) {
                  setSheetState(() => _pushNotifications = val);
                  setState(() => _pushNotifications = val);
                },
              ),
              SwitchListTile(
                title: const Text('SMS Notifications'),
                subtitle: const Text('Receive balance and top-up receipts'),
                value: _smsNotifications,
                activeTrackColor: const Color(0xFF00A878),
                onChanged: (val) {
                  setSheetState(() => _smsNotifications = val);
                  setState(() => _smsNotifications = val);
                },
              ),
              SwitchListTile(
                title: const Text('Email Marketing'),
                subtitle: const Text('Newsletters and promotional offers'),
                value: _emailNotifications,
                activeTrackColor: const Color(0xFF00A878),
                onChanged: (val) {
                  setSheetState(() => _emailNotifications = val);
                  setState(() => _emailNotifications = val);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final languages = ['English', 'Luganda', 'Swahili', 'French'];
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C2147),
                ),
              ),
              const SizedBox(height: 12),
              ...languages.map(
                (lang) => ListTile(
                  title: Text(lang),
                  trailing: _selectedLanguage == lang
                      ? const Icon(Icons.check_circle_rounded,
                          color: Color(0xFF00A878))
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = lang;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showServiceDetail(String title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C2147),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Manage and configure options for $title. Access rates, packages, and instant activation.',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A878),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Proceed',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoModal(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF0C2147),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(color: Color(0xFF475569), height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF00A878),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C2147),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.security, color: Color(0xFF00A878)),
              title: const Text('Security & Biometrics'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading:
                  const Icon(Icons.dark_mode_outlined, color: Color(0xFF00A878)),
              title: const Text('Theme Options'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.cleaning_services_rounded,
                  color: Color(0xFF00A878)),
              title: const Text('Clear App Cache'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('App cache cleared.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Log Out',
          style: TextStyle(
            color: Color(0xFF0C2147),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out of your Lyca Mobile account?',
          style: TextStyle(color: Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF64748B)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFE346E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              if (widget.onBackToHome != null) {
                widget.onBackToHome!();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully.'),
                  backgroundColor: Color(0xFF0C2147),
                ),
              );
            },
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
