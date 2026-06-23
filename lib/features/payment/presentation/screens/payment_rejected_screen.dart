import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:easypay/design_system/widgets/easypay_shell.dart';
import 'package:easypay/features/payment/application/payment_providers.dart';
import 'package:easypay/features/payment/presentation/widgets/payment_status_indicator.dart';
import 'package:easypay/features/payment/presentation/widgets/result_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentRejectedScreen extends ConsumerWidget {
  const PaymentRejectedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentFlowControllerProvider);
    final result = state.result;
    final request = state.request;

    return EasyPayShell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PaymentStatusIndicator.rejected(),
          const SizedBox(height: EasyPaySpacing.xl),
          Text('Pagamento nao aprovado',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: EasyPaySpacing.sm),
          Text(
            'Nao foi possivel processar o pagamento.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: EasyPaySpacing.lg),
          if (result != null && request != null)
            ResultCard(
              result: result,
              amount: request.money.format(),
              reference: request.reference,
            ),
          const SizedBox(height: EasyPaySpacing.lg),
          FilledButton(
            onPressed: () => context.go('/payment/processing'),
            child: const Text('Tentar novamente'),
          ),
          TextButton(
            onPressed: () => context.go('/dev/deep-link-simulator'),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}
