import 'dart:convert';

import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:easypay/design_system/widgets/easypay_app_logo.dart';
import 'package:easypay/design_system/widgets/easypay_shell.dart';
import 'package:easypay/features/payment/application/payment_providers.dart';
import 'package:easypay/features/payment/infrastructure/mock/mock_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeepLinkSimulatorScreen extends HookConsumerWidget {
  const DeepLinkSimulatorScreen({super.key});

  static const _sampleJson = '''
{
  "transactionId": "123",
  "amount": 150.50,
  "currency": "BRL",
  "paymentMethod": "CREDIT",
  "installments": 3,
  "merchant": "Loja XPTO",
  "reference": "PEDIDO-123",
  "returnChannels": ["CALLBACK"]
}''';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonController = useTextEditingController(text: _sampleJson);
    final base64Controller = useTextEditingController();
    final deepLinkController = useTextEditingController();
    final decodedController = useTextEditingController();
    final scenario = ref.watch(mockProviderScenarioProvider);

    void serialize() {
      final parsed = jsonDecode(jsonController.text) as Map<String, dynamic>;
      jsonController.text = const JsonEncoder.withIndent('  ').convert(parsed);
    }

    void convertToBase64() {
      base64Controller.text =
          base64Url.encode(utf8.encode(jsonController.text));
    }

    void generateDeepLink() {
      if (base64Controller.text.isEmpty) convertToBase64();
      deepLinkController.text =
          'mypay://v1/payment?request=${base64Controller.text}';
    }

    void decodePayload() {
      final raw = base64Controller.text;
      if (raw.isEmpty) return;
      decodedController.text =
          utf8.decode(base64Url.decode(base64.normalize(raw)));
    }

    return EasyPayShell(
      title: 'Deep Link Simulator',
      actions: [
        IconButton(
          tooltip: 'Configuracoes',
          onPressed: () => context.go('/settings'),
          icon: const Icon(Icons.tune_rounded),
        ),
      ],
      child: ListView(
        children: [
          Row(
            children: [
              const EasyPayAppLogo(size: 48),
              const SizedBox(width: EasyPaySpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EasyPay',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      'Plataforma de integracao de pagamentos',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: EasyPaySpacing.lg),
          _Section(
            title: 'Mock Provider',
            child: DropdownButtonFormField<MockProviderScenario>(
              initialValue: scenario,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: MockProviderScenario.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (value) {
                if (value != null) {
                  ref.read(mockProviderScenarioProvider.notifier).state = value;
                }
              },
            ),
          ),
          _Section(
            title: 'JSON',
            child: TextField(
              controller: jsonController,
              minLines: 8,
              maxLines: 12,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Wrap(
            spacing: EasyPaySpacing.sm,
            runSpacing: EasyPaySpacing.sm,
            children: [
              OutlinedButton.icon(
                onPressed: serialize,
                icon: const Icon(Icons.data_object_rounded),
                label: const Text('Serializar'),
              ),
              OutlinedButton.icon(
                onPressed: convertToBase64,
                icon: const Icon(Icons.swap_vert_rounded),
                label: const Text('Base64'),
              ),
              OutlinedButton.icon(
                onPressed: generateDeepLink,
                icon: const Icon(Icons.link_rounded),
                label: const Text('Gerar link'),
              ),
            ],
          ),
          _Section(
            title: 'Base64',
            child: TextField(
              controller: base64Controller,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          _Section(
            title: 'Deep Link',
            child: TextField(
              controller: deepLinkController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    if (deepLinkController.text.isEmpty) generateDeepLink();
                    ref
                        .read(paymentFlowControllerProvider.notifier)
                        .parseDeepLink(deepLinkController.text);
                    context.go('/payment/received');
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Executar'),
                ),
              ),
              const SizedBox(width: EasyPaySpacing.sm),
              IconButton.filledTonal(
                tooltip: 'Decodificar',
                onPressed: decodePayload,
                icon: const Icon(Icons.visibility_rounded),
              ),
            ],
          ),
          _Section(
            title: 'Payload decodificado',
            child: TextField(
              controller: decodedController,
              minLines: 4,
              maxLines: 8,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: EasyPayColors.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: EasyPaySpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: EasyPaySpacing.xs),
          child,
        ],
      ),
    );
  }
}
