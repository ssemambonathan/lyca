import 'package:flutter/material.dart';

class PaymentFailedScreen extends StatelessWidget {
  final String title;
  final String messageLine1;
  final String messageLine2;
  final VoidCallback? onTryAgain;
  final VoidCallback? onBackToHome;

  const PaymentFailedScreen({
    super.key,
    this.title = 'Purchase Failed',
    this.messageLine1 = 'Something went wrong.',
    this.messageLine2 = 'Please try again.',
    this.onTryAgain,
    this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFFF3366);
    const primaryGreen = Color(0xFF00A878);
    const darkNavy = Color(0xFF081C42);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: darkNavy,
                    size: 20,
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),

                      // Failed Icon Header with Soft Pink Background Wash
                      SizedBox(
                        width: 240,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Soft Pink Radial Background Circle
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: primaryRed.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                            ),
                            // Inner White Circle with Red Outline & X Icon
                            Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryRed,
                                  width: 3.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryRed.withValues(alpha: 0.15),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 52,
                                  color: primaryRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Title: Purchase Failed
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: primaryRed,
                          letterSpacing: -0.3,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Subtitle: Something went wrong. Please try again.
                      Text(
                        '$messageLine1\n$messageLine2',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: darkNavy,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 40),
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
                  // Try Again Button (Red Filled)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        if (onTryAgain != null) {
                          onTryAgain!();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Back to Home Button (Outlined Green/Teal)
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
