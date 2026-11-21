import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'bundlesscreen.dart';

class InternationalCallingScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final ValueChanged<int>? onSelectTab;

  const InternationalCallingScreen({
    super.key,
    this.onBack,
    this.onSelectTab,
  });

  @override
  State<InternationalCallingScreen> createState() =>
      _InternationalCallingScreenState();
}

class _InternationalCallingScreenState
    extends State<InternationalCallingScreen> {
  int _selectedTab = 0; // 0 = Popular, 1 = All Countries
  int _selectedNavIndex = 3; // 3 = More active
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<CountryRate> _popularCountries = const [
    CountryRate(
      code: 'UK',
      name: 'UK',
      flagType: FlagType.uk,
      rate: 'UGX 1,200/min',
      dialCode: '+44',
      isoCode: 'GB',
    ),
    CountryRate(
      code: 'USA',
      name: 'USA',
      flagType: FlagType.usa,
      rate: 'UGX 1,200/min',
      dialCode: '+1',
      isoCode: 'US',
    ),
    CountryRate(
      code: 'Canada',
      name: 'Canada',
      flagType: FlagType.canada,
      rate: 'UGX 1,200/min',
      dialCode: '+1',
      isoCode: 'CA',
    ),
    CountryRate(
      code: 'Kenya',
      name: 'Kenya',
      flagType: FlagType.kenya,
      rate: 'UGX 800/min',
      dialCode: '+254',
      isoCode: 'KE',
    ),
    CountryRate(
      code: 'Tanzania',
      name: 'Tanzania',
      flagType: FlagType.tanzania,
      rate: 'UGX 800/min',
      dialCode: '+255',
      isoCode: 'TZ',
    ),
    CountryRate(
      code: 'India',
      name: 'India',
      flagType: FlagType.india,
      rate: 'UGX 1,000/min',
      dialCode: '+91',
      isoCode: 'IN',
    ),
  ];

  final List<CountryRate> _allCountries = const [
    CountryRate(
      code: 'Canada',
      name: 'Canada',
      flagType: FlagType.canada,
      rate: 'UGX 1,200/min',
      dialCode: '+1',
      isoCode: 'CA',
    ),
    CountryRate(
      code: 'China',
      name: 'China',
      flagType: FlagType.china,
      rate: 'UGX 1,000/min',
      dialCode: '+86',
      isoCode: 'CN',
    ),
    CountryRate(
      code: 'France',
      name: 'France',
      flagType: FlagType.france,
      rate: 'UGX 1,300/min',
      dialCode: '+33',
      isoCode: 'FR',
    ),
    CountryRate(
      code: 'Germany',
      name: 'Germany',
      flagType: FlagType.germany,
      rate: 'UGX 1,300/min',
      dialCode: '+49',
      isoCode: 'DE',
    ),
    CountryRate(
      code: 'India',
      name: 'India',
      flagType: FlagType.india,
      rate: 'UGX 1,000/min',
      dialCode: '+91',
      isoCode: 'IN',
    ),
    CountryRate(
      code: 'Kenya',
      name: 'Kenya',
      flagType: FlagType.kenya,
      rate: 'UGX 800/min',
      dialCode: '+254',
      isoCode: 'KE',
    ),
    CountryRate(
      code: 'Nigeria',
      name: 'Nigeria',
      flagType: FlagType.nigeria,
      rate: 'UGX 900/min',
      dialCode: '+234',
      isoCode: 'NG',
    ),
    CountryRate(
      code: 'Rwanda',
      name: 'Rwanda',
      flagType: FlagType.rwanda,
      rate: 'UGX 750/min',
      dialCode: '+250',
      isoCode: 'RW',
    ),
    CountryRate(
      code: 'Saudi Arabia',
      name: 'Saudi Arabia',
      flagType: FlagType.saudi,
      rate: 'UGX 1,400/min',
      dialCode: '+966',
      isoCode: 'SA',
    ),
    CountryRate(
      code: 'South Africa',
      name: 'South Africa',
      flagType: FlagType.southAfrica,
      rate: 'UGX 1,100/min',
      dialCode: '+27',
      isoCode: 'ZA',
    ),
    CountryRate(
      code: 'Tanzania',
      name: 'Tanzania',
      flagType: FlagType.tanzania,
      rate: 'UGX 800/min',
      dialCode: '+255',
      isoCode: 'TZ',
    ),
    CountryRate(
      code: 'UAE',
      name: 'UAE',
      flagType: FlagType.uae,
      rate: 'UGX 1,500/min',
      dialCode: '+971',
      isoCode: 'AE',
    ),
    CountryRate(
      code: 'UK',
      name: 'UK',
      flagType: FlagType.uk,
      rate: 'UGX 1,200/min',
      dialCode: '+44',
      isoCode: 'GB',
    ),
    CountryRate(
      code: 'USA',
      name: 'USA',
      flagType: FlagType.usa,
      rate: 'UGX 1,200/min',
      dialCode: '+1',
      isoCode: 'US',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void _handleNavTap(int index) {
    if (index == 0 && widget.onBack != null) {
      widget.onBack!();
    } else if (widget.onSelectTab != null) {
      widget.onSelectTab!(index);
    } else {
      setState(() {
        _selectedNavIndex = index;
      });
    }
  }

  List<CountryRate> get _filteredList {
    final baseList = _selectedTab == 0 ? _popularCountries : _allCountries;
    if (_searchQuery.trim().isEmpty) {
      return baseList;
    }
    final query = _searchQuery.toLowerCase().trim();
    return baseList.where((country) {
      return country.name.toLowerCase().contains(query) ||
          country.code.toLowerCase().contains(query) ||
          country.dialCode.contains(query);
    }).toList();
  }

  void _showCountryDetailModal(CountryRate country) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CountryDetailSheet(country: country),
    );
  }

  void _navigateToBundles() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BundlesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header Section
            _buildHeader(),

            // Scrollable Content Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Top Banner: Call the world at great rates
                    _buildPromoBanner(),

                    const SizedBox(height: 16),

                    // Search Country Input Field
                    _buildSearchField(),

                    const SizedBox(height: 16),

                    // Tab Switcher: Popular | All Countries
                    _buildCategoryTabs(),

                    const SizedBox(height: 16),

                    // Country Rates List
                    _buildCountryRatesList(),

                    const SizedBox(height: 12),

                    // International Bundles Banner Card
                    _buildBundlesBannerCard(),

                    const SizedBox(height: 20),
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
  // 1. TOP NAVIGATION HEADER
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: _handleBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF081C42),
              size: 24,
            ),
            splashRadius: 24,
          ),
          const SizedBox(width: 4),
          const Text(
            'International Calling',
            style: TextStyle(
              fontSize: 20,
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
  // 2. PROMOTIONAL BANNER CARD
  // ---------------------------------------------------------------------------
  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF082046),
            Color(0xFF006CAE),
            Color(0xFF00A2D3),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF005691).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Globe & Graphic Painter on Right Side
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              width: 175,
              child: CustomPaint(
                painter: GlobeBannerPainter(),
              ),
            ),

            // Text on Left Side
            Positioned(
              left: 20,
              top: 28,
              bottom: 24,
              right: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Call the world',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'at great rates',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
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
  // 3. SEARCH FIELD
  // ---------------------------------------------------------------------------
  Widget _buildSearchField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: Color(0xFF8E9EAF),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF081C42),
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                hintText: 'Search country...',
                hintStyle: TextStyle(
                  color: Color(0xFF8E9EAF),
                  fontSize: 15,
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
                setState(() {
                  _searchQuery = '';
                });
              },
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFF8E9EAF),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. TAB SELECTOR (POPULAR / ALL COUNTRIES)
  // ---------------------------------------------------------------------------
  Widget _buildCategoryTabs() {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              title: 'Popular',
              index: 0,
            ),
          ),
          Expanded(
            child: _buildTabButton(
              title: 'All Countries',
              index: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required int index,
  }) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00C88C) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF081C42),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 5. COUNTRY RATES LIST
  // ---------------------------------------------------------------------------
  Widget _buildCountryRatesList() {
    final list = _filteredList;

    if (list.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 36),
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 48,
              color: Color(0xFF94A3B8),
            ),
            const SizedBox(height: 12),
            Text(
              'No countries found for "$_searchQuery"',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: list.map((country) {
        return _buildCountryCard(country);
      }).toList(),
    );
  }

  Widget _buildCountryCard(CountryRate country) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEFF3F8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showCountryDetailModal(country),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 13.0,
            ),
            child: Row(
              children: [
                // Flag Icon Badge
                SizedBox(
                  width: 36,
                  height: 36,
                  child: FlagWidget(flagType: country.flagType),
                ),
                const SizedBox(width: 16),

                // Country Name
                Text(
                  country.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF081C42),
                    letterSpacing: -0.2,
                  ),
                ),

                const Spacer(),

                // Call Rate Text
                Text(
                  country.rate,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF081C42),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 6. INTERNATIONAL BUNDLES BANNER CARD
  // ---------------------------------------------------------------------------
  Widget _buildBundlesBannerCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD6E4FF),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _navigateToBundles,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 14.0,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'International Bundles',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF081C42),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Save more with our bundles',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF5A738E),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD3E4FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF081C42),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
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
                    icon: Icons.account_circle_outlined,
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
    const activeColor = Color(0xFF00C88C);
    const inactiveColor = Color(0xFF5A6E85);

    return InkWell(
      onTap: () => _handleNavTap(index),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 3),
                height: 2.5,
                width: 22,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            else
              const SizedBox(height: 5.5),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// COUNTRY DATA MODEL
