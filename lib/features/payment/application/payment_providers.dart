import 'package:easypay/features/payment/application/deep_link_parser.dart';
import 'package:easypay/features/payment/application/payment_contract_parser.dart';
import 'package:easypay/features/payment/application/payment_processor.dart';
import 'package:easypay/features/payment/application/payment_state.dart';
import 'package:easypay/features/payment/domain/payment_provider.dart';
import 'package:easypay/features/payment/domain/payment_provider_registry.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';
import 'package:easypay/features/payment/domain/payment_result.dart';
import 'package:easypay/features/payment/domain/provider_selection_strategy.dart';
import 'package:easypay/features/payment/domain/return_channel.dart';
import 'package:easypay/features/payment/infrastructure/mock/mock_provider.dart';
import 'package:easypay/features/payment/infrastructure/payment_providers_module.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final paymentContractParserProvider = Provider<PaymentContractParser>((ref) {
  return PaymentContractParserV1();
});

final deepLinkPaymentParserProvider = Provider<DeepLinkPaymentParser>((ref) {
  return VersionedDeepLinkPaymentParser(
    parsers: {'v1': ref.watch(paymentContractParserProvider)},
  );
});

final mockProviderScenarioProvider =
    StateProvider<MockProviderScenario>((ref) => MockProviderScenario.approved);

final mockPaymentProviderProvider = Provider<MockProvider>((ref) {
  return MockProvider(scenario: ref.watch(mockProviderScenarioProvider));
});

final paymentProviderRegistryProvider =
    Provider<PaymentProviderRegistry>((ref) {
  return const PaymentProvidersModule().buildRegistry(
    ref.watch(mockPaymentProviderProvider),
  );
});

final providerSelectionStrategyProvider =
    StateProvider<ProviderSelectionStrategy>((ref) {
  return const DefaultProviderStrategy();
});

final defaultProviderIdProvider = StateProvider<String?>((ref) => 'mock');

final returnChannelsProvider = Provider<List<ReturnChannel>>((ref) {
  return const [
    CallbackChannel(),
    WebhookChannel(),
    QueueChannel(),
    NotificationChannel(),
    PollingChannel(),
  ];
});

final paymentProcessorProvider = Provider<PaymentProcessor>((ref) {
  return PaymentProcessor(
    registry: ref.watch(paymentProviderRegistryProvider),
    strategy: ref.watch(providerSelectionStrategyProvider),
    returnChannels: ref.watch(returnChannelsProvider),
    preferredProviderId: ref.watch(defaultProviderIdProvider),
  );
});

final paymentFlowControllerProvider =
    NotifierProvider<PaymentFlowController, PaymentState>(
  PaymentFlowController.new,
);

class PaymentFlowController extends Notifier<PaymentState> {
  @override
  PaymentState build() => const PaymentState();

  void receive(PaymentRequest request) {
    state = PaymentState(request: request);
  }

  void selectProvider(PaymentProvider provider) {
    state = state.copyWith(selectedProvider: provider);
  }

  Future<PaymentResult?> process() async {
    final request = state.request;
    if (request == null) {
      state = state.copyWith(errorMessage: 'Nenhum pagamento recebido.');
      return null;
    }

    state = state.copyWith(isProcessing: true, clearResult: true);
    final result = await ref.read(paymentProcessorProvider).execute(request);
    state = state.copyWith(isProcessing: false, result: result);
    return result;
  }

  PaymentRequest parseDeepLink(String deepLink) {
    final parsed =
        ref.read(deepLinkPaymentParserProvider).parse(Uri.parse(deepLink));
    receive(parsed.request);
    return parsed.request;
  }
}
