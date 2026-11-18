import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const EditProfileScreen({
    super.key,
    this.onBack,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _dobController;
  late final TextEditingController _genderController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: 'Nathan Ssemmambo');
    _emailController = TextEditingController(text: 'nathan@gmail.com');
    _dobController = TextEditingController(text: '15/05/2004');
    _genderController = TextEditingController(text: 'Male');
    _locationController = TextEditingController(text: 'Kampala, Uganda');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate() async {
    DateTime initialDate = DateTime(2004, 5, 15);
    try {
      final parts = _dobController.text.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        initialDate = DateTime(year, month, day);
      }
    } catch (_) {}

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00C853),
              onPrimary: Colors.white,
              onSurface: Color(0xFF0A1C3F),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final day = picked.day.toString().padLeft(2, '0');
      final month = picked.month.toString().padLeft(2, '0');
      final year = picked.year.toString();
      setState(() {
        _dobController.text = '$day/$month/$year';
      });
    }
  }

  void _selectGender() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Gender',
                style: TextStyle(
                  color: Color(0xFF0A1C3F),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...['Male', 'Female', 'Prefer not to say'].map(
                (gender) => ListTile(
                  title: Text(
                    gender,
                    style: TextStyle(
                      color: const Color(0xFF0A1C3F),
                      fontWeight: _genderController.text == gender
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: _genderController.text == gender
                      ? const Icon(Icons.check_circle, color: Color(0xFF00C853))
                      : null,
                  onTap: () {
                    setState(() {
                      _genderController.text = gender;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changePhoto() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined, color: Color(0xFF0A1C3F)),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gallery opened')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF0A1C3F)),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Camera opened')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile changes saved successfully!'),
        backgroundColor: Color(0xFF00C853),
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _handleBack();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleBack,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF0A1C3F),
                      size: 24,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Color(0xFF0A1C3F),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24), // Balance the back button spacing
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Avatar Circle with Camera Badge
                    Center(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: _changePhoto,
                            child: Container(
                              width: 114,
                              height: 114,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFD6E4FF), // Soft Pastel Blue Halo
                              ),
                              child: ClipOval(
                                child: CustomPaint(
                                  painter: AvatarSilhouettePainter(),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: _changePhoto,
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF0A1C3F), // Dark Navy Camera Badge
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Change Photo Button Text
                    GestureDetector(
                      onTap: _changePhoto,
                      child: const Text(
                        'Change Photo',
                        style: TextStyle(
                          color: Color(0xFF1B65F5), // Vibrant Royal Blue
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 1. Full Name Field
                    _buildFormField(
                      label: 'Full Name',
                      controller: _fullNameController,
                      keyboardType: TextInputType.name,
                    ),

                    const SizedBox(height: 18),

                    // 2. Email Address Field
                    _buildFormField(
                      label: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 18),

                    // 3. Date of Birth Field
                    _buildFormField(
                      label: 'Date of Birth',
                      controller: _dobController,
                      readOnly: true,
                      onTap: _selectDate,
                      suffixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xFF0A1C3F),
                        size: 20,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 4. Gender Field
                    _buildFormField(
                      label: 'Gender',
                      controller: _genderController,
                      readOnly: true,
                      onTap: _selectGender,
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF0A1C3F),
                        size: 26,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 5. Location Field
                    _buildFormField(
                      label: 'Location',
                      controller: _locationController,
                      keyboardType: TextInputType.streetAddress,
                      suffixIcon: const Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFF00796B),
                        size: 22,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Save Changes Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981), // Vibrant Green
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Cancel Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: _handleBack,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF0A1C3F),
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
          ],
        ),
      ),
    );
  }

  // Helper method for form text fields
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0A1C3F),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1.2,
            ),
          ),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Color(0xFF0A1C3F),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: suffixIcon,
                    )
                  : null,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom Painter for Avatar Silhouette with Pigtails/Side Hair
class AvatarSilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintNavy = Paint()
      ..color = const Color(0xFF0A1C3F)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // 1. Head Circle
    final headRadius = size.width * 0.24;
    final headCenter = Offset(cx, cy - 8);
    canvas.drawCircle(headCenter, headRadius, paintNavy);

    // 2. Left Pigtail / Hair Bun
    canvas.drawCircle(
      Offset(cx - headRadius * 0.85, headCenter.dy - headRadius * 0.45),
      headRadius * 0.45,
      paintNavy,
    );

    // 3. Right Pigtail / Hair Bun
    canvas.drawCircle(
      Offset(cx + headRadius * 0.85, headCenter.dy - headRadius * 0.45),
      headRadius * 0.45,
      paintNavy,
    );

    // 4. Neck & Shoulder Bust Base
    final pathShoulders = Path();
    pathShoulders.moveTo(cx - headRadius * 1.6, size.height);
    pathShoulders.quadraticBezierTo(
      cx - headRadius * 1.2,
      headCenter.dy + headRadius * 0.9,
      cx,
      headCenter.dy + headRadius * 0.85,
    );
    pathShoulders.quadraticBezierTo(
      cx + headRadius * 1.2,
      headCenter.dy + headRadius * 0.9,
      cx + headRadius * 1.6,
      size.height,
    );
    pathShoulders.close();

    canvas.drawPath(pathShoulders, paintNavy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
