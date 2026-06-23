import 'package:easypay/features/payment/domain/payment_provider_registry.dart';
import 'package:easypay/features/provider_management/domain/provider_descriptor.dart';

class ProviderManagementService {
  const ProviderManagementService(this._registry);

  final PaymentProviderRegistry _registry;

  List<ProviderDescriptor> listProviders() {
    return _registry.all().map((provider) {
      final capabilities = provider.getCapabilities();
      return ProviderDescriptor(
        id: provider.id,
        displayName: provider.displayName,
        enabled: true,
        capabilityCodes: capabilities.supportedMethods
            .map((method) => method.code)
            .toList(growable: false),
      );
    }).toList(growable: false);
  }
}
