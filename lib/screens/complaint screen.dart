import 'package:flutter/material.dart';
import 'support.dart';
import 'wallet.dart';

class ComplaintScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final ValueChanged<int>? onSelectTab;
  final int initialTabIndex; // 0 for FAQ, 1 for Complaints

  const ComplaintScreen({
    super.key,
    this.onBackToHome,
    this.onSelectTab,
    this.initialTabIndex = 0,
  });

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen>
    with SingleTickerProviderStateMixin {
  late int _selectedTabIndex;
  int _selectedNavIndex = 3; // 3 = 'More' tab selected by default as in screenshot

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Expanded FAQ items tracker
  final Set<int> _expandedFaqIndices = {};

  // Complaint Form Controllers
  String _selectedCategory = 'Network & Data';
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isSubmitting = false;
  String? _attachedFileName;

  final List<String> _categories = [
    'Network & Data',
    'Billing & Airtime',
    'Bundle Activation',
    'SIM & Account',
    'Other',
  ];

  // Mock list of FAQ items
  final List<Map<String, String>> _faqList = [
    {
      'question': 'How to check my balance?',
      'answer':
          'To check your balance, dial *131# on your Lyca Mobile phone or log into the homepage of this app to view your main balance, data allowances, remaining minutes, and expiry dates instantly.',
    },
    {
      'question': 'How to buy a data bundle?',
      'answer':
          'You can buy a data bundle directly from the Bundles tab in this app, or by dialing *139# and following the on-screen menu. Select your preferred daily, weekly, or monthly plan and confirm payment.',
    },
    {
      'question': 'How to transfer airtime?',
      'answer':
          'To transfer airtime to another Lyca Mobile customer, go to the Airtime Transfer screen from the app home screen, enter the recipient\'s number, select the amount, and confirm with your security PIN.',
    },
    {
      'question': 'Why is my bundle not working?',
      'answer':
          'Make sure your Mobile Data is toggled ON and your Access Point Name (APN) is configured to "data.lycamobile.com". Try restarting your device or toggling Airplane mode to refresh network registration.',
    },
    {
      'question': 'How to contact support?',
      'answer':
          'Our support team is available 24/7. You can tap the "Contact Support" button below to start a live chat, call 322 from your Lyca line, or send an email to support@lycamobile.com.',
    },
  ];

  // Mock list of user complaints history
  final List<Map<String, dynamic>> _complaintHistory = [
    {
      'ticketId': '#LC-98412',
      'category': 'Bundle Activation',
      'subject': 'Data bundle not credited after payment',
      'date': 'Today, 10:30 AM',
      'status': 'Pending',
      'statusColor': const Color(0xFFFF9800),
    },
    {
      'ticketId': '#LC-87123',
      'category': 'Network & Data',
      'subject': 'Slow 4G data speed in central area',
      'date': 'Yesterday',
      'status': 'In Progress',
      'statusColor': const Color(0xFF2196F3),
    },
    {
      'ticketId': '#LC-74910',
      'category': 'Billing & Airtime',
      'subject': 'Airtime deduction discrepancy',
      'date': '12 Oct 2024',
      'status': 'Resolved',
      'statusColor': const Color(0xFF00C853),
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialTabIndex;
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase().trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (widget.onBackToHome != null) {
      widget.onBackToHome!();
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else if (widget.onSelectTab != null) {
      widget.onSelectTab!(0);
    }
  }

  void _handleNavTap(int index) {
    if (index == 0 && widget.onBackToHome != null) {
      widget.onBackToHome!();
    } else if (widget.onSelectTab != null) {
      widget.onSelectTab!(index);
    } else {
      setState(() {
        _selectedNavIndex = index;
      });
    }
  }

  void _toggleFaq(int index) {
    setState(() {
      if (_expandedFaqIndices.contains(index)) {
        _expandedFaqIndices.remove(index);
      } else {
        _expandedFaqIndices.add(index);
      }
    });
  }

  void _submitComplaint() async {
    if (_subjectController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in both the subject and description.'),
          backgroundColor: Color(0xFFE53935),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    final newTicketId = '#LC-${10000 + (DateTime.now().millisecondsSinceEpoch % 89999)}';
    final newComplaint = {
      'ticketId': newTicketId,
      'category': _selectedCategory,
      'subject': _subjectController.text.trim(),
      'date': 'Just now',
      'status': 'Pending',
      'statusColor': const Color(0xFFFF9800),
    };

    setState(() {
      _isSubmitting = false;
      _complaintHistory.insert(0, newComplaint);
      _subjectController.clear();
      _descriptionController.clear();
      _attachedFileName = null;
    });

    _showSuccessDialog(newTicketId);
  }

  void _showSuccessDialog(String ticketId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF00C853),
                size: 44,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Complaint Submitted!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF061938),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your ticket number is $ticketId. Our support team will investigate and update you shortly.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF5A6E85),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactSupportModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF061938),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Choose how you would like to reach us:',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5A6E85),
              ),
            ),
            const SizedBox(height: 20),
            _buildContactOptionTile(
              icon: Icons.chat_bubble_rounded,
              iconColor: const Color(0xFF00C853),
              iconBg: const Color(0xFFE8F5E9),
              title: 'Live Chat',
              subtitle: 'Chat with our AI agent or human support (24/7)',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Starting Live Chat session...'),
                    backgroundColor: Color(0xFF061938),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildContactOptionTile(
              icon: Icons.phone_in_talk_rounded,
              iconColor: const Color(0xFF2196F3),
              iconBg: const Color(0xFFE3F2FD),
              title: 'Call Customer Care',
              subtitle: 'Dial 322 (Free from Lyca SIM) or +44 207 132 0322',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Calling Lyca Customer Care (322)...'),
                    backgroundColor: Color(0xFF061938),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildContactOptionTile(
              icon: Icons.email_rounded,
              iconColor: const Color(0xFF9C27B0),
              iconBg: const Color(0xFFF3E5F5),
              title: 'Email Support',
              subtitle: 'Send details to support@lycamobile.com',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening email client...'),
                    backgroundColor: Color(0xFF061938),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOptionTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF061938),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5A6E85),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF8C99B2),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedNavIndex == 1) {
      return WalletScreen(
        onBackToHome: () {
          setState(() {
            _selectedNavIndex = 3;
          });
        },
      );
    }

    if (_selectedNavIndex == 2) {
      return SupportScreen(
        onBackToHome: () {
          setState(() {
            _selectedNavIndex = 3;
          });
        },
        onSelectTab: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header Bar
            _buildHeaderBar(),

            // Scrollable Body Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Toggle Segment: FAQ / Complaints
                    _buildToggleSegmentBar(),

                    const SizedBox(height: 16),

                    // Tab Views
                    if (_selectedTabIndex == 0) ...[
                      // Search Bar
                      _buildSearchBar(),

                      const SizedBox(height: 16),

                      // FAQ Items List
                      _buildFaqList(),
                    ] else ...[
                      // Complaints Tab Content
                      _buildComplaintsTabContent(),
                    ],

                    const SizedBox(height: 20),

                    // "Still need help?" Hero Card
                    _buildStillNeedHelpCard(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. HEADER BAR ("← FAQ & Complaints")
  // ---------------------------------------------------------------------------
  Widget _buildHeaderBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Row(
        children: [
          IconButton(
            onPressed: _handleBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF061938),
              size: 24,
            ),
            splashRadius: 24,
          ),
          const SizedBox(width: 4),
          const Text(
            'FAQ & Complaints',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF061938),
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. TOGGLE SEGMENT BAR ([ FAQ ]  [ Complaints ])
  // ---------------------------------------------------------------------------
  Widget _buildToggleSegmentBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F7),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // FAQ Tab Pill
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = 0;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 0
                      ? const Color(0xFF00C853)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: _selectedTabIndex == 0
                      ? const [
                          BoxShadow(
                            color: Color(0x3300C853),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  'FAQ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedTabIndex == 0
                        ? Colors.white
                        : const Color(0xFF061938),
                  ),
                ),
              ),
            ),
          ),

          // Complaints Tab Pill
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = 1;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 1
                      ? const Color(0xFF00C853)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: _selectedTabIndex == 1
                      ? const [
                          BoxShadow(
                            color: Color(0x3300C853),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Complaints',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedTabIndex == 1
                        ? Colors.white
                        : const Color(0xFF061938),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. SEARCH BAR ("Search FAQs...")
  // ---------------------------------------------------------------------------
  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: Color(0xFF8C99B2),
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF061938),
              ),
              decoration: const InputDecoration(
                hintText: 'Search FAQs...',
                hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8C99B2),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
              },
              child: const Icon(
                Icons.cancel_rounded,
                color: Color(0xFF8C99B2),
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. FAQ LIST ACCORDION ITEMS
  // ---------------------------------------------------------------------------
  Widget _buildFaqList() {
    final filteredFaqs = _faqList.where((faq) {
      if (_searchQuery.isEmpty) return true;
      final q = faq['question']!.toLowerCase();
      final a = faq['answer']!.toLowerCase();
      return q.contains(_searchQuery) || a.contains(_searchQuery);
    }).toList();

    if (filteredFaqs.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 48,
              color: Color(0xFF8C99B2),
            ),
            const SizedBox(height: 12),
            Text(
              'No FAQs found for "${_searchController.text}"',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF061938),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Try searching with different keywords or contact support.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF5A6E85),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(filteredFaqs.length, (index) {
        final faq = filteredFaqs[index];
        final originalIndex = _faqList.indexOf(faq);
        final isExpanded = _expandedFaqIndices.contains(originalIndex) ||
            _searchQuery.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildFaqCard(
            index: originalIndex,
            question: faq['question']!,
            answer: faq['answer']!,
            isExpanded: isExpanded,
          ),
        );
      }),
    );
  }

  Widget _buildFaqCard({
    required int index,
    required String question,
    required String answer,
    required bool isExpanded,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded
              ? const Color(0xFFC5D9F7)
              : const Color(0xFFEBF0F5),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Question Row
          InkWell(
            onTap: () => _toggleFaq(index),
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
              child: Row(
                children: [
                  // Blue Icon Box on Left
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: CustomPaint(
                        size: const Size(20, 20),
                        painter: FaqSquareIconPainter(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Question Text
                  Expanded(
                    child: Text(
                      question,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF061938),
                        height: 1.25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Chevron Icon
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF061938),
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Answer Expansion Area
          if (isExpanded) ...[
            const Divider(height: 1, color: Color(0xFFF0F4F8)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    answer,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF475569),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Was this answer helpful?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8C99B2),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Thanks for your feedback!'),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Color(0xFF00C853),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.thumb_up_outlined,
                                      size: 13, color: Color(0xFF00C853)),
                                  SizedBox(width: 4),
                                  Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00C853),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              _showContactSupportModal();
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.thumb_down_outlined,
                                      size: 13, color: Color(0xFF64748B)),
                                  SizedBox(width: 4),
                                  Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 5. COMPLAINTS TAB CONTENT
  // ---------------------------------------------------------------------------
  Widget _buildComplaintsTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Form Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06000000),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Submit a New Complaint',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF061938),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Select a category and describe your issue below:',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF5A6E85),
                ),
              ),
              const SizedBox(height: 16),

              // Category Choice Chips
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF061938),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = cat;
                        });
                      }
                    },
                    selectedColor: const Color(0xFF00C853),
                    backgroundColor: const Color(0xFFF1F5F9),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : const Color(0xFF475569),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFF00C853)
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                    showCheckmark: false,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              // Subject Input
              const Text(
                'Subject',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF061938),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _subjectController,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF061938),
                ),
                decoration: InputDecoration(
                  hintText: 'e.g., Data bundle not activated',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF94A3B8),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF00C853),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Description Input
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF061938),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF061938),
                ),
                decoration: InputDecoration(
                  hintText:
                      'Provide detailed information about your issue, transaction dates, numbers, etc.',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  contentPadding: const EdgeInsets.all(14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF00C853),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Attachment Button
              Row(
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    onPressed: () {
                      setState(() {
                        _attachedFileName = 'screenshot_receipt.png';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Attached screenshot_receipt.png'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.attach_file_rounded,
                      size: 18,
                      color: Color(0xFF061938),
                    ),
                    label: Text(
                      _attachedFileName ?? 'Attach Image / Screenshot',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF061938),
                      ),
                    ),
                  ),
                  if (_attachedFileName != null) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _attachedFileName = null;
                        });
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFFE53935),
                        size: 20,
                      ),
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 18),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _isSubmitting ? null : _submitComplaint,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Submit Complaint',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Complaint History Header
        const Text(
          'Your Complaints History',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF061938),
          ),
        ),
        const SizedBox(height: 10),

        // History List
        Column(
          children: _complaintHistory.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEBF0F5)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x04000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: Color(0xFF061938),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['ticketId'],
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF061938),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: (item['statusColor'] as Color)
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item['status'],
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: item['statusColor'] as Color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['subject'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${item['category']} • ${item['date']}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 6. "STILL NEED HELP?" HERO CARD (Exact matching layout from screenshot)
  // ---------------------------------------------------------------------------
  Widget _buildStillNeedHelpCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF051C42), // Deep Navy matching screenshot
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2B051C42),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Headset / Agent Avatar Icon
              Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2B62D9),
                      Color(0xFF1E4DB7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: CustomPaint(
                    size: const Size(36, 36),
                    painter: HeadsetIconPainter(),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Title and Description Text
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Still need help?',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Report a problem or\ncontact our support team.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFD0DCEB),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Green Contact Support Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853), // Vibrant Green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              onPressed: _showContactSupportModal,
              child: const Text(
                'Contact Support',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 7. BOTTOM NAVIGATION BAR (Home, Wallet, Support, More)
  // ---------------------------------------------------------------------------
  Widget _buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEFF2F6),
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, 'Home'),
          _buildNavItem(1, Icons.account_balance_wallet_outlined, 'Wallet'),
          _buildNavItem(2, Icons.support_agent_rounded, 'Support'),
          _buildNavItem(3, Icons.menu_rounded, 'More', isSelected: true),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label,
      {bool isSelected = false}) {
    final active = _selectedNavIndex == index || isSelected;
    final color = active ? const Color(0xFF00C853) : const Color(0xFF7E8B9B);

    return InkWell(
      onTap: () => _handleNavTap(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: active ? FontWeight.bold : FontWeight.w500,
                color: color,
              ),
            ),
            if (active) ...[
              const SizedBox(height: 2),
              Container(
                width: 16,
                height: 2.5,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ] else ...[
              const SizedBox(height: 4.5),
            ],
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// CUSTOM PAINTER 1: FAQ Square Icon (Blue icon in light blue box matching photo)
// =============================================================================
class FaqSquareIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2, 2, size.width - 4, size.height - 4),
      const Radius.circular(5),
    );

    canvas.drawRRect(rect, strokePaint);

    // Inner detail (line/speech bubble hint inside box)
    final path = Path()
      ..moveTo(size.width * 0.32, size.height * 0.4)
      ..lineTo(size.width * 0.68, size.height * 0.4)
      ..moveTo(size.width * 0.32, size.height * 0.6)
      ..lineTo(size.width * 0.54, size.height * 0.6);

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// CUSTOM PAINTER 2: Headset Icon for "Still need help?" Card
// =============================================================================
class HeadsetIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    // Headband Arc
    final arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(arcRect, 3.14, 3.14, false, paint);

    // Earpads
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Left earpad
    final leftEarpad = RRect.fromRectAndRadius(
      Rect.fromLTWH(center.dx - radius - 3, center.dy - 4, 7, 14),
      const Radius.circular(3),
    );
    canvas.drawRRect(leftEarpad, fillPaint);

    // Right earpad
    final rightEarpad = RRect.fromRectAndRadius(
      Rect.fromLTWH(center.dx + radius - 4, center.dy - 4, 7, 14),
      const Radius.circular(3),
    );
    canvas.drawRRect(rightEarpad, fillPaint);

    // Mic stem & capsule
    final micPath = Path()
      ..moveTo(center.dx + radius, center.dy + 4)
      ..quadraticBezierTo(
        center.dx + radius * 0.6,
        center.dy + radius * 0.9,
        center.dx + 2,
        center.dy + radius * 0.85,
      );
    canvas.drawPath(micPath, paint);

    final micCapsule = RRect.fromRectAndRadius(
      Rect.fromLTWH(center.dx - 4, center.dy + radius * 0.85 - 3, 7, 5),
      const Radius.circular(2),
    );
    canvas.drawRRect(micCapsule, fillPaint);

    // Little badge on headset (resembling 'Li' or small icon)
    final badgePaint = Paint()
      ..color = const Color(0xFF64B5F6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx - 7, center.dy - 2), 3, badgePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
