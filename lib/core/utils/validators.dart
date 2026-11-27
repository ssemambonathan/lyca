const _phoneLengths = {
  '+256': 9, // Uganda
  '+44': 10, // United Kingdom
  '+353': 9, // Ireland
};

/// Returns an error message, or null if the number looks valid.
String? validatePhoneNumber(String countryCode, String input) {
  var digits = input.replaceAll(RegExp(r'[\s-]'), '');
  if (digits.isEmpty) return 'Enter your phone number';
  if (!RegExp(r'^\d+$').hasMatch(digits)) return 'Use digits only';
  if (digits.startsWith('0')) digits = digits.substring(1);

  final expected = _phoneLengths[countryCode];
  if (expected != null) {
    if (digits.length != expected) {
      return 'Number should be $expected digits (without the leading 0)';
    }
  } else if (digits.length < 7 || digits.length > 12) {
    return 'Enter a valid phone number';
  }
  return null;
}