import 'package:flutter/material.dart';

class AfterPaymentScreen extends StatelessWidget {
  final String title;
  final String bundleName;
  final String validity;
  final String amount;
  final String transactionId;
  final VoidCallback? onViewMyBundles;
  final VoidCallback? onBackToHome;

  const AfterPaymentScreen({
    super.key,
    this.title = 'Bundle Purchased!',
    this.bundleName = '10 GB Data Bundle',
    this.validity = 'Valid for 30 days',
    this.amount = 'UGX 15,000',
    this.transactionId = 'LYC202S1016094523',
    this.onViewMyBundles,
    this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00A878);
    const darkNavy = Color(0xFF081C42);
    const textSecondary = Color(0xFF64748B);
    const textMediumNavy = Color(0xFF334155);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),

                      // Success Circle + Confetti Header
                      const _ConfettiHeader(),

                      const SizedBox(height: 32),

                      // Title: Bundle Purchased!
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: darkNavy,
                          letterSpacing: -0.3,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Subtitle: 10 GB Data Bundle
                      Text(
                        bundleName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textMediumNavy,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Validity: Valid for 30 days
                      Text(
                        validity,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textSecondary,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Amount: UGX 15,000
                      Text(
                        amount,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: darkNavy,
                          letterSpacing: -0.2,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Thin Horizontal Divider
                      const Divider(
                        color: Color(0xFFE2E8F0),
                        thickness: 1,
                      ),

                      const SizedBox(height: 24),

                      // Transaction ID Section
                      const Text(
                        'Transaction ID',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textSecondary,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        transactionId,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3B4863),
                          letterSpacing: 0.2,
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Action Buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // View My Bundles Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        if (onViewMyBundles != null) {
                          onViewMyBundles!();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'View My Bundles',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Back to Home Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        if (onBackToHome != null) {
                          onBackToHome!();
                        } else {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryGreen,
                        side: const BorderSide(
                          color: primaryGreen,
                          width: 1.5,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfettiHeader extends StatelessWidget {
  const _ConfettiHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti painter canvas around the checkmark
          CustomPaint(
            size: const Size(240, 200),
            painter: _ConfettiPainter(),
          ),

          // Central Teal Green Checkmark Circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF00A878),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00A878).withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 52,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // List of confetti particles matching the screenshot artwork
    final particles = [
      // Top Yellow Pill
      _Particle(
        offset: const Offset(-25, -78),
        color: const Color(0xFFFFC107),
        type: _ParticleType.pill,
        width: 12,
        height: 6,
        rotation: 0.6,
      ),
      // Top-Left Yellow Dot / Square
      _Particle(
        offset: const Offset(-78, -65),
        color: const Color(0xFFFFC107),
        type: _ParticleType.square,
        width: 7,
        height: 7,
        rotation: 0.3,
      ),
      // Top-Left Blue Dot
      _Particle(
        offset: const Offset(-38, -48),
        color: const Color(0xFF007AFF),
        type: _ParticleType.circle,
        radius: 4.5,
      ),
      // Mid-Left Blue Dot
      _Particle(
        offset: const Offset(-85, -28),
        color: const Color(0xFF007AFF),
        type: _ParticleType.circle,
        radius: 4.5,
      ),
      // Mid-Left Purple Dot
      _Particle(
        offset: const Offset(-54, -10),
        color: const Color(0xFF8E24AA),
        type: _ParticleType.circle,
        radius: 5,
      ),
      // Lower-Left Green Dot
      _Particle(
        offset: const Offset(-68, 22),
        color: const Color(0xFF00C896),
        type: _ParticleType.circle,
        radius: 4,
      ),
      // Bottom-Left Green Dot
      _Particle(
        offset: const Offset(-36, 22),
        color: const Color(0xFF00C896),
        type: _ParticleType.circle,
        radius: 4,
      ),
      // Center-Bottom Green Dot
      _Particle(
        offset: const Offset(-2, 28),
        color: const Color(0xFF00C896),
        type: _ParticleType.circle,
        radius: 3.5,
      ),
      // Top Green Pill / Square
      _Particle(
        offset: const Offset(15, -73),
        color: const Color(0xFF00C896),
        type: _ParticleType.pill,
        width: 10,
        height: 5,
        rotation: -0.5,
      ),
      // Top-Center Teal Dot
      _Particle(
        offset: const Offset(38, -55),
        color: const Color(0xFF00C896),
        type: _ParticleType.circle,
        radius: 3.5,
      ),
      // Top-Right Teal Pill
      _Particle(
        offset: const Offset(40, -74),
        color: const Color(0xFF00C896),
        type: _ParticleType.pill,
        width: 10,
        height: 5,
        rotation: 0.4,
      ),
      // Top-Right Blue Dot
      _Particle(
        offset: const Offset(48, -48),
        color: const Color(0xFF007AFF),
        type: _ParticleType.circle,
        radius: 4,
      ),
      // Right Blue Square
      _Particle(
        offset: const Offset(76, -28),
        color: const Color(0xFF007AFF),
        type: _ParticleType.square,
        width: 8,
        height: 8,
        rotation: -0.4,
      ),
      // Right Yellow Square
      _Particle(
        offset: const Offset(60, -8),
        color: const Color(0xFFFFC107),
        type: _ParticleType.square,
        width: 7,
        height: 7,
        rotation: 0.5,
      ),
      // Mid-Right Green Dot
      _Particle(
        offset: const Offset(46, 5),
        color: const Color(0xFF4CAF50),
        type: _ParticleType.circle,
        radius: 3.5,
      ),
      // Mid-Right Teal Dot
      _Particle(
        offset: const Offset(76, 17),
        color: const Color(0xFF00C896),
        type: _ParticleType.circle,
        radius: 4,
      ),
      // Bottom-Right Purple Pill
      _Particle(
        offset: const Offset(33, 24),
        color: const Color(0xFF9C27B0),
        type: _ParticleType.pill,
        width: 12,
        height: 6,
        rotation: -0.6,
      ),
      // Bottom-Right Blue Pill
      _Particle(
        offset: const Offset(61, 38),
        color: const Color(0xFF007AFF),
        type: _ParticleType.pill,
        width: 10,
        height: 5,
        rotation: 0.5,
      ),
    ];

    for (final p in particles) {
      final paint = Paint()
        ..color = p.color
        ..style = PaintingStyle.fill;

      final targetPos = center + p.offset;

      canvas.save();
      canvas.translate(targetPos.dx, targetPos.dy);
      if (p.rotation != 0) {
        canvas.rotate(p.rotation);
      }

      switch (p.type) {
        case _ParticleType.circle:
          canvas.drawCircle(Offset.zero, p.radius, paint);
          break;
        case _ParticleType.square:
          final rect = Rect.fromCenter(
            center: Offset.zero,
            width: p.width,
            height: p.height,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, const Radius.circular(2)),
            paint,
          );
          break;
        case _ParticleType.pill:
          final rect = Rect.fromCenter(
            center: Offset.zero,
            width: p.width,
            height: p.height,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(p.height / 2)),
            paint,
          );
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum _ParticleType { circle, square, pill }

class _Particle {
  final Offset offset;
  final Color color;
  final _ParticleType type;
  final double radius;
  final double width;
  final double height;
  final double rotation;

  _Particle({
    required this.offset,
    required this.color,
    required this.type,
    this.radius = 4.0,
    this.width = 8.0,
    this.height = 8.0,
    this.rotation = 0.0,
  });
}
