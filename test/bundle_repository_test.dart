import 'package:flutter_test/flutter_test.dart';
import 'package:lyca/core/utils/formatters.dart';
import 'package:lyca/models/bundle_model.dart';
import 'package:lyca/repositories/bundle_repository.dart';

void main() {
  final repo = BundleRepository();

  test('has the right number of bundles per type', () async {
    expect((await repo.getByType(BundleType.data)).length, 4);
    expect((await repo.getByType(BundleType.voice)).length, 4);
    expect((await repo.getByType(BundleType.sms)).length, 3);
    expect((await repo.getByType(BundleType.combo)).length, 3);
  });

  test('finds a bundle by id', () async {
    final b = await repo.getById('c3');
    expect(b?.price, 55000);
    expect(b?.summary, '30 GB + 1,000 Mins + 500 SMS • 30 Days');
  });

  test('formats UGX like the screens do', () {
    expect(formatUgx(500), 'UGX 500');
    expect(formatUgx(2000), 'UGX 2,000');
    expect(formatUgx(55000), 'UGX 55,000');
  });
}