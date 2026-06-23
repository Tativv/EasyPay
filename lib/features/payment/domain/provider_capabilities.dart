import 'package:easypay/features/payment/domain/payment_method.dart';

class ProviderCapabilities {
  const ProviderCapabilities({
    required this.supportedMethods,
    this.supportsCancel = false,
    this.supportsRefund = false,
    this.supportsInstallments = false,
    this.supportsTapToPay = false,
  });

  final List<PaymentMethod> supportedMethods;
  final bool supportsCancel;
  final bool supportsRefund;
  final bool supportsInstallments;
  final bool supportsTapToPay;

  bool supports(PaymentMethod method) {
    return supportedMethods.any((candidate) => candidate.code == method.code);
  }
}
