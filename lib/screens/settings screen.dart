import 'package:flutter/material.dart';
import 'editprofilescreen.dart';
import 'pin_setup_screen.dart';
import 'notification screen.dart';
import 'support.dart';
import 'wallet.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;

  const SettingsScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedNavIndex = 3; // 3 = More tab active

  // Toggle states
  bool _biometricEnabled = true;
  bool _notificationsEnabled = true;

  // Selected Preferences
  String _selectedLanguage = 'English';
  String _selectedAppearance = 'Light';

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
        child: Column(
          children: [
            // Top Header Bar
            _buildHeader(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Section 1: Account Settings
                    _buildSectionHeader('Account Settings'),
                    const SizedBox(height: 8),
                    _buildSettingItem(
                      icon: Icons.person_rounded,
                      title: 'Profile & Personal Info',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.lock_rounded,
                      title: 'Security & PIN',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PinSetupScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.fingerprint_rounded,
                      title: 'Biometric Login',
                      trailing: Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: _biometricEnabled,
                          activeTrackColor: const Color(0xFF00C853),
                          activeThumbColor: Colors.white,
                          inactiveTrackColor: const Color(0xFFE2E8F0),
                          inactiveThumbColor: Colors.white,
                          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                          onChanged: (val) {
                            setState(() {
                              _biometricEnabled = val;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  val ? 'Biometric Login Enabled' : 'Biometric Login Disabled',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Section 2: App Preferences
                    _buildSectionHeader('App Preferences'),
                    const SizedBox(height: 8),
                    _buildSettingItem(
                      icon: Icons.notifications_rounded,
                      title: 'Notifications',
                      trailing: Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: _notificationsEnabled,
                          activeTrackColor: const Color(0xFF00C853),
                          activeThumbColor: Colors.white,
                          inactiveTrackColor: const Color(0xFFE2E8F0),
                          inactiveThumbColor: Colors.white,
                          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                          onChanged: (val) {
                            setState(() {
                              _notificationsEnabled = val;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  val ? 'Notifications Enabled' : 'Notifications Disabled',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.language_rounded,
                      title: 'Language',
                      valueText: _selectedLanguage,
                      onTap: _showLanguageDialog,
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.contrast_rounded,
                      title: 'Appearance',
                      valueText: _selectedAppearance,
                      onTap: _showAppearanceDialog,
                    ),

                    const SizedBox(height: 24),

                    // Section 3: More
                    _buildSectionHeader('More'),
                    const SizedBox(height: 8),
                    _buildSettingItem(
                      icon: Icons.help_rounded,
                      title: 'Help & Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SupportScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.description_rounded,
                      title: 'Terms & Conditions',
                      onTap: _showTermsDialog,
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      icon: Icons.security_rounded,
                      title: 'Privacy Policy',
                      onTap: _showPrivacyDialog,
                    ),

                    const SizedBox(height: 32),
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
  // HEADER
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 20.0, top: 12.0, bottom: 12.0),
      child: Row(
        children: [
          IconButton(
            onPressed: _handleBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF001845),
              size: 24,
            ),
            splashRadius: 24,
          ),
          const SizedBox(width: 8),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001845),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION HEADER
  // ---------------------------------------------------------------------------
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF001845),
          letterSpacing: -0.2,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SETTING ITEM ROW
  // ---------------------------------------------------------------------------
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? valueText,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.black.withValues(alpha: 0.03),
      highlightColor: Colors.black.withValues(alpha: 0.01),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
        child: Row(
          children: [
            // Icon
            Icon(
              icon,
              color: const Color(0xFF0052CC),
              size: 22,
            ),
            const SizedBox(width: 20),

            // Title Text
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF001845),
                  letterSpacing: -0.2,
                ),
              ),
            ),

            // Value Text (if any)
            if (valueText != null) ...[
              Text(
                valueText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A607A),
                ),
              ),
              const SizedBox(width: 6),
            ],

            // Trailing Widget or Chevron
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF001845),
                  size: 22,
                ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DIVIDER
  // ---------------------------------------------------------------------------
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 66.0, right: 24.0),
      child: Divider(
        height: 1,
        thickness: 0.6,
        color: Color(0xFFF1F5F9),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DIALOGS & MODALS
  // ---------------------------------------------------------------------------
  void _showLanguageDialog() {
    final languages = ['English', 'French', 'Swahili', 'Luganda', 'Arabic'];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001845),
                ),
              ),
              const SizedBox(height: 12),
              ...languages.map(
                (lang) => ListTile(
                  title: Text(
                    lang,
                    style: TextStyle(
                      fontWeight: lang == _selectedLanguage ? FontWeight.bold : FontWeight.normal,
                      color: const Color(0xFF001845),
                    ),
                  ),
                  trailing: lang == _selectedLanguage
                      ? const Icon(Icons.check_circle, color: Color(0xFF00C853))
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = lang;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showAppearanceDialog() {
    final themes = ['Light', 'Dark', 'System Default'];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Appearance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001845),
                ),
              ),
              const SizedBox(height: 12),
              ...themes.map(
                (theme) => ListTile(
                  title: Text(
                    theme,
                    style: TextStyle(
                      fontWeight: theme == _selectedAppearance ? FontWeight.bold : FontWeight.normal,
                      color: const Color(0xFF001845),
                    ),
                  ),
                  trailing: theme == _selectedAppearance
                      ? const Icon(Icons.check_circle, color: Color(0xFF00C853))
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedAppearance = theme;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(color: Color(0xFF001845), fontWeight: FontWeight.bold),
        ),
        content: const SingleChildScrollView(
          child: Text(
            'By using Lyca Mobile services, you agree to comply with our standard terms of service, including account security, data usage policies, and subscription terms.',
            style: TextStyle(color: Color(0xFF4A607A), fontSize: 14, height: 1.4),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF0052CC), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Color(0xFF001845), fontWeight: FontWeight.bold),
        ),
        content: const SingleChildScrollView(
          child: Text(
            'Your privacy is important to us. Lyca Mobile collects minimum necessary data to provide connectivity services and ensures your details are never shared with unauthorized third parties.',
            style: TextStyle(color: Color(0xFF4A607A), fontSize: 14, height: 1.4),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF0052CC), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
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
