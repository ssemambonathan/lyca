import 'package:flutter/material.dart';

class BundlesScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const BundlesScreen({super.key, this.onBack});

  @override
  State<BundlesScreen> createState() => _BundlesScreenState();
}

class _BundlesScreenState extends State<BundlesScreen> {
  int _selectedCategoryIndex = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _categories = ['Data', 'Voice', 'SMS', 'Combo'];

  // Bundle Items for each category matching the design
  final Map<String, List<BundleItem>> _bundleData = {
    'Data': [
      BundleItem(
        title: 'Daily Bundles',
        validity: '1 GB • 1 Day',
        price: 'UGX 2,000',
        iconType: BundleIconType.daily,
      ),
      BundleItem(
        title: 'Weekly Bundles',
        validity: '5 GB • 7 Days',
        price: 'UGX 10,000',
        iconType: BundleIconType.weekly,
      ),
      BundleItem(
        title: 'Monthly Bundles',
        validity: '10 GB • 30 Days',
        price: 'UGX 15,000',
        iconType: BundleIconType.monthly,
      ),
      BundleItem(
        title: 'International Bundles',
        validity: 'Call • 7 Days',
        price: 'UGX 25,000',
        iconType: BundleIconType.international,
      ),
    ],
    'Voice': [
      BundleItem(
        title: 'Daily Voice',
        validity: '30 Mins • 1 Day',
        price: 'UGX 1,500',
        iconType: BundleIconType.daily,
      ),
      BundleItem(
        title: 'Weekly Voice',
        validity: '200 Mins • 7 Days',
        price: 'UGX 7,000',
        iconType: BundleIconType.weekly,
      ),
      BundleItem(
        title: 'Monthly Voice',
        validity: '1,000 Mins • 30 Days',
        price: 'UGX 25,000',
        iconType: BundleIconType.monthly,
      ),
      BundleItem(
        title: 'International Voice',
        validity: '100 Mins • 7 Days',
        price: 'UGX 30,000',
        iconType: BundleIconType.international,
      ),
    ],
    'SMS': [
      BundleItem(
        title: 'Daily SMS',
        validity: '100 SMS • 1 Day',
        price: 'UGX 500',
        iconType: BundleIconType.daily,
      ),
      BundleItem(
        title: 'Weekly SMS',
        validity: '500 SMS • 7 Days',
        price: 'UGX 2,500',
        iconType: BundleIconType.weekly,
      ),
      BundleItem(
        title: 'Monthly SMS',
        validity: '2,000 SMS • 30 Days',
        price: 'UGX 8,000',
        iconType: BundleIconType.monthly,
      ),
    ],
    'Combo': [
      BundleItem(
        title: 'Daily Super Combo',
        validity: '1.5 GB + 50 Mins • 1 Day',
        price: 'UGX 3,500',
        iconType: BundleIconType.daily,
      ),
      BundleItem(
        title: 'Weekly Mega Combo',
        validity: '10 GB + 200 Mins + 100 SMS • 7 Days',
        price: 'UGX 20,000',
        iconType: BundleIconType.weekly,
      ),
      BundleItem(
        title: 'Monthly Ultimate Combo',
        validity: '30 GB + 1,000 Mins + 500 SMS • 30 Days',
        price: 'UGX 55,000',
        iconType: BundleIconType.monthly,
      ),
    ],
  };

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

