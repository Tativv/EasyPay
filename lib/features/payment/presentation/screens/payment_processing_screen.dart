import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:easypay/design_system/widgets/easypay_app_logo.dart';
import 'package:easypay/design_system/widgets/easypay_shell.dart';
import 'package:easypay/features/payment/application/payment_providers.dart';
import 'package:easypay/features/payment/domain/payment_result.dart';
import 'package:easypay/features/payment/presentation/widgets/info_row.dart';
import 'package:easypay/features/payment/presentation/widgets/loading_payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentProcessingScreen extends HookConsumerWidget {
  const PaymentProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentFlowControllerProvider);
    final started = useRef(false);

    useEffect(() {
      if (started.value) return null;
      started.value = true;
      Future<void>(() async {
        final result =
            await ref.read(paymentFlowControllerProvider.notifier).process();
        if (!context.mounted) return;
        context.go(
          result?.status == PaymentStatus.approved
              ? '/payment/approved'
              : '/payment/rejected',
        );
      });
      return null;
    }, const []);

    final request = state.request;

    return EasyPayShell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EasyPayAppLogo(),
          const SizedBox(height: EasyPaySpacing.xl),
          Text('Processando pagamento',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: EasyPaySpacing.xl),
          const LoadingPaymentWidget(),
          const SizedBox(height: EasyPaySpacing.xl),
          Text(
            'Estamos processando seu pagamento',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: EasyPaySpacing.sm),
          Text(
            'Por favor, nao feche o aplicativo.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: EasyPaySpacing.xl),
          if (request != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(EasyPaySpacing.md),
                child: Column(
                  children: [
                    InfoRow(
                        label: 'Referencia', value: request.reference ?? '-'),
                    InfoRow(label: 'Valor', value: request.money.format()),
                    InfoRow(
                        label: 'Metodo',
                        value: request.paymentMethod.displayName),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
