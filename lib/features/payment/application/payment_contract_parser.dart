import 'dart:convert';

import 'package:easypay/features/payment/domain/payment_method.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';
import 'package:easypay/shared/domain/money.dart';

abstract interface class PaymentContractParser {
  PaymentRequest parseBase64Request(String encodedRequest);
  PaymentRequest parseJson(Map<String, Object?> json);
  String encodeJson(Map<String, Object?> json);
}

class PaymentContractParserV1 implements PaymentContractParser {
  PaymentContractParserV1({PaymentMethodFactory? methodFactory})
      : _methodFactory = methodFactory ?? const PaymentMethodFactory();

  final PaymentMethodFactory _methodFactory;

  @override
  PaymentRequest parseBase64Request(String encodedRequest) {
    final normalized = base64.normalize(encodedRequest);
    final decoded = utf8.decode(base64.decode(normalized));
    final json = jsonDecode(decoded);
    if (json is! Map<String, Object?>) {
      throw const FormatException('Contrato de pagamento invalido.');
    }
    return parseJson(json);
  }

  @override
  PaymentRequest parseJson(Map<String, Object?> json) {
    final transactionId = _requiredString(json, 'transactionId');
    final amount = _requiredNumber(json, 'amount');
    final currency = (_optionalString(json, 'currency') ?? 'BRL').toUpperCase();
    final methodCode = _requiredString(json, 'paymentMethod');
    final installments = (json['installments'] as num?)?.toInt() ?? 1;
    final merchant = _requiredString(json, 'merchant');
    final returnChannels =
        (json['returnChannels'] as List<dynamic>? ?? ['CALLBACK'])
            .map((value) => value.toString())
            .toList(growable: false);

    if (amount <= 0) {
      throw const FormatException('Valor deve ser maior que zero.');
    }

    return PaymentRequest(
      transactionId: transactionId,
      money: Money(amount: amount, currency: currency),
      paymentMethod: _methodFactory.fromCode(
        methodCode,
        installments: installments,
      ),
      installments: installments,
      merchant: merchant,
      reference: _optionalString(json, 'reference'),
      returnChannelCodes: returnChannels,
      metadata: Map<String, Object?>.from(json['metadata'] as Map? ?? {}),
    );
  }

  @override
  String encodeJson(Map<String, Object?> json) {
    return base64Url.encode(utf8.encode(jsonEncode(json)));
  }

  String _requiredString(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String && value.trim().isNotEmpty) return value;
    throw FormatException('Campo obrigatorio ausente: $key.');
  }

  String? _optionalString(Map<String, Object?> json, String key) {
    final value = json[key];
    return value is String && value.trim().isNotEmpty ? value : null;
  }

  double _requiredNumber(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is num) return value.toDouble();
    throw FormatException('Campo numerico obrigatorio ausente: $key.');
  }
}
