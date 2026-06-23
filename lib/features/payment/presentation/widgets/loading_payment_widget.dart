import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:flutter/material.dart';

class LoadingPaymentWidget extends StatelessWidget {
  const LoadingPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      height: 168,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            width: 168,
            height: 168,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: EasyPayColors.primary,
              backgroundColor: EasyPayColors.primarySoft,
            ),
          ),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: EasyPayColors.primarySoft,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.lock_outline_rounded,
              color: EasyPayColors.primary,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}
