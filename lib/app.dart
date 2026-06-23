import 'package:easypay/core/routing/app_router.dart';
import 'package:easypay/design_system/theme/easypay_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EasyPayApp extends ConsumerWidget {
  const EasyPayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'EasyPay',
      debugShowCheckedModeBanner: false,
      theme: EasyPayTheme.light(),
      routerConfig: router,
    );
  }
}
