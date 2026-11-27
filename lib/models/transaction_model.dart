enum TransactionType { data, airtime, payment }

enum TransactionStatus { success, failed, pending }

class WalletTransaction {
  final String id;
  final TransactionType type;
  final TransactionStatus status;
  final String title; // e.g. "Data Bundle"
  final String? subtitle; // e.g. "10 GB • 30 Days", can be empty
  final int amount; // UGX
  final DateTime date;

  const WalletTransaction({
    required this.id,
    required this.type,
    required this.status,
    required this.title,
    this.subtitle,
    required this.amount,
    required this.date,
  });
}