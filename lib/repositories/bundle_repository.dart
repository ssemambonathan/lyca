import '../models/bundle_model.dart';

class BundleRepository {
  static const List<Bundle> _bundles = [
    // Data
    Bundle(id: 'd1', name: 'Daily Bundles', type: BundleType.data, allowance: '1 GB', validity: '1 Day', price: 2000),
    Bundle(id: 'd2', name: 'Weekly Bundles', type: BundleType.data, allowance: '5 GB', validity: '7 Days', price: 10000),
    Bundle(id: 'd3', name: 'Monthly Bundles', type: BundleType.data, allowance: '10 GB', validity: '30 Days', price: 15000),
    Bundle(id: 'd4', name: 'International Bundles', type: BundleType.data, allowance: 'Call', validity: '7 Days', price: 25000, isInternational: true),
    // Voice
    Bundle(id: 'v1', name: 'Daily Voice', type: BundleType.voice, allowance: '30 Mins', validity: '1 Day', price: 1500),
    Bundle(id: 'v2', name: 'Weekly Voice', type: BundleType.voice, allowance: '200 Mins', validity: '7 Days', price: 7000),
    Bundle(id: 'v3', name: 'Monthly Voice', type: BundleType.voice, allowance: '1,000 Mins', validity: '30 Days', price: 25000),
    Bundle(id: 'v4', name: 'International Voice', type: BundleType.voice, allowance: '100 Mins', validity: '7 Days', price: 30000, isInternational: true),
    // SMS
    Bundle(id: 's1', name: 'Daily SMS', type: BundleType.sms, allowance: '100 SMS', validity: '1 Day', price: 500),
    Bundle(id: 's2', name: 'Weekly SMS', type: BundleType.sms, allowance: '500 SMS', validity: '7 Days', price: 2500),
    Bundle(id: 's3', name: 'Monthly SMS', type: BundleType.sms, allowance: '2,000 SMS', validity: '30 Days', price: 8000),
    // Combo
    Bundle(id: 'c1', name: 'Daily Super Combo', type: BundleType.combo, allowance: '1.5 GB + 50 Mins', validity: '1 Day', price: 3500),
    Bundle(id: 'c2', name: 'Weekly Mega Combo', type: BundleType.combo, allowance: '10 GB + 200 Mins + 100 SMS', validity: '7 Days', price: 20000),
    Bundle(id: 'c3', name: 'Monthly Ultimate Combo', type: BundleType.combo, allowance: '30 GB + 1,000 Mins + 500 SMS', validity: '30 Days', price: 55000),
  ];

  Future<List<Bundle>> getBundles() async => _bundles;

  Future<List<Bundle>> getByType(BundleType type) async =>
      _bundles.where((b) => b.type == type).toList();

  Future<Bundle?> getById(String id) async {
    for (final b in _bundles) {
      if (b.id == id) return b;
    }
    return null;
  }

  Future<List<Bundle>> search(String query) async {
    final q = query.toLowerCase();
    return _bundles
        .where((b) =>
    b.name.toLowerCase().contains(q) ||
        b.summary.toLowerCase().contains(q))
        .toList();
  }
}
