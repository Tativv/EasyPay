import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:easypay/design_system/widgets/easypay_app_logo.dart';
import 'package:easypay/design_system/widgets/easypay_shell.dart';
import 'package:easypay/features/payment/application/payment_providers.dart';
import 'package:easypay/features/payment/domain/provider_selection_strategy.dart';
import 'package:easypay/features/payment/presentation/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentReceivedScreen extends ConsumerWidget {
  const PaymentReceivedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentFlowControllerProvider);
    final request = state.request;

    return EasyPayShell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EasyPayAppLogo(size: 72),
          const SizedBox(height: EasyPaySpacing.xl),
          Text('Solicitacao recebida',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: EasyPaySpacing.sm),
          Text(
            'Revise os dados antes de continuar com seguranca.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: EasyPaySpacing.lg),
          if (request != null) PaymentCard(request: request),
          const SizedBox(height: EasyPaySpacing.lg),
          FilledButton(
            onPressed: request == null
                ? null
                : () {
                    final strategy =
                        ref.read(providerSelectionStrategyProvider);
                    context.go(
                      strategy is ManualProviderStrategy
                          ? '/payment/providers'
                          : '/payment/processing',
                    );
                  },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}
