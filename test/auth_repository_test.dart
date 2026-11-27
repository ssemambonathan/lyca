import 'package:flutter_test/flutter_test.dart';
import 'package:lyca/core/utils/validators.dart';
import 'package:lyca/repositories/auth_repository.dart';

void main() {
  group('AuthRepository', () {
    test('rejects a wrong OTP and logs nobody in', () async {
      final repo = AuthRepository();
      expect(await repo.verifyOtp('+256 772345678', '000000'), false);
      expect(await repo.getCurrentUser(), isNull);
    });

    test('accepts the demo OTP and creates the user', () async {
      final repo = AuthRepository();
      expect(await repo.verifyOtp('+256 772345678', '123456'), true);
      final user = await repo.getCurrentUser();
      expect(user?.phoneNumber, '+256 772345678');
      expect(user?.airtimeBalance, 25000);
    });

    test('saves and checks the PIN', () async {
      final repo = AuthRepository();
      expect(await repo.hasPin(), false);
      await repo.savePin('1234');
      expect(await repo.hasPin(), true);
      expect(await repo.verifyPin('1234'), true);
      expect(await repo.verifyPin('0000'), false);
    });

    test('logout clears the user and the PIN', () async {
      final repo = AuthRepository();
      await repo.verifyOtp('+256 772345678', '123456');
      await repo.savePin('1234');
      await repo.logout();
      expect(await repo.getCurrentUser(), isNull);
      expect(await repo.hasPin(), false);
    });
  });

  group('validatePhoneNumber', () {
    test('accepts good Ugandan numbers', () {
      expect(validatePhoneNumber('+256', '772345678'), isNull);
      expect(validatePhoneNumber('+256', '0772 345 678'), isNull);
    });

    test('rejects bad input', () {
      expect(validatePhoneNumber('+256', ''), 'Enter your phone number');
      expect(validatePhoneNumber('+256', 'abc'), 'Use digits only');
      expect(validatePhoneNumber('+256', '77234'), isNotNull);
    });

    test('knows UK numbers are 10 digits', () {
      expect(validatePhoneNumber('+44', '7911123456'), isNull);
      expect(validatePhoneNumber('+44', '791112345'), isNotNull);
    });
  });
}