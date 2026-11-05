import 'package:flutter/material.dart';

class EnterNumberScreen extends StatefulWidget {
  const EnterNumberScreen({super.key});

  @override
  State<EnterNumberScreen> createState() => _EnterNumberScreenState();
}

class _EnterNumberScreenState extends State<EnterNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+256';
  String _selectedCountryName = 'Uganda';
  String _selectedFlag = '🇺🇬';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your mobile number')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification code sent to $_selectedCountryCode $phone')),
    );
  }

  void _selectCountry() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Country',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1931),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Text('🇺🇬', style: TextStyle(fontSize: 28)),
                title: const Text('+256 Uganda', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  setState(() {
                    _selectedCountryCode = '+256';
                    _selectedCountryName = 'Uganda';
                    _selectedFlag = '🇺🇬';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 28)),
                title: const Text('+44 United Kingdom', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  setState(() {
                    _selectedCountryCode = '+44';
                    _selectedCountryName = 'United Kingdom';
                    _selectedFlag = '🇬🇧';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇮🇪', style: TextStyle(fontSize: 28)),
                title: const Text('+353 Ireland', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  setState(() {
                    _selectedCountryCode = '+353';
                    _selectedCountryName = 'Ireland';
                    _selectedFlag = '🇮🇪';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF081C42)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Lyca',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF081C42),
                    letterSpacing: -0.6,
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CustomPaint(
                    painter: LycaHeartPainter(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 1),
            const Text(
              'Mobile',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF081C42),
                letterSpacing: -0.2,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Connect your world',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Enter your mobile number',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF081C42),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "We'll send you a verification code\nto this number.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),

              // Country Selector Box
              GestureDetector(
                onTap: _selectCountry,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _selectedFlag,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        '$_selectedCountryCode $_selectedCountryName',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF64748B),
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Phone Number Input Box
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g. 712 345678',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF94A3B8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFE2E8F0),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF00C88C),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00E676), // Bright Green
                        Color(0xFF00BFA5), // Teal
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E676).withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Need Help? Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Help & Support tapped')),
                    );
                  },
                  child: const Text(
                    'Need help?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0288D1),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF0288D1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the Lyca Heart Emblem (Blue L-bracket + Green Heart).
class LycaHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Blue L-Bracket
    final bluePaint = Paint()
      ..color = const Color(0xFF00529C)
      ..style = PaintingStyle.fill;

    final lPath = Path();
    final strokeW = w * 0.28;
    final cornerR = strokeW * 0.5;

    lPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, strokeW, h),
        Radius.circular(cornerR),
      ),
    );

    lPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, h - strokeW, w, strokeW),
        Radius.circular(cornerR),
      ),
    );

    canvas.drawPath(lPath, bluePaint);

    // 2. Green Heart
    final greenPaint = Paint()
      ..color = const Color(0xFF00C88C)
      ..style = PaintingStyle.fill;

    final heartPath = Path();
    final hx = w * 0.20;
    final hy = 0.0;
    final hw = w * 0.80;
    final hh = h * 0.80;

    final topCenter = Offset(hx + hw / 2, hy + hh * 0.32);
    final bottomTip = Offset(hx + hw / 2, hy + hh * 0.95);

    heartPath.moveTo(topCenter.dx, topCenter.dy);

    heartPath.cubicTo(
      hx + hw * 0.1, hy + hh * 0.0,
      hx + hw * 0.0, hy + hh * 0.5,
      bottomTip.dx, bottomTip.dy,
    );

    heartPath.cubicTo(
      hx + hw * 1.0, hy + hh * 0.5,
      hx + hw * 0.9, hy + hh * 0.0,
      topCenter.dx, topCenter.dy,
    );

    canvas.drawPath(heartPath, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
