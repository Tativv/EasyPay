import 'package:easypay/features/payment/domain/payment_provider_registry.dart';
import 'package:easypay/features/payment/infrastructure/mock/mock_provider.dart';

class PaymentProvidersModule {
  const PaymentProvidersModule();

  PaymentProviderRegistry buildRegistry(MockProvider mockProvider) {
    final registry = InMemoryPaymentProviderRegistry();
    registry.register(mockProvider);
    return registry;
  }
}
