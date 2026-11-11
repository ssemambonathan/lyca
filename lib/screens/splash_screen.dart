import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to WelcomeScreen after 3 seconds
    Timer(const Duration(seconds: 3), _navigateToHome);
  }

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WelcomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Decorative Corner Waves
          Positioned.fill(
            child: CustomPaint(
              painter: CornerWavesPainter(),
            ),
          ),

          // Main Center Content
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Spacer(flex: 4),

                  // Brand Logo & Text Group
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // "Lyca" + Heart Emblem
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Lyca',
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF081C42),
                              letterSpacing: -1.0,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 44,
                            height: 44,
                            child: CustomPaint(
                              painter: LycaHeartPainter(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // "Mobile" Subtitle
                      const Text(
                        'Mobile',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF081C42),
                          letterSpacing: -0.5,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // "Connect your world" Tagline
                      const Text(
                        'Connect your world',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF081C42),
                          letterSpacing: 1.8,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Rotating Gradient Progress Indicator
                  const GradientSpinner(
                    size: 42,
                    strokeWidth: 4.0,
                  ),

                  const Spacer(flex: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for top-left and bottom-right decorative corner waves.
class CornerWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final darkBluePaint = Paint()
      ..color = const Color(0xFF00386E)
      ..style = PaintingStyle.fill;

    final greenPaint = Paint()
      ..color = const Color(0xFF00C88C)
      ..style = PaintingStyle.fill;

    // --- TOP-LEFT CORNER WAVES ---
    // 1. Dark Blue Layer (Underneath)
    final topBluePath = Path();
    topBluePath.moveTo(0, 0);
    topBluePath.lineTo(size.width * 0.28, 0);
    topBluePath.cubicTo(
      size.width * 0.24, size.height * 0.12,
      size.width * 0.12, size.height * 0.18,
      0, size.height * 0.22,
    );
    topBluePath.close();
    canvas.drawPath(topBluePath, darkBluePaint);

    // 2. Green Layer (On Top)
    final topGreenPath = Path();
    topGreenPath.moveTo(0, 0);
    topGreenPath.lineTo(size.width * 0.55, 0);
    topGreenPath.cubicTo(
      size.width * 0.42, size.height * 0.08,
      size.width * 0.15, size.height * 0.12,
      0, size.height * 0.15,
    );
    topGreenPath.close();
    canvas.drawPath(topGreenPath, greenPaint);

    // --- BOTTOM-RIGHT CORNER WAVES ---
    // 1. Dark Blue Layer (Underneath)
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

    // 2. Green Layer (On Top)
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

    // Vertical bar on left
    lPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, strokeW, h),
        Radius.circular(cornerR),
      ),
    );

    // Horizontal bar on bottom
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

    // Left lobe
    heartPath.cubicTo(
      hx + hw * 0.1, hy + hh * 0.0,
      hx + hw * 0.0, hy + hh * 0.5,
      bottomTip.dx, bottomTip.dy,
    );

    // Right lobe
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

/// Animated circular progress indicator with a green-to-blue gradient stroke.
class GradientSpinner extends StatefulWidget {
  final double size;
  final double strokeWidth;

  const GradientSpinner({
    super.key,
    this.size = 42.0,
    this.strokeWidth = 4.0,
  });

  @override
  State<GradientSpinner> createState() => _GradientSpinnerState();
}

class _GradientSpinnerState extends State<GradientSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(
          painter: _SpinnerPainter(strokeWidth: widget.strokeWidth),
        ),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final double strokeWidth;

  _SpinnerPainter({required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF00C88C), // Green
          Color(0xFF00529C), // Blue
          Colors.transparent,
        ],
        stops: [0.0, 0.7, 1.0],
      ).createShader(rect);

    canvas.drawArc(
      rect.deflate(strokeWidth / 2),
      0,
      1.5 * math.pi, // ~270 degree sweep
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
