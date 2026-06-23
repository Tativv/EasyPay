import 'dart:convert';

import 'package:easypay/features/payment/application/payment_contract_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses v1 base64 payment contract', () {
    final parser = PaymentContractParserV1();
    final payload = {
      'transactionId': '123',
      'amount': 150.50,
      'currency': 'BRL',
      'paymentMethod': 'CREDIT',
      'installments': 3,
      'merchant': 'Loja XPTO',
      'reference': 'PEDIDO-123',
      'returnChannels': ['CALLBACK'],
    };

    final encoded = base64Url.encode(utf8.encode(jsonEncode(payload)));
    final request = parser.parseBase64Request(encoded);

    expect(request.transactionId, '123');
    expect(request.money.amount, 150.50);
    expect(request.money.currency, 'BRL');
    expect(request.paymentMethod.code, 'CREDIT');
    expect(request.installments, 3);
    expect(request.returnChannelCodes, ['CALLBACK']);
  });

  test('rejects invalid amount', () {
    final parser = PaymentContractParserV1();

    expect(
      () => parser.parseJson({
        'transactionId': '123',
        'amount': 0,
        'paymentMethod': 'PIX',
        'merchant': 'Loja XPTO',
      }),
      throwsFormatException,
    );
  });
}
