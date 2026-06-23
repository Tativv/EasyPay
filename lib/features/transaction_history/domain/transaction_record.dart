class TransactionRecord {
  const TransactionRecord({
    required this.transactionId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    this.reference,
    this.providerId,
  });

  final String transactionId;
  final double amount;
  final String currency;
  final String status;
  final DateTime createdAt;
  final String? reference;
  final String? providerId;
}