// =============================================================================
enum FlagType {
  uk,
  usa,
  canada,
  kenya,
  tanzania,
  india,
  nigeria,
  uae,
  southAfrica,
  china,
  france,
  germany,
  rwanda,
  saudi,
}

class CountryRate {
  final String code;
  final String name;
  final FlagType flagType;
  final String rate;
  final String dialCode;
  final String isoCode;

  const CountryRate({
    required this.code,
    required this.name,
    required this.flagType,
    required this.rate,
    required this.dialCode,
    required this.isoCode,
  });
}

// =============================================================================
// FLAG WIDGET & CUSTOM PAINTERS
// =============================================================================
class FlagWidget extends StatelessWidget {
  final FlagType flagType;

  const FlagWidget({super.key, required this.flagType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipOval(
        child: CustomPaint(
          size: const Size(36, 36),
          painter: FlagPainter(flagType: flagType),
        ),
      ),
    );
  }
}

class FlagPainter extends CustomPainter {
  final FlagType flagType;

  FlagPainter({required this.flagType});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    switch (flagType) {
      case FlagType.uk:
        _paintUK(canvas, size, rect);
        break;
      case FlagType.usa:
        _paintUSA(canvas, size, rect);
        break;
      case FlagType.canada:
        _paintCanada(canvas, size, rect);
        break;
      case FlagType.kenya:
        _paintKenya(canvas, size, rect);
        break;
      case FlagType.tanzania:
        _paintTanzania(canvas, size, rect);
        break;
      case FlagType.india:
        _paintIndia(canvas, size, rect);
        break;
      case FlagType.nigeria:
        _paintNigeria(canvas, size, rect);
        break;
      case FlagType.uae:
        _paintUAE(canvas, size, rect);
        break;
      case FlagType.southAfrica:
        _paintSouthAfrica(canvas, size, rect);
        break;
      case FlagType.china:
        _paintChina(canvas, size, rect);
        break;
      case FlagType.france:
        _paintFrance(canvas, size, rect);
        break;
      case FlagType.germany:
        _paintGermany(canvas, size, rect);
        break;
      case FlagType.rwanda:
        _paintRwanda(canvas, size, rect);
        break;
      case FlagType.saudi:
        _paintSaudi(canvas, size, rect);
        break;
    }
  }

  // 1. UK (Union Jack)
  void _paintUK(Canvas canvas, Size size, Rect rect) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Navy Blue Background
    paint.color = const Color(0xFF012169);
    canvas.drawRect(rect, paint);

    // White Diagonals
    paint.color = Colors.white;
    paint.strokeWidth = 6;
    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);

    // Red Diagonals
    paint.color = const Color(0xFFC8102E);
    paint.strokeWidth = 3;
    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);

    // White Cross
    paint.color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.38, 0, size.width * 0.24, size.height),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.38, size.width, size.height * 0.24),
      paint,
    );

    // Red Cross
    paint.color = const Color(0xFFC8102E);
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.42, 0, size.width * 0.16, size.height),
      paint,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.42, size.width, size.height * 0.16),
      paint,
    );
  }

  // 2. USA (Stars & Stripes)
  void _paintUSA(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();
    final stripeHeight = size.height / 7;

    for (int i = 0; i < 7; i++) {
      paint.color =
          (i % 2 == 0) ? const Color(0xFFB22234) : const Color(0xFFFFFFFF);
      canvas.drawRect(
        Rect.fromLTWH(0, i * stripeHeight, size.width, stripeHeight),
        paint,
      );
    }

    // Blue Canton
    paint.color = const Color(0xFF3C3B6E);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * 0.48, stripeHeight * 4),
      paint,
    );

    // White Star dots
    paint.color = Colors.white;
    final starRadius = size.width * 0.025;
    for (double dx = size.width * 0.1;
        dx <= size.width * 0.4;
        dx += size.width * 0.12) {
      for (double dy = stripeHeight * 0.7;
          dy <= stripeHeight * 3.3;
          dy += stripeHeight * 1.1) {
        canvas.drawCircle(Offset(dx, dy), starRadius, paint);
      }
    }
  }

  // 3. Canada
  void _paintCanada(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();

    // White Center
    paint.color = Colors.white;
    canvas.drawRect(rect, paint);

    // Red Side Bands
    paint.color = const Color(0xFFFF0000);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width * 0.28, size.height), paint);
    canvas.drawRect(
        Rect.fromLTWH(
            size.width * 0.72, 0, size.width * 0.28, size.height),
        paint);

    // Red Maple Leaf (Stylized)
    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    final s = size.width * 0.28;

    path.moveTo(cx, cy - s * 0.7);
    path.lineTo(cx + s * 0.2, cy - s * 0.3);
    path.lineTo(cx + s * 0.5, cy - s * 0.35);
    path.lineTo(cx + s * 0.3, cy);
    path.lineTo(cx + s * 0.45, cy + s * 0.25);
    path.lineTo(cx + s * 0.1, cy + s * 0.2);
    path.lineTo(cx + s * 0.08, cy + s * 0.6);
    path.lineTo(cx - s * 0.08, cy + s * 0.6);
    path.lineTo(cx - s * 0.1, cy + s * 0.2);
    path.lineTo(cx - s * 0.45, cy + s * 0.25);
    path.lineTo(cx - s * 0.3, cy);
    path.lineTo(cx - s * 0.5, cy - s * 0.35);
    path.lineTo(cx - s * 0.2, cy - s * 0.3);
    path.close();

    canvas.drawPath(path, paint);
  }

  // 4. Kenya
  void _paintKenya(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();
    final h = size.height / 3;

    // Black
    paint.color = const Color(0xFF000000);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, h), paint);

    // Red
    paint.color = const Color(0xFFBB0000);
    canvas.drawRect(Rect.fromLTWH(0, h, size.width, h), paint);

    // Green
    paint.color = const Color(0xFF006600);
    canvas.drawRect(Rect.fromLTWH(0, h * 2, size.width, h), paint);

    // Thin White borders
    paint.color = Colors.white;
    paint.strokeWidth = 1.5;
    paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, h), Offset(size.width, h), paint);
    canvas.drawLine(Offset(0, h * 2), Offset(size.width, h * 2), paint);

    // Maasai Shield (Center)
    paint.style = PaintingStyle.fill;
    paint.color = const Color(0xFF8B0000);
    final ovalPath = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width * 0.3,
          height: size.height * 0.65,
        ),
      );
    canvas.drawPath(ovalPath, paint);

    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.05,
      paint,
    );
  }

  // 5. Tanzania
  void _paintTanzania(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();

    // Green top-left
    paint.color = const Color(0xFF1EB53A);
    canvas.drawRect(rect, paint);

    // Blue bottom-right
    paint.color = const Color(0xFF00A3E0);
    final bluePath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(bluePath, paint);

    // Yellow Diagonal Band
    paint.color = const Color(0xFFFCD116);
    final yellowPath = Path()
      ..moveTo(0, size.height * 0.8)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.2, size.height)
      ..lineTo(size.width, size.height * 0.2)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.8, 0)
      ..close();
    canvas.drawPath(yellowPath, paint);

    // Black Diagonal Band
    paint.color = const Color(0xFF000000);
    final blackPath = Path()
      ..moveTo(0, size.height * 0.85)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.15, size.height)
      ..lineTo(size.width, size.height * 0.15)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.85, 0)
      ..close();
    canvas.drawPath(blackPath, paint);
  }

  // 6. India
  void _paintIndia(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();
    final h = size.height / 3;

    // Saffron
    paint.color = const Color(0xFFFF9933);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, h), paint);

    // White
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, h, size.width, h), paint);

    // Green
    paint.color = const Color(0xFF138808);
    canvas.drawRect(Rect.fromLTWH(0, h * 2, size.width, h), paint);

    // Ashoka Chakra (Blue Wheel)
    paint.color = const Color(0xFF000080);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.2;
    final center = Offset(size.width / 2, size.height / 2);
    final r = h * 0.42;
    canvas.drawCircle(center, r, paint);

    for (int i = 0; i < 12; i++) {
      final angle = (i * math.pi) / 6;
      canvas.drawLine(
        Offset(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle)),
        Offset(center.dx - r * math.cos(angle), center.dy - r * math.sin(angle)),
        paint,
      );
    }
  }

  // 7. Nigeria
  void _paintNigeria(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();
    final w = size.width / 3;

    paint.color = const Color(0xFF008751);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, size.height), paint);
    canvas.drawRect(Rect.fromLTWH(w * 2, 0, w, size.height), paint);

    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(w, 0, w, size.height), paint);
  }

  // 8. UAE
  void _paintUAE(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();
    final h = size.height / 3;
    final rw = size.width * 0.28;

    // Right Horizontal Stripes
    paint.color = const Color(0xFF007A3D); // Green
    canvas.drawRect(Rect.fromLTWH(rw, 0, size.width - rw, h), paint);

    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(rw, h, size.width - rw, h), paint);

    paint.color = const Color(0xFF000000); // Black
    canvas.drawRect(Rect.fromLTWH(rw, h * 2, size.width - rw, h), paint);

    // Left Red Bar
    paint.color = const Color(0xFFFF0000);
    canvas.drawRect(Rect.fromLTWH(0, 0, rw, size.height), paint);
  }

  // 9. South Africa
  void _paintSouthAfrica(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();

    // Red Top
    paint.color = const Color(0xFFE03C31);
    canvas.drawRect(rect, paint);

    // Blue Bottom
    paint.color = const Color(0xFF001489);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.5, size.width, size.height * 0.5),
      paint,
    );

    // Green Y shape
    paint.color = const Color(0xFF007A3D);
    final yPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.45, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.35)
      ..lineTo(size.width * 0.4, size.height * 0.35)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(yPath, paint);

    // Black triangle
    paint.color = Colors.black;
    final bPath = Path()
      ..moveTo(0, size.height * 0.15)
      ..lineTo(size.width * 0.32, size.height * 0.5)
      ..lineTo(0, size.height * 0.85)
      ..close();
    canvas.drawPath(bPath, paint);
  }

  // 10. China
  void _paintChina(Canvas canvas, Size size, Rect rect) {
    final paint = Paint()..color = const Color(0xFFDE2910);
    canvas.drawRect(rect, paint);

    // Main Big Star
    paint.color = const Color(0xFFFFDE00);
    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.3),
      size.width * 0.12,
      paint,
    );
  }

  // 11. France
  void _paintFrance(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();
    final w = size.width / 3;

    paint.color = const Color(0xFF002395);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, size.height), paint);

    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(w, 0, w, size.height), paint);

    paint.color = const Color(0xFFED2939);
    canvas.drawRect(Rect.fromLTWH(w * 2, 0, w, size.height), paint);
  }

  // 12. Germany
  void _paintGermany(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();
    final h = size.height / 3;

    paint.color = Colors.black;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, h), paint);

    paint.color = const Color(0xFFDD0000);
    canvas.drawRect(Rect.fromLTWH(0, h, size.width, h), paint);

    paint.color = const Color(0xFFFFCE00);
    canvas.drawRect(Rect.fromLTWH(0, h * 2, size.width, h), paint);
  }

  // 13. Rwanda
  void _paintRwanda(Canvas canvas, Size size, Rect rect) {
    final paint = Paint();

    paint.color = const Color(0xFF00A3E0);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.5), paint);

    paint.color = const Color(0xFFFCD116);
    canvas.drawRect(
        Rect.fromLTWH(0, size.height * 0.5, size.width, size.height * 0.25),
        paint);

    paint.color = const Color(0xFF206C49);
    canvas.drawRect(
        Rect.fromLTWH(0, size.height * 0.75, size.width, size.height * 0.25),
        paint);
  }

  // 14. Saudi Arabia
  void _paintSaudi(Canvas canvas, Size size, Rect rect) {
    final paint = Paint()..color = const Color(0xFF006C35);
    canvas.drawRect(rect, paint);

    paint.color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(
          size.width * 0.2, size.height * 0.45, size.width * 0.6, size.height * 0.1),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant FlagPainter oldDelegate) {
    return oldDelegate.flagType != flagType;
  }
}

