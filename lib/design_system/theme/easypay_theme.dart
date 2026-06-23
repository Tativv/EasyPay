import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:easypay/design_system/typography/easypay_typography.dart';
import 'package:flutter/material.dart';

class EasyPayTheme {
  const EasyPayTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: EasyPayColors.page,
      colorScheme: ColorScheme.fromSeed(
        seedColor: EasyPayColors.primary,
        primary: EasyPayColors.primary,
        surface: EasyPayColors.surface,
        error: EasyPayColors.danger,
      ),
      textTheme: EasyPayTypography.textTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: EasyPayColors.page,
        foregroundColor: EasyPayColors.ink,
        centerTitle: true,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: EasyPayColors.primary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: EasyPayColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
