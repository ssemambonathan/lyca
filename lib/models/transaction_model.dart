enum TransactionStatus { success, failed, pending }

enum TransactionType { bundle, airtime, topUp, withdrawal }

class Transaction {
  final String id;
  final TransactionType type;
  final TransactionStatus status;
  final int amount; // UGX
  final String description;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.type,
    required this.status,
    required this.amount,
    required this.description,
    required this.date,
  });
}