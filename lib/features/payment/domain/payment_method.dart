abstract interface class PaymentMethod {
  String get code;
  String get displayName;
}

class PixPaymentMethod implements PaymentMethod {
  const PixPaymentMethod();

  @override
  String get code => 'PIX';

  @override
  String get displayName => 'Pix';
}

class CreditPaymentMethod implements PaymentMethod {
  const CreditPaymentMethod({this.installments = 1});

  final int installments;

  @override
  String get code => 'CREDIT';

  @override
  String get displayName =>
      installments > 1 ? 'Credito ${installments}x' : 'Credito';
}

class DebitPaymentMethod implements PaymentMethod {
  const DebitPaymentMethod();

  @override
  String get code => 'DEBIT';

  @override
  String get displayName => 'Debito';
}

class VoucherPaymentMethod implements PaymentMethod {
  const VoucherPaymentMethod();

  @override
  String get code => 'VOUCHER';

  @override
  String get displayName => 'Voucher';
}

class WalletPaymentMethod implements PaymentMethod {
  const WalletPaymentMethod({required this.walletName});

  final String walletName;

  @override
  String get code => 'WALLET';

  @override
  String get displayName => walletName;
}

class GenericPaymentMethod implements PaymentMethod {
  const GenericPaymentMethod({required this.code, required this.displayName});

  @override
  final String code;

  @override
  final String displayName;
}

class PaymentMethodFactory {
  const PaymentMethodFactory();

  PaymentMethod fromCode(String code, {int installments = 1}) {
    switch (code.toUpperCase()) {
      case 'PIX':
        return const PixPaymentMethod();
      case 'CREDIT':
        return CreditPaymentMethod(installments: installments);
      case 'DEBIT':
        return const DebitPaymentMethod();
      case 'VOUCHER':
        return const VoucherPaymentMethod();
      case 'WALLET':
        return const WalletPaymentMethod(walletName: 'Wallet');
      default:
        return GenericPaymentMethod(code: code, displayName: code);
    }
  }
}
