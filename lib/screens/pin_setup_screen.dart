import 'package:flutter/material.dart';
import 'dashboard.dart';

class PinSetupScreen extends StatefulWidget {
  final String phoneNumber;

  const PinSetupScreen({
    super.key,
    this.phoneNumber = '+256 712 345678',
  });

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final List<String> _pin = ['', '', '', ''];
  final List<String> _confirmPin = ['', '', '', ''];
  bool _isConfirming = false;

  void _onKeyPressed(String key) {
    setState(() {
      final currentPin = _isConfirming ? _confirmPin : _pin;
      if (key == 'backspace') {
        for (int i = 3; i >= 0; i--) {
          if (currentPin[i].isNotEmpty) {
            currentPin[i] = '';
            break;
          }
        }
      } else {
        for (int i = 0; i < 4; i++) {
          if (currentPin[i].isEmpty) {
            currentPin[i] = key;
            if (i == 3) {
              // Last digit entered
              Future.delayed(const Duration(milliseconds: 300), () {
                if (!mounted) return;
                if (!_isConfirming) {
                  setState(() {
                    _isConfirming = true;
                  });
                } else {
                  // Verify both pins match
                  final pin1 = _pin.join();
                  final pin2 = _confirmPin.join();
                  if (pin1 == pin2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PINs do not match. Please try again.')),
                    );
                    setState(() {
                      _pin.fillRange(0, 4, '');
                      _confirmPin.fillRange(0, 4, '');
                      _isConfirming = false;
                    });
                  }
                }
              });
            }
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPin = _isConfirming ? _confirmPin : _pin;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF081C42)),
          onPressed: () {
            if (_isConfirming) {
              setState(() {
                _isConfirming = false;
                _confirmPin.fillRange(0, 4, '');
              });
            } else {
              Navigator.of(context).pop();
            }
          },
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
                    painter: PinLycaHeartPainter(),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C88C).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xFF00A878),
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _isConfirming ? 'Confirm your 4-digit PIN' : 'Create your 4-digit PIN',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF081C42),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isConfirming
                          ? 'Please re-enter your PIN for confirmation'
                          : 'Set a secure PIN for quick login to ${widget.phoneNumber}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // 4 PIN Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        final isFilled = currentPin[index].isNotEmpty;
                        return Container(
                          width: 18,
                          height: 18,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: isFilled ? const Color(0xFF00A878) : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isFilled ? const Color(0xFF00A878) : const Color(0xFFCBD5E1),
                              width: 2.5,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            // Custom Number Pad
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumButton('1'),
                      _buildNumButton('2'),
                      _buildNumButton('3'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumButton('4'),
                      _buildNumButton('5'),
                      _buildNumButton('6'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumButton('7'),
                      _buildNumButton('8'),
                      _buildNumButton('9'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 72, height: 72),
                      _buildNumButton('0'),
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: IconButton(
                          onPressed: () => _onKeyPressed('backspace'),
                          icon: const Icon(
                            Icons.backspace_outlined,
                            color: Color(0xFF081C42),
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumButton(String number) {
    return SizedBox(
      width: 72,
      height: 72,
      child: ElevatedButton(
        onPressed: () => _onKeyPressed(number),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF081C42),
          elevation: 0,
          shadowColor: Colors.black.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
            side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
          ),
        ),
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Color(0xFF081C42),
          ),
        ),
      ),
    );
  }
}

class PinLycaHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

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
