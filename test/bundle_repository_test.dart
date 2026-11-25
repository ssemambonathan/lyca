import 'package:flutter_test/flutter_test.dart';
import 'package:lyca/models/bundle_model.dart';
import 'package:lyca/repositories/bundle_repository.dart';

void main() {
  late BundleRepository repository;

  setUp(() {
    repository = BundleRepository();
  });

  test('getBundles returns all bundles', () async {
    final bundles = await repository.getBundles();
    expect(bundles.isNotEmpty, isTrue);
  });

  test('getBundlesByType filters by type correctly', () async {
    final dataBundles = await repository.getBundlesByType(BundleType.data);
    expect(dataBundles.every((b) => b.type == BundleType.data), isTrue);
  });

  test('getBundleById returns bundle when found', () async {
    final bundle = await repository.getBundleById('d1');
    expect(bundle, isNotNull);
    expect(bundle?.name, 'Daily Bundles');
  });

  test('searchBundles filters bundles matching query', () async {
    final results = await repository.searchBundles('Mega');
    expect(results.length, 1);
    expect(results.first.name, 'Weekly Mega Combo');
  });
}
