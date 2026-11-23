import 'package:flutter/material.dart';

class AirtimeTransfer extends StatefulWidget {
  final VoidCallback? onContinue;
  final VoidCallback? onBackPressed;

  const AirtimeTransfer({
    super.key,
    this.onContinue,
    this.onBackPressed,
  });

  @override
  State<AirtimeTransfer> createState() => _AirtimeTransferState();
}

class _AirtimeTransferState extends State<AirtimeTransfer> {
  final TextEditingController _phoneController = TextEditingController(text: '787 654321');
  String _selectedAmount = 'UGX 5,000';
  int _currentBottomNavIndex = 0;

  final List<String> _amounts = ['UGX 1,000', 'UGX 2,000', 'UGX 5,000', 'UGX 10,000'];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

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
                'Airtime Transfer',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkNavy,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Send airtime to another number',
                style: TextStyle(
                  fontSize: 14,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Recipient Number Section
              const Text(
                'Recipient Number',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkNavy,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: Row(
                  children: [
                    // Flag and Prefix Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: borderColor, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Uganda Flag Placeholder using Icon or Container
                          Container(
                            width: 24,
                            height: 16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.black12,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Column(
                                children: [
                                  Expanded(child: Container(color: Colors.black)),
                                  Expanded(child: Container(color: Colors.amber)),
                                  Expanded(child: Container(color: Colors.red)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '+256',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: darkNavy,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_drop_down, color: textSecondary, size: 20),
                        ],
                      ),
                    ),
                    // Phone number input field
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: darkNavy,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          hintText: '787 654321',
                          hintStyle: TextStyle(color: textSecondary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Amount Section
              const Text(
                'Amount',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkNavy,
                ),
              ),
              const SizedBox(height: 12),

              // Amount Grid (2x2)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _amounts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  final amount = _amounts[index];
                  final isSelected = _selectedAmount == amount;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedAmount = amount;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryGreen : cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? primaryGreen : borderColor,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        amount,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : darkNavy,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Other Amount Button
              InkWell(
                onTap: () {
                  // Handle other amount selection
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: const Text(
                    'Other Amount',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: darkNavy,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Transfer Fee Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFBFDBFE), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Color(0xFF0284C7),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Transfer fee: UGX 200',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: widget.onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Continue',
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
}
