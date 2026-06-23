enum PaymentStatus { approved, rejected, cancelled, timeout }

class PaymentResult {
  const PaymentResult({
    required this.status,
    required this.transactionId,
    required this.providerId,
    this.authorizationCode,
    this.reason,
  });

  final PaymentStatus status;
  final String transactionId;
  final String providerId;
  final String? authorizationCode;
  final String? reason;

  bool get approved => status == PaymentStatus.approved;
}
