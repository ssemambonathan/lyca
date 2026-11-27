import '../models/user_model.dart';

class AuthRepository {
  /// Demo code until a real SMS service exists (Phase 5).
  static const String demoOtp = '123456';

  User? _currentUser;
  String? _pin;

  Future<void> sendOtp(String phoneNumber) async {
    // Fake: a real version will call the API service to send an SMS.
  }

  Future<bool> verifyOtp(String phoneNumber, String code) async {
    if (code != demoOtp) return false;
    _currentUser = User(
      name: 'Lyca Customer', // placeholder until the profile is edited
      phoneNumber: phoneNumber,
      airtimeBalance: 25000, // matches the balance your screens show today
    );
    return true;
  }

  Future<bool> hasPin() async => _pin != null;

  Future<void> savePin(String pin) async {
    _pin = pin;
  }

  Future<bool> verifyPin(String pin) async => _pin != null && _pin == pin;

  Future<User?> getCurrentUser() async => _currentUser;

  /// Logging out clears the session and the PIN, so the next login
  /// goes through the number, OTP and PIN steps again.
  Future<void> logout() async {
    _currentUser = null;
    _pin = null;
  }
}