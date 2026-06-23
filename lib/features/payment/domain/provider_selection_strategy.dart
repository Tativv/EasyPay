import 'package:easypay/features/payment/domain/payment_provider.dart';
import 'package:easypay/features/payment/domain/payment_provider_registry.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';

abstract interface class ProviderSelectionStrategy {
  String get id;
  String get displayName;

  Future<PaymentProvider?> select({
    required PaymentRequest request,
    required PaymentProviderRegistry registry,
    String? preferredProviderId,
  });
}

class DefaultProviderStrategy implements ProviderSelectionStrategy {
  const DefaultProviderStrategy();

  @override
  String get id => 'default';

  @override
  String get displayName => 'Padrao';

  @override
  Future<PaymentProvider?> select({
    required PaymentRequest request,
    required PaymentProviderRegistry registry,
    String? preferredProviderId,
  }) async {
    final preferred = registry.findById(preferredProviderId ?? '');
    if (preferred != null) return preferred;

    final candidates = registry.findSupporting(request.paymentMethod);
    return candidates.isEmpty ? null : candidates.first;
  }
}

class ManualProviderStrategy implements ProviderSelectionStrategy {
  const ManualProviderStrategy();

  @override
  String get id => 'manual';

  @override
  String get displayName => 'Manual';

  @override
  Future<PaymentProvider?> select({
    required PaymentRequest request,
    required PaymentProviderRegistry registry,
    String? preferredProviderId,
  }) async {
    return registry.findById(preferredProviderId ?? '');
  }
}

class AutomaticProviderStrategy implements ProviderSelectionStrategy {
  const AutomaticProviderStrategy();

  @override
  String get id => 'automatic';

  @override
  String get displayName => 'Automatico';

  @override
  Future<PaymentProvider?> select({
    required PaymentRequest request,
    required PaymentProviderRegistry registry,
    String? preferredProviderId,
  }) async {
    final candidates = registry.findSupporting(request.paymentMethod);
    for (final provider in candidates) {
      final health = await provider.healthCheck();
      if (health.available) return provider;
    }
    return null;
  }
}
