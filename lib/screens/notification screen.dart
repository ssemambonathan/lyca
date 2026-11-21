import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final String category; // 'Offers', 'Account', 'System'
  final IconData icon;
  final Color iconColor;
  final Color? iconBackgroundColor;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.category,
    required this.icon,
    required this.iconColor,
    this.iconBackgroundColor,
    this.isRead = false,
  });
}

class NotificationScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;

  const NotificationScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedCategory = 'All';
  int _selectedNavIndex = 3; // 'More' active by default as shown in reference

  late List<NotificationItem> _notifications;

  @override
  void initState() {
    super.initState();
    _resetNotifications();
  }

  void _resetNotifications() {
    _notifications = [
      NotificationItem(
        id: '1',
        title: 'New Offer Available',
        subtitle: 'Get 10 GB for only UGX 10,000',
        time: '2h ago',
        category: 'Offers',
        icon: Icons.card_giftcard_rounded,
        iconColor: const Color(0xFFF59E0B), // Vibrant Gift Box Amber/Orange
      ),
      NotificationItem(
        id: '2',
        title: 'Airtime Recharge',
        subtitle: 'UGX 10,000.00 successful',
        time: '3h ago',
        category: 'Account',
        icon: Icons.check_circle_rounded,
        iconColor: const Color(0xFF00C853), // Green Checkmark
      ),
      NotificationItem(
        id: '3',
        title: 'Your Bundle Expiry',
        subtitle: 'Your 10 GB bundle expires\ntomorrow',
        time: '1d ago',
        category: 'System',
        icon: Icons.info_rounded,
        iconColor: const Color(0xFF2196F3), // Info Blue Circle
      ),
      NotificationItem(
        id: '4',
        title: 'Service Update',
        subtitle: 'Scheduled maintenance\ntomorrow 2AM – 4AM',
        time: '1d ago',
        category: 'System',
        icon: Icons.campaign_rounded,
        iconColor: const Color(0xFFFF3B30), // Megaphone Alert Red
      ),
    ];
  }

  List<NotificationItem> get _filteredNotifications {
    if (_selectedCategory == 'All') {
      return _notifications;
    }
    return _notifications
        .where((item) => item.category.toLowerCase() == _selectedCategory.toLowerCase())
        .toList();
  }

  void _handleBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else if (widget.onBackToHome != null) {
      widget.onBackToHome!();
    } else if (widget.onSelectTab != null) {
      widget.onSelectTab!(0);
    }
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

  void _markAllAsRead() {
    setState(() {
      for (var item in _notifications) {
        item.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearAll() {
    setState(() {
      _notifications.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notifications cleared'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _resetNotifications();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Bar (Back, Title, Bell Icon)
            _buildHeader(),

            const SizedBox(height: 16),

            // Category Filter Chips (All, Offers, Account, System)
            _buildCategoryFilters(),

            const SizedBox(height: 20),

            // Notification List & Actions
            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          // Notification List Items
                          _buildNotificationList(),

                          const SizedBox(height: 28),

                          // Mark All as Read Button
                          _buildMarkAllAsReadButton(),

                          const SizedBox(height: 16),

                          // Clear All Button
                          _buildClearAllButton(),

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
  // 1. TOP HEADER (Back Arrow + Title + Bell Icon)
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 20.0, top: 8.0, bottom: 4.0),
      child: Row(
        children: [
          IconButton(
            onPressed: _handleBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF0C1E3C),
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C1E3C),
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_rounded,
              color: Color(0xFF0C1E3C),
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. CATEGORY FILTER CHIPS
  // ---------------------------------------------------------------------------
  Widget _buildCategoryFilters() {
    final categories = ['All', 'Offers', 'Account', 'System'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: categories.map((cat) {
          final bool isActive = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
                borderRadius: BorderRadius.circular(24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF0B2252) : const Color(0xFFF0F4FA),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: isActive ? Colors.white : const Color(0xFF1E3A6E),
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. NOTIFICATION LIST
  // ---------------------------------------------------------------------------
  Widget _buildNotificationList() {
    final items = _filteredNotifications;

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Center(
          child: Text(
            'No notifications in "$_selectedCategory"',
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF718096),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Column(
      children: items.map((item) => _buildNotificationCardItem(item)).toList(),
    );
  }

  Widget _buildNotificationCardItem(NotificationItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: InkWell(
        onTap: () {
          setState(() {
            item.isRead = !item.isRead;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.topCenter,
              child: Icon(
                item.icon,
                color: item.iconColor,
                size: 32,
              ),
            ),
            const SizedBox(width: 14),

            // Text Content (Title, Subtitle)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0C1E3C),
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF718096),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5C739C),
                      height: 1.35,
                      fontWeight: FontWeight.w400,
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
  // 4. ACTION BUTTONS
  // ---------------------------------------------------------------------------
  Widget _buildMarkAllAsReadButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _markAllAsRead,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE8F1FF), // Light blue button fill
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Mark All as Read',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0052CC), // Vibrant Blue Text
          ),
        ),
      ),
    );
  }

  Widget _buildClearAllButton() {
    return TextButton(
      onPressed: _clearAll,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF0052CC),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.delete_outline_rounded,
            size: 20,
            color: Color(0xFF0052CC),
          ),
          SizedBox(width: 6),
          Text(
            'Clear All',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0052CC),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 5. EMPTY STATE
  // ---------------------------------------------------------------------------
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FA),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_off_outlined,
                size: 40,
                color: Color(0xFF5C739C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0C1E3C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You have cleared all your notifications.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF718096),
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _resetNotifications();
                  _selectedCategory = 'All';
                });
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF0052CC),
                side: const BorderSide(color: Color(0xFF0052CC)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Reset Notifications'),
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
        border: Border(
          top: BorderSide(
            color: Colors.grey.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
    final Color activeColor = const Color(0xFF00C853); // Lyca Green
    final Color inactiveColor = const Color(0xFF0C1E3C);

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
          const SizedBox(height: 2),
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
              width: 18,
              height: 2,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
