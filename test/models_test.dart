import 'package:flutter_test/flutter_test.dart';
import 'package:lyca/models/user_model.dart';

void main() {
  test('copyWith changes only the given field', () {
    const user = User(name: 'Test', phoneNumber: '+256700000000');
    final updated = user.copyWith(airtimeBalance: 5000);
    expect(updated.airtimeBalance, 5000);
    expect(updated.name, 'Test');
  });
}