// =============================================================================
// GLOBE BANNER CUSTOM PAINTER
// =============================================================================
class GlobeBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.55, size.height * 0.5);
    final globeRadius = size.height * 0.38;

    // 1. Soft Outer Light Aura / Cyan Glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00E5FF).withValues(alpha: 0.35),
          const Color(0xFF0091EA).withValues(alpha: 0.15),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: globeRadius * 1.55));
    canvas.drawCircle(center, globeRadius * 1.55, glowPaint);

    // 2. Globe Sphere (3D Ocean Blue Gradient)
    final globePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: const [
          Color(0xFF448AFF),
          Color(0xFF1565C0),
          Color(0xFF0D47A1),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: globeRadius));
    canvas.drawCircle(center, globeRadius, globePaint);

    // 3. Green Landmasses / Continents on Globe
    final landPaint = Paint()
      ..color = const Color(0xFF00E676)
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: globeRadius)));

    // North America land shape
    final p1 = Path()
      ..moveTo(center.dx - globeRadius * 0.7, center.dy - globeRadius * 0.2)
      ..cubicTo(
        center.dx - globeRadius * 0.4, center.dy - globeRadius * 0.8,
        center.dx - globeRadius * 0.1, center.dy - globeRadius * 0.5,
        center.dx - globeRadius * 0.2, center.dy - globeRadius * 0.1,
      )
      ..cubicTo(
        center.dx - globeRadius * 0.5, center.dy + globeRadius * 0.1,
        center.dx - globeRadius * 0.8, center.dy,
        center.dx - globeRadius * 0.7, center.dy - globeRadius * 0.2,
      );
    canvas.drawPath(p1, landPaint);

    // Eurasia / Africa land shape
    final p2 = Path()
      ..moveTo(center.dx + globeRadius * 0.1, center.dy - globeRadius * 0.6)
      ..cubicTo(
        center.dx + globeRadius * 0.6, center.dy - globeRadius * 0.7,
        center.dx + globeRadius * 0.8, center.dy - globeRadius * 0.2,
        center.dx + globeRadius * 0.5, center.dy + globeRadius * 0.2,
      )
      ..cubicTo(
        center.dx + globeRadius * 0.2, center.dy + globeRadius * 0.6,
        center.dx - globeRadius * 0.1, center.dy + globeRadius * 0.3,
        center.dx + globeRadius * 0.1, center.dy - globeRadius * 0.6,
      );
    canvas.drawPath(p2, landPaint);

    // South America
    final p3 = Path()
      ..moveTo(center.dx - globeRadius * 0.3, center.dy + globeRadius * 0.1)
      ..cubicTo(
        center.dx - globeRadius * 0.1, center.dy + globeRadius * 0.2,
        center.dx - globeRadius * 0.2, center.dy + globeRadius * 0.7,
        center.dx - globeRadius * 0.5, center.dy + globeRadius * 0.4,
      )
      ..close();
    canvas.drawPath(p3, landPaint);

    canvas.restore();

    // 4. Orbital Ring Arc behind globe
    final ringPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    final ringRect = Rect.fromCenter(
      center: center,
      width: globeRadius * 2.5,
      height: globeRadius * 1.1,
    );
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-math.pi / 7);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawArc(ringRect, math.pi * 0.2, math.pi * 1.6, false, ringPaint);
    canvas.restore();

    // 5. 3D Bright Green Telephone Handset
    final phoneCenter = Offset(center.dx - globeRadius * 0.65, center.dy + globeRadius * 0.25);
    final phonePaint = Paint()
      ..color = const Color(0xFF00E676)
      ..style = PaintingStyle.fill;

    // Outer glow for phone handset
    canvas.drawCircle(
      phoneCenter,
      18,
      Paint()..color = const Color(0xFF00E676).withValues(alpha: 0.35),
    );

    final phonePath = Path();
    phonePath.moveTo(phoneCenter.dx - 10, phoneCenter.dy - 12);
    phonePath.cubicTo(
      phoneCenter.dx - 14, phoneCenter.dy - 6,
      phoneCenter.dx - 14, phoneCenter.dy + 6,
      phoneCenter.dx - 8, phoneCenter.dy + 12,
    );
    phonePath.cubicTo(
      phoneCenter.dx - 2, phoneCenter.dy + 16,
      phoneCenter.dx + 8, phoneCenter.dy + 14,
      phoneCenter.dx + 12, phoneCenter.dy + 8,
    );
    phonePath.lineTo(phoneCenter.dx + 6, phoneCenter.dy + 4);
    phonePath.cubicTo(
      phoneCenter.dx + 2, phoneCenter.dy + 8,
      phoneCenter.dx - 4, phoneCenter.dy + 4,
      phoneCenter.dx - 6, phoneCenter.dy,
    );
    phonePath.lineTo(phoneCenter.dx - 4, phoneCenter.dy - 8);
    phonePath.close();

    canvas.drawPath(phonePath, phonePaint);

    // Earpiece and mouthpiece accents
    canvas.drawCircle(
      Offset(phoneCenter.dx - 8, phoneCenter.dy - 10),
      5,
      Paint()..color = const Color(0xFF00C853),
    );
    canvas.drawCircle(
      Offset(phoneCenter.dx + 10, phoneCenter.dy + 8),
      5,
      Paint()..color = const Color(0xFF00C853),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// COUNTRY DETAIL BOTTOM SHEET
// =============================================================================
class _CountryDetailSheet extends StatelessWidget {
  final CountryRate country;

  const _CountryDetailSheet({required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Country Title & Flag
          Row(
            children: [
              FlagWidget(flagType: country.flagType),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF081C42),
                    ),
                  ),
                  Text(
                    'Dial Code: ${country.dialCode}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F9F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  country.rate,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF00A86B),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 20),

          // Detailed Rate Breakdown
          const Text(
            'Rate Details',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF081C42),
            ),
          ),
          const SizedBox(height: 12),
          _buildRateRow('Standard Mobile Rate', country.rate),
          const SizedBox(height: 8),
          _buildRateRow('Landline Rate', country.rate),
          const SizedBox(height: 8),
          _buildRateRow('SMS Rate', 'UGX 350/SMS'),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Color(0xFF081C42),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BundlesScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C88C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Buy Bundle',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildRateRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF081C42),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