  @override
  Widget build(BuildContext context) {
    String currentCat = _categories[_selectedCategoryIndex];
    List<BundleItem> currentList = _bundleData[currentCat] ?? [];

    if (_searchQuery.isNotEmpty) {
      currentList = currentList.where((item) {
        return item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.validity.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.price.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            _buildHeader(),

            // Category Filter Pills
            const SizedBox(height: 12),
            _buildCategoryTabs(),

            const SizedBox(height: 16),

            // Main Scrollable Area with Cards and Bottom Banner
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    // List of Bundle Cards matching the image layout
                    if (currentList.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'No bundles found for "$_searchQuery"',
                          style: const TextStyle(
                            color: Color(0xFF758A99),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          return _buildBundleCard(currentList[index]);
                        },
                      ),

                    const SizedBox(height: 20),

                    // Custom Offer Banner (matching exact image style)
                    _buildCustomOfferBanner(),

                    const SizedBox(height: 24),
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
  // 1. TOP HEADER (Back button, Title, Search button)
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              // Back Arrow Button
              InkWell(
                onTap: _handleBack,
                borderRadius: BorderRadius.circular(24),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xFF081C42),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Title: "Buy Bundles"
              const Expanded(
                child: Text(
                  'Buy Bundles',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF081C42),
                    letterSpacing: -0.3,
                  ),
                ),
              ),

              // Search Action Button
              InkWell(
                onTap: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    if (!_isSearching) {
                      _searchQuery = '';
                      _searchController.clear();
                    }
                  });
                },
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    _isSearching ? Icons.close : Icons.search_rounded,
                    color: const Color(0xFF081C42),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),

          // Search Field expansion
          if (_isSearching) ...[
            const SizedBox(height: 10),
            TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search bundles...',
                hintStyle: const TextStyle(color: Color(0xFF90A3B4), fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF00A878)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color(0xFF00A878), width: 1.5),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. CATEGORY FILTER TABS (Data, Voice, SMS, Combo)
  // ---------------------------------------------------------------------------
  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = index == _selectedCategoryIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF00A878)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF00A878)
                        : const Color(0xFFE2E8F0),
                    width: 1.2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF00A878).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF081C42),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. BUNDLE CARD WIDGET
  // ---------------------------------------------------------------------------
  Widget _buildBundleCard(BundleItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEFF3F8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF081C42).withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _showBundlePurchaseModal(item),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                // Circular Icon Badge on the left
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE6F7F2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CustomPaint(
                        painter: BundleIconPainter(type: item.iconType),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Middle Text Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title (e.g. Daily Bundles)
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF081C42),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Validity / Allowance (e.g. 1 GB • 1 Day)
                      Text(
                        item.validity,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF758A99),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Price (e.g. UGX 2,000)
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF081C42),
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Chevron Icon
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF8A9FB2),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. BOTTOM BANNER ("Need something custom?")
  // ---------------------------------------------------------------------------
  Widget _buildCustomOfferBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF031C38),
            Color(0xFF004F63),
            Color(0xFF009874),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00A878).withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Decorative Wave Graphic
          Positioned(
            right: -20,
            bottom: -30,
            child: SizedBox(
              width: 160,
              height: 160,
              child: CustomPaint(
                painter: BannerWavePainter(),
              ),
            ),
          ),

          // Banner Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Need something custom?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Check out our special offers.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.85),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 14),

                // "View Offers" Button
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fetching special custom offers...'),
                        backgroundColor: Color(0xFF00A878),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C78A),
                    foregroundColor: const Color(0xFF031C38),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'View Offers',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
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
  // 5. BUNDLE PURCHASE MODAL BOTTOM SHEET
  // ---------------------------------------------------------------------------
  void _showBundlePurchaseModal(BundleItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            top: 24,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Modal Indicator Bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title Header
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE6F7F2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: CustomPaint(
                          painter: BundleIconPainter(type: item.iconType),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF081C42),
                          ),
                        ),
                        Text(
                          item.validity,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF758A99),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    item.price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A878),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(color: Color(0xFFEFF3F8)),
              const SizedBox(height: 12),

              const Text(
                'Select Recipient',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF081C42),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F7F2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF00A878)),
                      ),
                      child: const Center(
                        child: Text(
                          'For Myself\n(My Number)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00A878),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Center(
                        child: Text(
                          'Gift a Friend\n(Other Number)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF081C42),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Confirm Purchase Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.title} purchased successfully!'),
                        backgroundColor: const Color(0xFF00A878),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A878),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Buy Now - ${item.price}',
                    style: const TextStyle(
                      fontSize: 15,
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
}

// -----------------------------------------------------------------------------
// DATA MODELS & ICON PAINTERS
// -----------------------------------------------------------------------------

enum BundleIconType { daily, weekly, monthly, international }

class BundleItem {
  final String title;
  final String validity;
  final String price;
  final BundleIconType iconType;

  BundleItem({
    required this.title,
    required this.validity,
    required this.price,
    required this.iconType,
  });
}

/// Custom painter to reproduce the exact 4 icon shapes from the screenshot:
/// 1. Daily: Sprout/leaf badge inside dark green circle
/// 2. Weekly: Heart with central diamond icon inside green circle
/// 3. Monthly: Shield/lock bag with data lines inside green circle
/// 4. International: Heart with phone handset inside green circle
class BundleIconPainter extends CustomPainter {
  final BundleIconType type;

  BundleIconPainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = w / 2;

    // Base Green Circle
    final greenBgPaint = Paint()
      ..color = const Color(0xFF00A878)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, greenBgPaint);

    final whiteIconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final whiteFillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    switch (type) {
      case BundleIconType.daily:
        // Sprout / Plant Leaf Motif inside green circle
        final path = Path();
        // Left leaf
        path.moveTo(center.dx, center.dy + 5);
        path.quadraticBezierTo(
          center.dx - 9, center.dy,
          center.dx - 6, center.dy - 8,
        );
        path.quadraticBezierTo(
          center.dx - 1, center.dy - 6,
          center.dx, center.dy + 5,
        );

        // Right leaf
        path.moveTo(center.dx, center.dy + 5);
        path.quadraticBezierTo(
          center.dx + 9, center.dy - 2,
          center.dx + 6, center.dy - 9,
        );
        path.quadraticBezierTo(
          center.dx + 1, center.dy - 6,
          center.dx, center.dy + 5,
        );

        canvas.drawPath(path, whiteFillPaint);

        // Stem
        canvas.drawLine(
          Offset(center.dx, center.dy + 5),
          Offset(center.dx, center.dy + 9),
          whiteIconPaint,
        );
        break;

      case BundleIconType.weekly:
        // Heart with central diamond motif
        final path = Path();
        path.moveTo(center.dx, center.dy + 8);
        path.cubicTo(
          center.dx - 10, center.dy + 2,
          center.dx - 10, center.dy - 7,
          center.dx, center.dy - 4,
        );
        path.cubicTo(
          center.dx + 10, center.dy - 7,
          center.dx + 10, center.dy + 2,
          center.dx, center.dy + 8,
        );

        canvas.drawPath(path, whiteIconPaint);

        // Center diamond
        final diamond = Path();
        diamond.moveTo(center.dx, center.dy - 2);
        diamond.lineTo(center.dx + 3, center.dy + 1);
        diamond.lineTo(center.dx, center.dy + 4);
        diamond.lineTo(center.dx - 3, center.dy + 1);
        diamond.close();
        canvas.drawPath(diamond, whiteFillPaint);
        break;

      case BundleIconType.monthly:
        // Lock / Bag Shield Motif
        final rect = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(center.dx, center.dy + 2),
            width: 14,
            height: 12,
          ),
          const Radius.circular(3),
        );
        canvas.drawRRect(rect, whiteIconPaint);

        // Lock top handle
        final handlePath = Path();
        handlePath.moveTo(center.dx - 4, center.dy - 4);
        handlePath.cubicTo(
          center.dx - 4, center.dy - 9,
          center.dx + 4, center.dy - 9,
          center.dx + 4, center.dy - 4,
        );
        canvas.drawPath(handlePath, whiteIconPaint);

        // Center keyhole dot
        canvas.drawCircle(Offset(center.dx, center.dy + 2), 2, whiteFillPaint);
        break;

      case BundleIconType.international:
        // Globe / Heart Phone motif
        final path = Path();
        path.moveTo(center.dx, center.dy + 7);
        path.cubicTo(
          center.dx - 9, center.dy + 2,
          center.dx - 9, center.dy - 6,
          center.dx, center.dy - 3,
        );
        path.cubicTo(
          center.dx + 9, center.dy - 6,
          center.dx + 9, center.dy + 2,
          center.dx, center.dy + 7,
        );
        canvas.drawPath(path, whiteIconPaint);

        // Phone handset arc inside
        final phoneArc = Path();
        phoneArc.moveTo(center.dx - 3, center.dy - 1);
        phoneArc.quadraticBezierTo(
          center.dx, center.dy + 3,
          center.dx + 3, center.dy - 1,
        );
        canvas.drawPath(phoneArc, whiteIconPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant BundleIconPainter oldDelegate) =>
      oldDelegate.type != type;
}

/// Custom painter for background glowing shapes on bottom banner
class BannerWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF00C78A).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color(0xFF007572).withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(size.width * 0.2, size.height);
    path1.quadraticBezierTo(
      size.width * 0.5, size.height * 0.2,
      size.width, size.height * 0.4,
    );
    path1.lineTo(size.width, size.height);
    path1.close();

    canvas.drawPath(path1, paint1);

    final path2 = Path();
    path2.moveTo(size.width * 0.4, size.height);
    path2.quadraticBezierTo(
      size.width * 0.7, size.height * 0.4,
      size.width, size.height * 0.1,
    );
    path2.lineTo(size.width, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
