import 'dart:async';

import 'package:easypay/core/observability/trace_context.dart';
import 'package:easypay/features/payment/domain/payment_method.dart';
import 'package:easypay/features/payment/domain/payment_provider.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';
import 'package:easypay/features/payment/domain/payment_result.dart';
import 'package:easypay/features/payment/domain/provider_capabilities.dart';

enum MockProviderScenario { approved, rejected, cancelled, timeout }

class MockProvider implements PaymentProvider {
  MockProvider({this.scenario = MockProviderScenario.approved});

  MockProviderScenario scenario;

  @override
  String get id => 'mock';

  @override
  String get displayName => 'Mock Provider';

  @override
  Future<void> initialize() async {}

  @override
  Future<PaymentResult> processPayment({
    required PaymentRequest request,
    required TraceContext traceContext,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    switch (scenario) {
      case MockProviderScenario.approved:
        return PaymentResult(
          status: PaymentStatus.approved,
          transactionId: request.transactionId,
          providerId: id,
          authorizationCode: 'AUTH-${DateTime.now().millisecondsSinceEpoch}',
        );
      case MockProviderScenario.rejected:
        return PaymentResult(
          status: PaymentStatus.rejected,
          transactionId: request.transactionId,
          providerId: id,
          reason: 'Fundos insuficientes.',
        );
      case MockProviderScenario.cancelled:
        return PaymentResult(
          status: PaymentStatus.cancelled,
          transactionId: request.transactionId,
          providerId: id,
          reason: 'Pagamento cancelado.',
        );
      case MockProviderScenario.timeout:
        await Future<void>.delayed(const Duration(seconds: 4));
        return PaymentResult(
          status: PaymentStatus.timeout,
          transactionId: request.transactionId,
          providerId: id,
          reason: 'Tempo limite excedido.',
        );
    }
  }

  @override
  Future<PaymentResult> cancelPayment({
    required String transactionId,
    required TraceContext traceContext,
  }) async {
    return PaymentResult(
      status: PaymentStatus.cancelled,
      transactionId: transactionId,
      providerId: id,
      reason: 'Cancelado no mock.',
    );
  }

  @override
  ProviderCapabilities getCapabilities() {
    return const ProviderCapabilities(
      supportedMethods: [
        PixPaymentMethod(),
        CreditPaymentMethod(),
        DebitPaymentMethod(),
        VoucherPaymentMethod(),
        WalletPaymentMethod(walletName: 'Wallet'),
      ],
      supportsCancel: true,
      supportsInstallments: true,
      supportsTapToPay: true,
    );
  }

  @override
  Future<ProviderHealth> healthCheck() async {
    return const ProviderHealth(
        available: true, latency: Duration(milliseconds: 20));
  }
}
