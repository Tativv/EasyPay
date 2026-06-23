import 'package:easypay/features/payment/domain/payment_method.dart';
import 'package:easypay/shared/domain/money.dart';

class PaymentRequest {
  const PaymentRequest({
    required this.transactionId,
    required this.money,
    required this.paymentMethod,
    required this.merchant,
    required this.returnChannelCodes,
    this.installments = 1,
    this.reference,
    this.metadata = const {},
  });

  final String transactionId;
  final Money money;
  final PaymentMethod paymentMethod;
  final int installments;
  final String merchant;
  final String? reference;
  final List<String> returnChannelCodes;
  final Map<String, Object?> metadata;

  Map<String, Object?> toJson() => {
        'transactionId': transactionId,
        'amount': money.amount,
        'currency': money.currency,
        'paymentMethod': paymentMethod.code,
        'installments': installments,
        'merchant': merchant,
        'reference': reference,
        'returnChannels': returnChannelCodes,
        'metadata': metadata,
      };
}
