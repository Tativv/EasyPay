import 'package:easypay/features/payment/application/payment_contract_parser.dart';
import 'package:easypay/features/payment/domain/payment_request.dart';

class ParsedPaymentDeepLink {
  const ParsedPaymentDeepLink({
    required this.version,
    required this.request,
  });

  final String version;
  final PaymentRequest request;
}

abstract interface class DeepLinkPaymentParser {
  ParsedPaymentDeepLink parse(Uri uri);
}

class VersionedDeepLinkPaymentParser implements DeepLinkPaymentParser {
  VersionedDeepLinkPaymentParser({
    Map<String, PaymentContractParser>? parsers,
  }) : _parsers = parsers ?? {'v1': PaymentContractParserV1()};

  final Map<String, PaymentContractParser> _parsers;

  @override
  ParsedPaymentDeepLink parse(Uri uri) {
    final version = uri.host.isNotEmpty
        ? uri.host
        : uri.pathSegments.isEmpty
            ? null
            : uri.pathSegments.first;
    if (version == null || !_parsers.containsKey(version)) {
      throw FormatException('Versao de deep link nao suportada: $version.');
    }

    final pathSegments = uri.pathSegments;
    final action = pathSegments.isNotEmpty ? pathSegments.last : '';
    if (action != 'payment') {
      throw FormatException('Acao de deep link nao suportada: $action.');
    }

    final request = uri.queryParameters['request'];
    if (request == null || request.isEmpty) {
      throw const FormatException('Parametro request ausente.');
    }

    return ParsedPaymentDeepLink(
      version: version,
      request: _parsers[version]!.parseBase64Request(request),
    );
  }
}
