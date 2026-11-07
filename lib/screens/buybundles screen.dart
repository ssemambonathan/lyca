import 'package:flutter/material.dart';

class BuyBundlesScreen extends StatefulWidget {
  final String bundleTitle;
  final String validity;
  final String price;
  final List<String> features;
  final VoidCallback? onBack;

  const BuyBundlesScreen({
    super.key,
    this.bundleTitle = '10 GB Data Bundle',
    this.validity = '30 Days - Validity',
    this.price = 'UGX 15,000',
    this.features = const [
      '10 GB Data',
      '30 Days Validity',
      'Works in Uganda',
    ],
    this.onBack,
  });

  @override
  State<BuyBundlesScreen> createState() => _BuyBundlesScreenState();
}

class _BuyBundlesScreenState extends State<BuyBundlesScreen> {
  int _selectedPaymentIndex = 0;

  final List<_PaymentOptionData> _paymentOptions = [
    _PaymentOptionData(
      title: 'Mobile Money',
      type: _PaymentType.mobileMoney,
    ),
    _PaymentOptionData(
      title: 'Card',
      type: _PaymentType.card,
    ),
    _PaymentOptionData(
      title: 'Airtel Money',
      type: _PaymentType.airtelMoney,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.onBack != null) {
                        widget.onBack!();
                      } else if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF0F172A),
                      size: 22,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Buy Bundles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Gradient Card
                    _buildHeroCard(),

                    const SizedBox(height: 28),

                    // "Bundle includes" Section
                    const Text(
                      'Bundle includes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B1E47),
                      ),
                    ),
                    const SizedBox(height: 14),

                    ...widget.features.map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE6F4EA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: Color(0xFF00A86B),
                                size: 15,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              feature,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Divider(color: Color(0xFFE2E8F0), thickness: 1),
                    const SizedBox(height: 20),

                    // "Payment Method" Section
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B1E47),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Payment Method List Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: List.generate(_paymentOptions.length, (index) {
                          final isSelected = _selectedPaymentIndex == index;
                          final isLast = index == _paymentOptions.length - 1;
                          final option = _paymentOptions[index];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedPaymentIndex = index;
                                  });
                                },
                                borderRadius: BorderRadius.vertical(
                                  top: index == 0 ? const Radius.circular(16) : Radius.zero,
                                  bottom: isLast ? const Radius.circular(16) : Radius.zero,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 16.0,
                                  ),
                                  child: Row(
                                    children: [
                                      _buildPaymentIcon(option.type),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          option.title,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF0B1E47),
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF00A86B),
                                          size: 22,
                                        )
                                      else
                                        const Icon(
                                          Icons.chevron_right,
                                          color: Color(0xFF94A3B8),
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!isLast)
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xFFF1F5F9),
                                  indent: 16,
                                  endIndent: 16,
                                ),
                            ],
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Confirm & Pay Button
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 24.0, top: 8.0),
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00A86B), Color(0xFF00965E)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00A86B).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _handleConfirmPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Confirm & Pay',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Hero Card Widget
  // ---------------------------------------------------------------------------
  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF005F56),
            Color(0xFF00897B),
            Color(0xFF00ACC1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00897B).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Abstract Organic Shapes Painter
            Positioned.fill(
              child: CustomPaint(
                painter: _HeroCardBackgroundPainter(),
              ),
            ),

            // Content inside Card
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // White Circle Icon Container
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.language,
                        color: Color(0xFF00A86B),
                        size: 32,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Bundle Title
                  Text(
                    widget.bundleTitle,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Validity Subtitle
                  Text(
                    widget.validity,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Bottom Price Pill Container inside Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0B1E47),
                        letterSpacing: -0.3,
                      ),
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
  // Payment Icons Builder
  // ---------------------------------------------------------------------------
  Widget _buildPaymentIcon(_PaymentType type) {
    switch (type) {
      case _PaymentType.mobileMoney:
        return Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD100), // MTN Yellow style
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.phone_android_rounded,
              color: Color(0xFF0B1E47),
              size: 20,
            ),
          ),
        );
      case _PaymentType.card:
        return Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFED6EA0), Color(0xFFEC8C69)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.credit_card_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        );
      case _PaymentType.airtelMoney:
        return Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFED1C24), // Airtel Red style
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        );
    }
  }

  void _handleConfirmPayment() {
    final selectedOption = _paymentOptions[_selectedPaymentIndex].title;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6F4EA),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF00A86B),
                  size: 38,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B1E47),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You have successfully purchased ${widget.bundleTitle} for ${widget.price} using $selectedOption.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close bottom sheet
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context); // Pop back screen
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A86B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
// Enums & Helper Data Classes
// -----------------------------------------------------------------------------
enum _PaymentType { mobileMoney, card, airtelMoney }

class _PaymentOptionData {
  final String title;
  final _PaymentType type;

  _PaymentOptionData({
    required this.title,
    required this.type,
  });
}

// -----------------------------------------------------------------------------
// Custom Painter for Organic Gradient Background Waves in Hero Card
// -----------------------------------------------------------------------------
class _HeroCardBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color(0xFF00E676).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Circle top-right overlay
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.15),
      size.width * 0.45,
      paint1,
    );

    // Circle mid-right overlay
    canvas.drawCircle(
      Offset(size.width * 0.95, size.height * 0.55),
      size.width * 0.35,
      paint2,
    );

    // Large background wave circle top-center
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * -0.1),
      size.width * 0.6,
      paint3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
