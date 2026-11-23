import 'package:flutter/material.dart';

class PaymentPending extends StatefulWidget {
  final VoidCallback? onCheckStatus;
  final VoidCallback? onBackToHome;
  final VoidCallback? onBackPressed;

  const PaymentPending({
    super.key,
    this.onCheckStatus,
    this.onBackToHome,
    this.onBackPressed,
  });

  @override
  State<PaymentPending> createState() => _PaymentPendingState();
}

class _PaymentPendingState extends State<PaymentPending> {
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    const darkNavy = Color(0xFF081C42);
    const primaryGreen = Color(0xFF00A878);
    const textSecondary = Color(0xFF64748B);
    const borderColor = Color(0xFFE2E8F0);
    const cardBg = Colors.white;

    return Scaffold(
      backgroundColor: darkNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBackPressed ?? () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            const Text(
              'Lyca',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Mobile',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Section (Dark Navy Background with Clock & Title)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  const Text(
                    'Receipt',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A8A).withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF3B82F6),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.access_time_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Payment Pending',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Rounded Sheet (White Background)
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    // Message
                    const Text(
                      'Your payment is being\nprocessed. This may take\na few moments...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: darkNavy,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Loading Indicator Spinner
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primaryGreen),
                        strokeWidth: 4,
                        backgroundColor: const Color(0xFFE2E8F0),
                      ),
                    ),
                    const Spacer(),

                    // Check Status Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: widget.onCheckStatus,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Check Status',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Back to Home Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton(
                        onPressed: widget.onBackToHome ?? () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: darkNavy,
                          side: const BorderSide(color: borderColor, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Back to Home',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darkNavy,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: borderColor, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentBottomNavIndex,
          onTap: (index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryGreen,
          unselectedItemColor: textSecondary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.headset_mic_outlined),
              activeIcon: Icon(Icons.headset_mic),
              label: 'Support',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              activeIcon: Icon(Icons.menu),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
