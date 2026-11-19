import 'package:flutter/material.dart';

class SimManagementScreen extends StatelessWidget {
  final String simName;
  final String phoneNumber;
  final String status;
  final String network;
  final String simType;
  final String iccid;

  final VoidCallback? onBackPressed;
  final VoidCallback? onSimReplacement;
  final VoidCallback? onActivateEsim;
  final VoidCallback? onReportLostStolen;

  const SimManagementScreen({
    super.key,
    this.simName = 'My SIM',
    this.phoneNumber = '+256 772 345678',
    this.status = 'Active',
    this.network = 'MTN',
    this.simType = '4G/5G',
    this.iccid = '8986001234567890',
    this.onBackPressed,
    this.onSimReplacement,
    this.onActivateEsim,
    this.onReportLostStolen,
  });

  @override
  Widget build(BuildContext context) {
    const darkNavy = Color(0xFF041438);
    const secondaryText = Color(0xFF5B6E8C);
    const primaryGreen = Color(0xFF00B074);
    const activeBadgeBg = Color(0xFFD2F5E3);
    const activeBadgeText = Color(0xFF00A859);
    const cardBorderColor = Color(0xFFE8EEF5);
    const infoBgColor = Color(0xFFEFF6FF);
    const infoTextColor = Color(0xFF1E3A8A);
    const screenBg = Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: screenBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkNavy),
          onPressed: onBackPressed ?? () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'SIM Management',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkNavy,
            letterSpacing: -0.2,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------------------------------------------------
              // 1. TOP SIM CARD HEADER CARD
              // ---------------------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: cardBorderColor, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // SIM Card Custom Icon Graphic
                    _buildSimCardIcon(),

                    const SizedBox(width: 14.0),

                    // SIM Info Text & Status Badge
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                simName,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: darkNavy,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: activeBadgeBg,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text(
                                  status,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: activeBadgeText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            phoneNumber,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: darkNavy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28.0),

              // ---------------------------------------------------------------
              // 2. SIM INFORMATION SECTION
              // ---------------------------------------------------------------
              const Text(
                'SIM Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkNavy,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 20.0),

              // Network Detail
              _buildDetailItem(
                label: 'Network',
                value: network,
                labelColor: secondaryText,
                valueColor: darkNavy,
              ),

              const SizedBox(height: 18.0),

              // SIM Type Detail
              _buildDetailItem(
                label: 'SIM Type',
                value: simType,
                labelColor: secondaryText,
                valueColor: darkNavy,
              ),

              const SizedBox(height: 18.0),

              // ICCID Detail
              _buildDetailItem(
                label: 'ICCID',
                value: iccid,
                labelColor: secondaryText,
                valueColor: darkNavy,
              ),

              const SizedBox(height: 32.0),

              // ---------------------------------------------------------------
              // 3. ACTION BUTTONS
              // ---------------------------------------------------------------
              _buildOutlineActionButton(
                context: context,
                label: 'SIM Replacement',
                borderColor: primaryGreen,
                textColor: primaryGreen,
                onPressed: onSimReplacement ??
                    () => _showActionSnackBar(context, 'SIM Replacement requested.'),
              ),

              const SizedBox(height: 14.0),

              _buildOutlineActionButton(
                context: context,
                label: 'Activate eSIM',
                borderColor: primaryGreen,
                textColor: primaryGreen,
                onPressed: onActivateEsim ??
                    () => _showActionSnackBar(context, 'eSIM Activation initiated.'),
              ),

              const SizedBox(height: 14.0),

              _buildOutlineActionButton(
                context: context,
                label: 'Report Lost/Stolen',
                borderColor: primaryGreen,
                textColor: primaryGreen,
                onPressed: onReportLostStolen ??
                    () => _showActionSnackBar(context, 'Report Lost/Stolen opened.'),
              ),

              const SizedBox(height: 24.0),

              // ---------------------------------------------------------------
              // 4. BOTTOM INFO CARD
              // ---------------------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                decoration: BoxDecoration(
                  color: infoBgColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Information Icon with Solid Blue Background
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B82F6),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'i',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    const Expanded(
                      child: Text(
                        'Keep your SIM safe.\nReport lost or stolen SIM\nimmediately.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.35,
                          fontWeight: FontWeight.w600,
                          color: infoTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Detail Items (Label & Value)
  Widget _buildDetailItem({
    required String label,
    required String value,
    required Color labelColor,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: valueColor,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  // Helper Widget for Green Outlined Action Buttons
  Widget _buildOutlineActionButton({
    required BuildContext context,
    required String label,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: borderColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  // Helper to draw the Blue SIM Card Icon with Gold Metallic Chip
  Widget _buildSimCardIcon() {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFF1D4ED8), // Rich Royal Blue
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // SIM Outer Notch effect (Top Right Cutout)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                ),
              ),
            ),
          ),
          // Gold SIM Chip Card
          Container(
            width: 28,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B), // Golden Yellow
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: const Color(0xFFD97706),
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _chipSegment(),
                    _chipSegment(),
                  ],
                ),
                Container(
                  height: 1,
                  color: const Color(0xFFB45309),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _chipSegment(),
                    _chipSegment(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chipSegment() {
    return Container(
      width: 9,
      height: 6,
      decoration: BoxDecoration(
        color: const Color(0xFFFCD34D),
        borderRadius: BorderRadius.circular(1.5),
        border: Border.all(
          color: const Color(0xFFB45309),
          width: 0.5,
        ),
      ),
    );
  }

  void _showActionSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF041438),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
