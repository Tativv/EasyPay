import 'package:easypay/core/observability/trace_context.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';
import 'package:easypay/features/payment/domain/payment_result.dart';
import 'package:easypay/features/payment/domain/provider_capabilities.dart';

abstract interface class PaymentProvider {
  String get id;
  String get displayName;

  Future<void> initialize();

  Future<PaymentResult> processPayment({
    required PaymentRequest request,
    required TraceContext traceContext,
  });

  Future<PaymentResult> cancelPayment({
    required String transactionId,
    required TraceContext traceContext,
  });

  ProviderCapabilities getCapabilities();

  Future<ProviderHealth> healthCheck();
}

class ProviderHealth {
  const ProviderHealth({
    required this.available,
    this.latency,
    this.message,
  });

  final bool available;
  final Duration? latency;
  final String? message;
}
