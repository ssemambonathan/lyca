import 'package:flutter/material.dart';

class TransactionReceipt extends StatefulWidget {
  final VoidCallback? onShareReceipt;
  final VoidCallback? onDone;
  final VoidCallback? onBackPressed;

  const TransactionReceipt({
    super.key,
    this.onShareReceipt,
    this.onDone,
    this.onBackPressed,
  });

  @override
  State<TransactionReceipt> createState() => _TransactionReceiptState();
}

class _TransactionReceiptState extends State<TransactionReceipt> {
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    const darkNavy = Color(0xFF081C42);
    const primaryGreen = Color(0xFF00A878);
    const textSecondary = Color(0xFF64748B);
    const borderColor = Color(0xFFE2E8F0);
    const cardBg = Colors.white;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkNavy),
          onPressed: widget.onBackPressed ?? () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            const Text(
              'Lyca',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkNavy,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Title
              const Text(
                'Receipt',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkNavy,
                ),
              ),
              const SizedBox(height: 16),

              // Receipt Paper Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Lyca Mobile Header inside Receipt
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Lyca',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkNavy,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: primaryGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Mobile',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Receipt Title & Ref
                    const Text(
                      'Transaction Receipt',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkNavy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Ref: LYC202611240001',
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Successful Pill Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.check_circle, color: primaryGreen, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Successful',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: borderColor, height: 1),
                    ),

                    // Receipt Details
                    _buildReceiptRow('Amount:', 'UGX 5,000'),
                    const SizedBox(height: 12),
                    _buildReceiptRow('Date:', '24 Nov 2026, 09:45 AM'),
                    const SizedBox(height: 12),
                    _buildReceiptRow('Payment:', 'MTN Mobile Money'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: borderColor, height: 1),
                    ),

                    // QR Code Placeholder
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor, width: 1),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.qr_code_2, size: 64, color: darkNavy),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: primaryGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.favorite, size: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Thank You Footer
                    const Text(
                      'Thank you for using Lyca Mobile!',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Share Receipt Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: widget.onShareReceipt,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: darkNavy,
                    side: const BorderSide(color: borderColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.share_outlined, color: Color(0xFF0284C7), size: 20),
                  label: const Text(
                    'Share Receipt',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkNavy,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Done Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: widget.onDone ?? () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
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

  Widget _buildReceiptRow(String label, String value) {
    const darkNavy = Color(0xFF081C42);
    const textSecondary = Color(0xFF64748B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: darkNavy,
          ),
        ),
      ],
    );
  }
}
