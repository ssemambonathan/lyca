import 'package:flutter_test/flutter_test.dart';
import 'package:lyca/core/utils/formatters.dart';
import 'package:lyca/models/transaction_model.dart';
import 'package:lyca/repositories/transaction_repository.dart';

void main() {
  test('filters by type like the screen tabs', () async {
    final repo = TransactionRepository();
    expect((await repo.getTransactions()).length, 5);
    expect((await repo.getTransactions(type: TransactionType.data)).length, 2);
    expect((await repo.getTransactions(type: TransactionType.airtime)).length, 2);
    expect((await repo.getTransactions(type: TransactionType.payment)).length, 1);
  });

  test('newest first, and add() puts a new one on top', () async {
    final repo = TransactionRepository();
    final before = await repo.getTransactions();
    expect(before.first.id, 't1');

    await repo.add(WalletTransaction(
      id: 'new',
      type: TransactionType.data,
      status: TransactionStatus.success,
      title: 'Test',
      amount: 1000,
      date: DateTime.now().add(const Duration(minutes: 1)),
    ));
    final after = await repo.getTransactions();
    expect(after.length, 6);
    expect(after.first.id, 'new');
  });

  test('formats time and day labels', () {
    expect(formatTime(DateTime(2026, 11, 27, 15, 45)), '3:45 PM');
    expect(formatTime(DateTime(2026, 11, 27, 0, 5)), '12:05 AM');

    final now = DateTime(2026, 11, 27, 10, 0);
    expect(formatDayLabel(DateTime(2026, 11, 27, 8, 0), now: now), 'Today');
    expect(formatDayLabel(DateTime(2026, 11, 26, 8, 0), now: now), 'Yesterday');
    expect(formatDayLabel(DateTime(2026, 11, 16, 8, 0), now: now), '16 Nov');
  });
}