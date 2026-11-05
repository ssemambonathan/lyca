import 'package:flutter/material.dart';
import 'enternumber.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                  Color(0xFF1A365D), // Deep blue top
                  Color(0xFF0F2027), // Mid dark
                  Color(0xFF060F18), // Deep navy bottom
                ],
              ),
            ),
          ),

          // 2. Cityscape Background Image with low opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.30,
              child: Image.network(
                'https://images.unsplash.com/photo-1477959858617-67f30bc75b82?auto=format&fit=crop&w=1200&q=80',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 3. Dark Gradient Overlay for readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),

          // 4. Smiling Woman holding smartphone on the right
          Positioned(
            right: -20,
            top: MediaQuery.of(context).size.height * 0.16,
            width: MediaQuery.of(context).size.width * 0.78,
            height: MediaQuery.of(context).size.height * 0.58,
            child: Opacity(
              opacity: 0.95,
              child: Image.network(
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=800&q=80',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 5. Bottom Gradient Fade to blend the image seamlessly
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 0.72, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    const Color(0xFF060F18).withOpacity(0.7),
                    const Color(0xFF060F18),
                  ],
                ),
              ),
            ),
          ),

          // 6. Foreground UI Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lyca Mobile Logo & Tagline Header
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Lyca',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -0.5,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: CustomPaint(
                                painter: WelcomeLycaHeartPainter(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Mobile',
                          style: TextStyle(
                            fontSize: 24,
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
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Headline
                  const Text(
                    'Stay connected\nanywhere, anytime',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Feature Bullets
                  _buildFeatureRow(
                    icon: Icons.card_giftcard_rounded,
                    text: 'Great value bundles',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureRow(
                    icon: Icons.public_rounded,
                    text: 'International calling',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureRow(
                    icon: Icons.person_outline_rounded,
                    text: 'Manage your account',
                  ),

                  const SizedBox(height: 36),

                  // "Get Started" Button
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
                            color: const Color(0xFF00E676).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EnterNumberScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          'Get Started',
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

                  const SizedBox(height: 20),

                  // "I already have an account" Link
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EnterNumberScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'I already have an account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF40C4FF),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF40C4FF),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

/// Custom painter for the Lyca Heart Emblem adapted for dark background (White L-bracket + Green Heart).
class WelcomeLycaHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. White L-Bracket
    final whitePaint = Paint()
      ..color = Colors.white
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

    canvas.drawPath(lPath, whitePaint);

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
