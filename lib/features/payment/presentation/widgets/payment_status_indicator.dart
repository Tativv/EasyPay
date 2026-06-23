import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:flutter/material.dart';

class PaymentStatusIndicator extends StatelessWidget {
  const PaymentStatusIndicator({
    required this.icon,
    required this.color,
    super.key,
  });

  factory PaymentStatusIndicator.approved() {
    return const PaymentStatusIndicator(
      icon: Icons.check_rounded,
      color: EasyPayColors.success,
    );
  }

  factory PaymentStatusIndicator.rejected() {
    return const PaymentStatusIndicator(
      icon: Icons.close_rounded,
      color: EasyPayColors.danger,
    );
  }

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.14),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.22),
            blurRadius: 26,
            spreadRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: CircleAvatar(
          radius: 34,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white, size: 42),
        ),
      ),
    );
  }
}
