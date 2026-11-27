enum BundleType { data, voice, sms, combo }

class Bundle {
  final String id;
  final String name;
  final BundleType type;
  final String allowance; // e.g. "1 GB", "200 Mins"
  final String validity; // e.g. "7 Days"
  final int price; // UGX
  final bool isInternational;

  const Bundle({
    required this.id,
    required this.name,
    required this.type,
    required this.allowance,
    required this.validity,
    required this.price,
    this.isInternational = false,
  });

  /// Matches what your screens show today, e.g. "1 GB • 1 Day"
  String get summary => '$allowance • $validity';
}