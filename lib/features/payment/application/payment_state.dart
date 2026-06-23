import 'package:easypay/features/payment/domain/payment_provider.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';
import 'package:easypay/features/payment/domain/payment_result.dart';

class PaymentState {
  const PaymentState({
    this.request,
    this.selectedProvider,
    this.result,
    this.errorMessage,
    this.isProcessing = false,
  });

  final PaymentRequest? request;
  final PaymentProvider? selectedProvider;
  final PaymentResult? result;
  final String? errorMessage;
  final bool isProcessing;

  PaymentState copyWith({
    PaymentRequest? request,
    PaymentProvider? selectedProvider,
    PaymentResult? result,
    String? errorMessage,
    bool? isProcessing,
    bool clearResult = false,
  }) {
    return PaymentState(
      request: request ?? this.request,
      selectedProvider: selectedProvider ?? this.selectedProvider,
      result: clearResult ? null : result ?? this.result,
      errorMessage: errorMessage,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
