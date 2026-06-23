import 'package:easypay/features/payment/domain/payment_method.dart';
import 'package:easypay/features/payment/domain/payment_provider.dart';

abstract interface class PaymentProviderRegistry {
  void register(PaymentProvider provider);
  List<PaymentProvider> all();
  PaymentProvider? findById(String id);
  List<PaymentProvider> findSupporting(PaymentMethod method);
}

class InMemoryPaymentProviderRegistry implements PaymentProviderRegistry {
  final Map<String, PaymentProvider> _providers = {};

  @override
  void register(PaymentProvider provider) {
    _providers[provider.id] = provider;
  }

  @override
  List<PaymentProvider> all() => List.unmodifiable(_providers.values);

  @override
  PaymentProvider? findById(String id) => _providers[id];

  @override
  List<PaymentProvider> findSupporting(PaymentMethod method) {
    return _providers.values
        .where((provider) => provider.getCapabilities().supports(method))
        .toList(growable: false);
  }
}
