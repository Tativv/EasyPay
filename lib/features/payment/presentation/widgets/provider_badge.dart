import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:flutter/material.dart';

class ProviderBadge extends StatelessWidget {
  const ProviderBadge({
    required this.name,
    super.key,
    this.selected = false,
  });

  final String name;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: selected ? EasyPayColors.primarySoft : EasyPayColors.surface,
        border: Border.all(
          color: selected ? EasyPayColors.primary : EasyPayColors.line,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 18,
              color: selected ? EasyPayColors.primary : EasyPayColors.mutedInk,
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: selected ? EasyPayColors.primary : EasyPayColors.ink,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
