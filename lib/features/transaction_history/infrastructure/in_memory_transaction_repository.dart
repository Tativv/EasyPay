import 'package:easypay/features/transaction_history/domain/transaction_record.dart';
import 'package:easypay/features/transaction_history/domain/transaction_repository.dart';

class InMemoryTransactionRepository implements TransactionRepository {
  final List<TransactionRecord> _records = [];

  @override
  Future<List<TransactionRecord>> latest({int limit = 50}) async {
    return _records.take(limit).toList(growable: false);
  }

  @override
  Future<void> save(TransactionRecord transaction) async {
    _records.insert(0, transaction);
  }
}
