import 'package:easypay/design_system/colors/easypay_colors.dart';
import 'package:easypay/design_system/spacing/easypay_spacing.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';
import 'package:easypay/features/payment/presentation/widgets/info_row.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({required this.request, super.key});

  final PaymentRequest request;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(EasyPaySpacing.lg),
        child: Column(
          children: [
            InfoRow(label: 'Comercio', value: request.merchant),
            InfoRow(label: 'Referencia', value: request.reference ?? '-'),
            InfoRow(label: 'Valor', value: request.money.format()),
            InfoRow(label: 'Metodo', value: request.paymentMethod.displayName),
            const Divider(color: EasyPayColors.line),
            InfoRow(label: 'Transacao', value: request.transactionId),
          ],
        ),
      ),
    );
  }
}
