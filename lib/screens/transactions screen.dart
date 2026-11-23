import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'wallet.dart';
import 'support.dart';

class TransactionsScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;

  const TransactionsScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
  });

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedNavIndex = 3; // 3 = More active as per reference photo

  final List<String> _categories = ['All', 'Airtime', 'Data', 'Payments'];

  final List<_TransactionItem> _allTransactions = [
    _TransactionItem(
      type: 'Data',
      title: 'Data Bundle',
      subtitle: '10 GB • 30 Days',
      amount: 'UGX 15,000',
      date: 'Today',
      time: '3:45 PM',
      status: 'Success',
      iconBgColor: const Color(0xFFF3E8FF),
      iconColor: const Color(0xFF9136DB),
      icon: Icons.data_usage_rounded,
    ),
    _TransactionItem(
      type: 'Airtime',
      title: 'Airtime Top-up',
      subtitle: null,
      amount: 'UGX 5,000',
      date: 'Today',
      time: '1:20 PM',
      status: 'Success',
      iconBgColor: const Color(0xFFFFF3E0),
      iconColor: const Color(0xFFF59E0B),
      icon: Icons.phone_rounded,
    ),
    _TransactionItem(
      type: 'Airtime',
      title: 'Airtime Transfer',
      subtitle: '+256 776 123456',
      amount: 'UGX 5,000',
      date: 'Yesterday',
      time: '5:12 PM',
      status: 'Success',
      iconBgColor: const Color(0xFFEBF3FE),
      iconColor: const Color(0xFF1D61E7),
      icon: Icons.swap_horiz_rounded,
    ),
    _TransactionItem(
      type: 'Payments',
      title: 'Payment',
      subtitle: 'Card Payment',
      amount: 'UGX 20,000',
      date: '16 Nov',
      time: '2:30 PM',
      status: 'Success',
      iconBgColor: const Color(0xFFE6F7ED),
      iconColor: const Color(0xFF00B074),
      icon: Icons.storefront_rounded,
    ),
    _TransactionItem(
      type: 'Data',
      title: 'Combo Bundle',
      subtitle: '5 GB + 100 Min',
      amount: 'UGX 12,000',
      date: '15 Nov',
      time: '6:17 PM',
      status: 'Success',
      iconBgColor: const Color(0xFFF3E8FF),
      iconColor: const Color(0xFF9136DB),
      icon: Icons.all_inbox_rounded,
    ),
  ];

  List<_TransactionItem> get _filteredTransactions {
    if (_selectedCategoryIndex == 0) {
      return _allTransactions;
    }
    final selectedCategory = _categories[_selectedCategoryIndex];
    return _allTransactions
        .where((t) => t.type.toLowerCase() == selectedCategory.toLowerCase())
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

  void _handleNavTap(int index) {
    if (index == 0) {
      if (widget.onBackToHome != null) {
        widget.onBackToHome!();
      } else if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        setState(() {
          _selectedNavIndex = 0;
        });
      }
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
    if (_selectedNavIndex == 0) {
      return const DashboardScreen();
    }
    if (_selectedNavIndex == 1) {
      return WalletScreen(
        onBackToHome: () {
          setState(() {
            _selectedNavIndex = 3;
          });
        },
      );
    }
    if (_selectedNavIndex == 2) {
      return SupportScreen(
        onBackToHome: () {
          setState(() {
            _selectedNavIndex = 3;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Top Header: Back Arrow + Title
            _buildHeader(),

            const SizedBox(height: 16),

            // Filter Chips Bar (All, Airtime, Data, Payments)
            _buildCategoryFilters(),

            const SizedBox(height: 20),

            // Transactions List
            Expanded(
              child: _filteredTransactions.isEmpty
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: List.generate(_filteredTransactions.length, (index) {
                          final item = _filteredTransactions[index];
                          final isLast = index == _filteredTransactions.length - 1;

                          return Column(
                            children: [
                              _buildTransactionTile(item),
                              if (!isLast)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14.0),
                                  child: Divider(
                                    color: Color(0xFFEEF2F6),
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ),
                            ],
                          );
                        }),
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
  // 1. TOP HEADER BAR
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap: _handleBack,
            borderRadius: BorderRadius.circular(24),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 22,
                color: Color(0xFF071E48),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Transaction History',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF071E48),
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
          const SizedBox(width: 38), // Balance for back button
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. CATEGORY FILTERS (ALL, AIRTIME, DATA, PAYMENTS)
  // ---------------------------------------------------------------------------
  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategoryIndex == index;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF00B074) : const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00B074).withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF071E48),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. TRANSACTION TILE
  // ---------------------------------------------------------------------------
  Widget _buildTransactionTile(_TransactionItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Icon Container
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: item.iconBgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            item.icon,
            color: item.iconColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),

        // Middle Info (Title, Subtitle, Amount)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF071E48),
                  height: 1.2,
                ),
              ),
              if (item.subtitle != null && item.subtitle!.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(
                  item.subtitle!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
              const SizedBox(height: 6),
              Text(
                item.amount,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF071E48),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),

        // Right Info (Date, Time, Status)
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.date,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF071E48),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.time,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 8),

            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.status,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF00B074),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 4. EMPTY STATE
  // ---------------------------------------------------------------------------
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.receipt_long_outlined,
            size: 54,
            color: Color(0xFF94A3B8),
          ),
          SizedBox(height: 12),
          Text(
            'No transactions found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
        ],
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
      onTap: () => _handleNavTap(index),
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

// ---------------------------------------------------------------------------
// DATA CLASS
// ---------------------------------------------------------------------------
class _TransactionItem {
  final String type;
  final String title;
  final String? subtitle;
  final String amount;
  final String date;
  final String time;
  final String status;
  final Color iconBgColor;
  final Color iconColor;
  final IconData icon;

  _TransactionItem({
    required this.type,
    required this.title,
    this.subtitle,
    required this.amount,
    required this.date,
    required this.time,
    required this.status,
    required this.iconBgColor,
    required this.iconColor,
    required this.icon,
  });
}
