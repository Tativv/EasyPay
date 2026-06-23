import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:easypay/features/payment/domain/payment_provider.dart';
import 'package:easypay/features/payment/presentation/widgets/provider_badge.dart';
import 'package:flutter/material.dart';

class ProviderSelector extends StatelessWidget {
  const ProviderSelector({
    required this.providers,
    required this.onSelected,
    super.key,
    this.selectedProviderId,
  });

  final List<PaymentProvider> providers;
  final String? selectedProviderId;
  final ValueChanged<PaymentProvider> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: providers.map((provider) {
        final selected = provider.id == selectedProviderId;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => onSelected(provider),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: EasyPayColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: selected ? EasyPayColors.primary : EasyPayColors.line,
                ),
              ),
              child: Row(
                children: [
                  ProviderBadge(name: provider.displayName, selected: selected),
                  const Spacer(),
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color:
                        selected ? EasyPayColors.primary : EasyPayColors.line,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}
