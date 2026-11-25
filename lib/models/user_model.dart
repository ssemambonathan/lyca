class User {
  final String name;
  final String phoneNumber;
  final int airtimeBalance; // UGX
  final double dataBalanceGb;
  final int smsBalance;

  const User({
    required this.name,
    required this.phoneNumber,
    this.airtimeBalance = 0,
    this.dataBalanceGb = 0,
    this.smsBalance = 0,
  });

  User copyWith({
    String? name,
    String? phoneNumber,
    int? airtimeBalance,
    double? dataBalanceGb,
    int? smsBalance,
  }) {
    return User(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      airtimeBalance: airtimeBalance ?? this.airtimeBalance,
      dataBalanceGb: dataBalanceGb ?? this.dataBalanceGb,
      smsBalance: smsBalance ?? this.smsBalance,
    );
  }
}