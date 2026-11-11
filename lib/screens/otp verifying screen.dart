import 'package:flutter/material.dart';
import 'pin_setup_screen.dart';
import 'enternumber.dart';

class OtpVerifyingScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerifyingScreen({
    super.key,
    this.phoneNumber = '+256 712 345678',
  });

  @override
  State<OtpVerifyingScreen> createState() => _OtpVerifyingScreenState();
}

class _OtpVerifyingScreenState extends State<OtpVerifyingScreen> {
  final List<String> _otp = ['1', '2', '3', '4', '5', '6'];

  void _onKeyPressed(String key) {
    setState(() {
      if (key == 'backspace') {
        for (int i = 5; i >= 0; i--) {
          if (_otp[i].isNotEmpty) {
            _otp[i] = '';
            break;
          }
        }
      } else {
        for (int i = 0; i < 6; i++) {
          if (_otp[i].isEmpty) {
            _otp[i] = key;
            if (i == 5) {
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PinSetupScreen(
                        phoneNumber: widget.phoneNumber,
                      ),
                    ),
                  );
                }
              });
            }
            break;
          }
        }
      }
    });
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification code resent to ${widget.phoneNumber}')),
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      'Verify your number',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF081C42),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: "We've sent a 6-digit code to\n",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF64748B),
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: widget.phoneNumber,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF081C42),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 6 OTP Digit Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        final digit = _otp[index];
                        final isFilled = digit.isNotEmpty;
                        return Container(
                          width: 48,
                          height: 58,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isFilled ? const Color(0xFF00C88C) : const Color(0xFFE2E8F0),
                              width: isFilled ? 2.0 : 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            digit,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF081C42),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 28),

                    // Didn't receive code & Resend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Didn't receive a code? ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        GestureDetector(
                          onTap: _resendCode,
                          child: const Text(
                            "Resend (00:45)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF00897B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Numeric Keypad
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildKeypadRow(['1', '2', '3']),
                  const SizedBox(height: 12),
                  _buildKeypadRow(['4', '5', '6']),
                  const SizedBox(height: 12),
                  _buildKeypadRow(['7', '8', '9']),
                  const SizedBox(height: 12),
                  _buildKeypadRow(['', '0', 'backspace']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        if (key.isEmpty) {
          return const SizedBox(width: 88, height: 52);
        }
        return InkWell(
          onTap: () => _onKeyPressed(key),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 88,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFF1F5F9),
                width: 1,
              ),
            ),
            child: key == 'backspace'
                ? const Icon(
                    Icons.backspace_outlined,
                    color: Color(0xFF081C42),
                    size: 22,
                  )
                : Text(
                    key,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF081C42),
                    ),
                  ),
          ),
        );
      }).toList(),
    );
  }
}
