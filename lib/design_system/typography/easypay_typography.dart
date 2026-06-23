import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:flutter/material.dart';

class EasyPayTypography {
  const EasyPayTypography._();

  static TextTheme textTheme() {
    return const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: EasyPayColors.ink,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: EasyPayColors.ink,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: EasyPayColors.ink,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: EasyPayColors.mutedInk,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    );
  }
}
