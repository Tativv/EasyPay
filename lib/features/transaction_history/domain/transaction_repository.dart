import 'package:easypay/features/transaction_history/domain/transaction_record.dart';

abstract interface class TransactionRepository {
  Future<void> save(TransactionRecord transaction);
  Future<List<TransactionRecord>> latest({int limit = 50});
}
