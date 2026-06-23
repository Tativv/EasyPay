import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:easypay/features/payment/domain/payment_result.dart';
import 'package:easypay/features/payment/presentation/widgets/info_row.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    required this.result,
    required this.amount,
    super.key,
    this.reference,
  });

  final PaymentResult result;
  final String amount;
  final String? reference;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(EasyPaySpacing.lg),
        child: Column(
          children: [
            InfoRow(label: 'Referencia', value: reference ?? '-'),
            if (result.authorizationCode != null)
              InfoRow(label: 'Autorizacao', value: result.authorizationCode!),
            InfoRow(label: 'Valor', value: amount),
            InfoRow(label: 'Transacao', value: result.transactionId),
            if (result.reason != null)
              InfoRow(label: 'Motivo', value: result.reason!),
          ],
        ),
      ),
    );
  }
}
