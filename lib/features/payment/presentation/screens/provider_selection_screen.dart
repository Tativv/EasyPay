import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:easypay/design_system/widgets/easypay_shell.dart';
import 'package:easypay/features/payment/application/payment_providers.dart';
import 'package:easypay/features/payment/presentation/widgets/provider_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderSelectionScreen extends ConsumerWidget {
  const ProviderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(paymentProviderRegistryProvider);
    final state = ref.watch(paymentFlowControllerProvider);

    return EasyPayShell(
      title: 'Selecionar provedor',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Escolha o provedor para este pagamento.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: EasyPaySpacing.lg),
          ProviderSelector(
            providers: registry.all(),
            selectedProviderId: state.selectedProvider?.id,
            onSelected: (provider) {
              ref
                  .read(paymentFlowControllerProvider.notifier)
                  .selectProvider(provider);
            },
          ),
          const Spacer(),
          FilledButton(
            onPressed: state.selectedProvider == null
                ? null
                : () => context.go('/payment/processing'),
            child: const Text('Continuar'),
          ),
          TextButton(
            onPressed: () => context.go('/payment/received'),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}
