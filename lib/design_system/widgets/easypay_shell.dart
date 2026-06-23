import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:flutter/material.dart';

class EasyPayShell extends StatelessWidget {
  const EasyPayShell({
    required this.child,
    super.key,
    this.title,
    this.actions = const [],
  });

  final String? title;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title!),
              actions: actions,
            ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Padding(
              padding: const EdgeInsets.all(EasyPaySpacing.lg),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
