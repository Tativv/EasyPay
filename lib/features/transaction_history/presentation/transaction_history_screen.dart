import 'package:easypay/design_system/widgets/easypay_shell.dart';
import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyPayShell(
      title: 'Historico',
      child: Center(
        child: Text(
          'Historico de transacoes preparado para Drift.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
