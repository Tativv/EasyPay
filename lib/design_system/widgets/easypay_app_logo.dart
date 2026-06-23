import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:flutter/material.dart';

class EasyPayAppLogo extends StatelessWidget {
  const EasyPayAppLogo({super.key, this.size = 56});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: EasyPayColors.ink,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          'P',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.56,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
