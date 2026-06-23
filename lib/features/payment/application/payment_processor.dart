import 'package:easypay/core/observability/structured_logger.dart';
import 'package:easypay/core/observability/trace_context.dart';
import 'package:easypay/features/payment/domain/payment_provider_registry.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';
import 'package:easypay/features/payment/domain/payment_result.dart';
import 'package:easypay/features/payment/domain/provider_selection_strategy.dart';
import 'package:easypay/features/payment/domain/return_channel.dart';

class PaymentProcessor {
  const PaymentProcessor({
    required PaymentProviderRegistry registry,
    required ProviderSelectionStrategy strategy,
    required List<ReturnChannel> returnChannels,
    StructuredLogger logger = const StructuredLogger(),
    String? preferredProviderId,
  })  : _registry = registry,
        _strategy = strategy,
        _returnChannels = returnChannels,
        _logger = logger,
        _preferredProviderId = preferredProviderId;

  final PaymentProviderRegistry _registry;
  final ProviderSelectionStrategy _strategy;
  final List<ReturnChannel> _returnChannels;
  final StructuredLogger _logger;
  final String? _preferredProviderId;

  Future<PaymentResult> execute(PaymentRequest request) async {
    final trace = TraceContext(transactionId: request.transactionId);
    _logger.info('payment.started', fields: trace.toLogFields());

    final provider = await _strategy.select(
      request: request,
      registry: _registry,
      preferredProviderId: _preferredProviderId,
    );

    if (provider == null) {
      return PaymentResult(
        status: PaymentStatus.rejected,
        transactionId: request.transactionId,
        providerId: 'none',
        reason: 'Nenhum provedor disponivel para o metodo informado.',
      );
    }

    final result = await provider.processPayment(
      request: request,
      traceContext: trace,
    );

    for (final channel in _returnChannels) {
      if (request.returnChannelCodes.contains(channel.code)) {
        await channel.send(result);
      }
    }

    _logger.info(
      'payment.finished',
      fields: {...trace.toLogFields(), 'status': result.status.name},
    );
    return result;
  }
}
