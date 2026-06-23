import 'package:easypay/core/observability/trace_context.dart';
import 'package:easypay/features/payment/domain/payment_method.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';
import 'package:easypay/features/payment/domain/payment_result.dart';
import 'package:easypay/features/payment/infrastructure/mock/mock_provider.dart';
import 'package:easypay/shared/domain/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mock provider approves payments', () async {
    final provider = MockProvider();
    final result = await provider.processPayment(
      request: const PaymentRequest(
        transactionId: '123',
        money: Money(amount: 10, currency: 'BRL'),
        paymentMethod: PixPaymentMethod(),
        merchant: 'Loja',
        returnChannelCodes: ['CALLBACK'],
      ),
      traceContext: TraceContext(transactionId: '123'),
    );

    expect(result.status, PaymentStatus.approved);
    expect(result.authorizationCode, isNotNull);
  });
}
