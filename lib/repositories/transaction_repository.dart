import '../models/transaction_model.dart';

class TransactionRepository {
  static DateTime _daysAgo(int days, int hour, int minute) {
    final d = DateTime.now().subtract(Duration(days: days));
    return DateTime(d.year, d.month, d.day, hour, minute);
  }

  final List<WalletTransaction> _transactions = [
    WalletTransaction(
      id: 't1',
      type: TransactionType.data,
      status: TransactionStatus.success,
      title: 'Data Bundle',
      subtitle: '10 GB • 30 Days',
      amount: 15000,
      date: _daysAgo(0, 15, 45),
    ),
    WalletTransaction(
      id: 't2',
      type: TransactionType.airtime,
      status: TransactionStatus.success,
      title: 'Airtime Top-up',
      amount: 5000,
      date: _daysAgo(0, 13, 20),
    ),
    WalletTransaction(
      id: 't3',
      type: TransactionType.airtime,
      status: TransactionStatus.success,
      title: 'Airtime Transfer',
      subtitle: '+256 776 123456',
      amount: 5000,
      date: _daysAgo(1, 17, 12),
    ),
    WalletTransaction(
      id: 't4',
      type: TransactionType.payment,
      status: TransactionStatus.success,
      title: 'Payment',
      subtitle: 'Card Payment',
      amount: 20000,
      date: _daysAgo(11, 14, 30),
    ),
    WalletTransaction(
      id: 't5',
      type: TransactionType.data,
      status: TransactionStatus.success,
      title: 'Combo Bundle',
      subtitle: '5 GB + 100 Min',
      amount: 12000,
      date: _daysAgo(12, 18, 17),
    ),
  ];

  /// Newest first. Pass a type to filter (All = no type).
  Future<List<WalletTransaction>> getTransactions({
    TransactionType? type,
  }) async {
    final list = type == null
        ? [..._transactions]
        : _transactions.where((t) => t.type == type).toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  Future<WalletTransaction?> getById(String id) async {
    for (final t in _transactions) {
      if (t.id == id) return t;
    }
    return null;
  }

  /// Used by the bundle purchase flow in Phase 6.
  Future<void> add(WalletTransaction transaction) async {
    _transactions.add(transaction);
  }
}