import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:easypay/design_system/widgets/easypay_shell.dart';
import 'package:easypay/features/payment/application/payment_providers.dart';
import 'package:easypay/features/payment/domain/provider_selection_strategy.dart';
import 'package:easypay/features/settings/application/settings_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final registry = ref.watch(paymentProviderRegistryProvider);
    final channels = ref.watch(returnChannelsProvider);

    return EasyPayShell(
      title: 'Configuracoes',
      child: ListView(
        children: [
          Text('Provedor padrao',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: EasyPaySpacing.xs),
          DropdownButtonFormField<String>(
            initialValue: settings.defaultProviderId,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: registry
                .all()
                .map(
                  (provider) => DropdownMenuItem(
                    value: provider.id,
                    child: Text(provider.displayName),
                  ),
                )
                .toList(growable: false),
            onChanged: (value) {
              if (value == null) return;
              ref.read(defaultProviderIdProvider.notifier).state = value;
              ref.read(appSettingsProvider.notifier).state =
                  settings.copyWith(defaultProviderId: value);
            },
          ),
          const SizedBox(height: EasyPaySpacing.lg),
          Text('Estrategia', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: EasyPaySpacing.xs),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'default', label: Text('Padrao')),
              ButtonSegment(value: 'manual', label: Text('Manual')),
              ButtonSegment(value: 'automatic', label: Text('Auto')),
            ],
            selected: {settings.strategyId},
            onSelectionChanged: (selection) {
              final value = selection.first;
              final strategy = switch (value) {
                'manual' => const ManualProviderStrategy(),
                'automatic' => const AutomaticProviderStrategy(),
                _ => const DefaultProviderStrategy(),
              };
              ref.read(providerSelectionStrategyProvider.notifier).state =
                  strategy;
              ref.read(appSettingsProvider.notifier).state =
                  settings.copyWith(strategyId: value);
            },
          ),
          const SizedBox(height: EasyPaySpacing.lg),
          Text('Provedores habilitados',
              style: Theme.of(context).textTheme.titleMedium),
          ...registry.all().map(
                (provider) => SwitchListTile(
                  value: settings.enabledProviderIds.contains(provider.id),
                  title: Text(provider.displayName),
                  onChanged: (enabled) {
                    final updated = {...settings.enabledProviderIds};
                    enabled
                        ? updated.add(provider.id)
                        : updated.remove(provider.id);
                    ref.read(appSettingsProvider.notifier).state =
                        settings.copyWith(enabledProviderIds: updated);
                  },
                ),
              ),
          const SizedBox(height: EasyPaySpacing.lg),
          Text('Canais de retorno',
              style: Theme.of(context).textTheme.titleMedium),
          ...channels.map(
            (channel) => CheckboxListTile(
              value: settings.enabledReturnChannels.contains(channel.code),
              title: Text(channel.displayName),
              onChanged: (enabled) {
                final updated = {...settings.enabledReturnChannels};
                enabled == true
                    ? updated.add(channel.code)
                    : updated.remove(channel.code);
                ref.read(appSettingsProvider.notifier).state =
                    settings.copyWith(enabledReturnChannels: updated);
              },
            ),
          ),
          const SizedBox(height: EasyPaySpacing.lg),
          FilledButton(
            onPressed: () => context.go('/dev/deep-link-simulator'),
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}
