import 'package:flutter/material.dart';

class TransferReview extends StatefulWidget {
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final VoidCallback? onBackPressed;

  const TransferReview({
    super.key,
    this.onConfirm,
    this.onCancel,
    this.onBackPressed,
  });

  @override
  State<TransferReview> createState() => _TransferReviewState();
}

class _TransferReviewState extends State<TransferReview> {
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
                'Confirm Transfer',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkNavy,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Please review your details',
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Review Details Card
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
                    // From
                    _buildDetailRow(
                      icon: Icons.arrow_forward,
                      iconBg: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xFF0284C7),
                      label: 'From',
                      value: '+256 772 345678',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: borderColor, height: 1),
                    ),

                    // To
                    _buildDetailRow(
                      icon: Icons.phone_android,
                      iconBg: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xFF0284C7),
                      label: 'To',
                      value: '+256 787 654321',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: borderColor, height: 1),
                    ),

                    // Amount
                    _buildDetailRow(
                      icon: Icons.account_balance_wallet_outlined,
                      iconBg: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xFF0284C7),
                      label: 'Amount',
                      value: 'UGX 5,000',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: borderColor, height: 1),
                    ),

                    // Fee
                    _buildDetailRow(
                      icon: Icons.receipt_long_outlined,
                      iconBg: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xFF0284C7),
                      label: 'Fee',
                      value: 'UGX 200',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Confirm Transfer Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: widget.onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Confirm Transfer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: widget.onCancel ?? () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: darkNavy,
                    side: const BorderSide(color: borderColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkNavy,
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

  Widget _buildDetailRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    const darkNavy = Color(0xFF081C42);
    const textSecondary = Color(0xFF64748B);

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkNavy,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
