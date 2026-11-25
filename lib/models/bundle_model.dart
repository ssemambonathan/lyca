enum BundleType { data, voice, sms, combo }

class Bundle {
  final String id;
  final String name;
  final BundleType type;
  final int price; // in UGX
  final String validity; // e.g. "30 days"

  const Bundle({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.validity,
  });
}