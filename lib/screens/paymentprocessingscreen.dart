import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'afterpaymentscreen.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final String title;
  final String bundleName;
  final String validity;
  final String amount;
  final String transactionId;
  final Duration processingDuration;
  final VoidCallback? onComplete;

  const PaymentProcessingScreen({
    super.key,
    this.title = 'Processing Payment',
    this.bundleName = '10 GB Data Bundle',
    this.validity = 'Valid for 30 days',
    this.amount = 'UGX 15,000',
    this.transactionId = 'LYC202S1016094523',
    this.processingDuration = const Duration(seconds: 3),
    this.onComplete,
  });

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Automatically navigate to AfterPaymentScreen after the processing duration
    Timer(widget.processingDuration, () {
      if (!mounted) return;
      if (widget.onComplete != null) {
        widget.onComplete!();
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AfterPaymentScreen(
              bundleName: widget.bundleName,
              validity: widget.validity,
              amount: widget.amount,
              transactionId: widget.transactionId,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Deep Blue Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF071939), // Deep blue top
                  Color(0xFF040E24), // Mid dark
                  Color(0xFF020712), // Deep navy bottom
                ],
              ),
            ),
          ),

          // 2. Bottom Right Decorative Corner Waves
          Positioned.fill(
            child: CustomPaint(
              painter: _ProcessingCornerWavesPainter(),
            ),
          ),

          // 3. Foreground UI Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Lyca Mobile Logo & Tagline Header
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Lyca',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.8,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(width: 6),
                          SizedBox(
                            width: 28,
                            height: 28,
                            child: CustomPaint(
                              painter: _ProcessingHeartPainter(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Mobile',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Connect your world',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 2),

                  // Processing Payment Title
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Rotating Gradient Circular Spinner
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * math.pi,
                        child: const SizedBox(
                          width: 110,
                          height: 110,
                          child: CustomPaint(
                            painter: _SpinnerPainter(strokeWidth: 8.0),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 48),

                  // Please wait...
                  const Text(
                    'Please wait...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Descriptive Subtitle
                  const Text(
                    'We are processing your payment.\nThis will only take a moment.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF94A3B8), // Muted grey-blue for subtitle
                      height: 1.4,
                    ),
                  ),

                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the gradient spinner ring
class _SpinnerPainter extends CustomPainter {
  final double strokeWidth;

  const _SpinnerPainter({required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF00E676), // Bright Green
          Color(0xFF00BFA5), // Teal
          Color(0xFF2979FF), // Blue
          Color(0xFF00E676),
        ],
        stops: [0.0, 0.33, 0.66, 1.0],
      ).createShader(rect);

    canvas.drawArc(
      rect.deflate(strokeWidth / 2),
      0,
      math.pi * 1.5,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Custom painter for bottom-right corner waves
class _ProcessingCornerWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final darkBluePaint = Paint()
      ..color = const Color(0xFF00386E).withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    final greenPaint = Paint()
      ..color = const Color(0xFF00C88C).withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;

    // 1. Dark Blue Wave Layer (Underneath)
    final bottomBluePath = Path();
    bottomBluePath.moveTo(size.width, size.height);
    bottomBluePath.lineTo(size.width, size.height * 0.78);
    bottomBluePath.cubicTo(
      size.width * 0.82, size.height * 0.82,
      size.width * 0.72, size.height * 0.90,
      size.width * 0.68, size.height,
    );
    bottomBluePath.close();
    canvas.drawPath(bottomBluePath, darkBluePaint);

    // 2. Green Wave Layer (On Top)
    final bottomGreenPath = Path();
    bottomGreenPath.moveTo(size.width, size.height);
    bottomGreenPath.lineTo(size.width, size.height * 0.85);
    bottomGreenPath.cubicTo(
      size.width * 0.88, size.height * 0.92,
      size.width * 0.82, size.height * 0.97,
      size.width * 0.73, size.height,
    );
    bottomGreenPath.close();
    canvas.drawPath(bottomGreenPath, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for Lyca Heart Emblem
class _ProcessingHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Blue L-Bracket
    final bluePaint = Paint()
      ..color = const Color(0xFF00386E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.square;

    final lPath = Path()
      ..moveTo(w * 0.2, h * 0.05)
      ..lineTo(w * 0.2, h * 0.8)
      ..quadraticBezierTo(w * 0.2, h * 0.95, w * 0.35, h * 0.95)
      ..lineTo(w * 0.95, h * 0.95);
    canvas.drawPath(lPath, bluePaint);

    // 2. Green Heart
    final greenPaint = Paint()
      ..color = const Color(0xFF00C88C)
      ..style = PaintingStyle.fill;

    final heartPath = Path();
    final cx = w * 0.62;
    final cy = h * 0.45;
    final r = w * 0.22;

    heartPath.moveTo(cx, cy + r * 0.8);
    heartPath.cubicTo(
      cx - r * 1.8, cy - r * 0.2,
      cx - r * 1.0, cy - r * 1.4,
      cx, cy - r * 0.4,
    );
    heartPath.cubicTo(
      cx + r * 1.0, cy - r * 1.4,
      cx + r * 1.8, cy - r * 0.2,
      cx, cy + r * 0.8,
    );
    heartPath.close();
    canvas.drawPath(heartPath, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
