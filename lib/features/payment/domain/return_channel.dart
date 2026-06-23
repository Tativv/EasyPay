import 'package:easypay/features/payment/domain/payment_result.dart';

abstract interface class ReturnChannel {
  String get code;
  String get displayName;

  Future<void> send(PaymentResult result);
}

class CallbackChannel implements ReturnChannel {
  const CallbackChannel();

  @override
  String get code => 'CALLBACK';

  @override
  String get displayName => 'Callback';

  @override
  Future<void> send(PaymentResult result) async {}
}

class WebhookChannel implements ReturnChannel {
  const WebhookChannel();

  @override
  String get code => 'WEBHOOK';

  @override
  String get displayName => 'Webhook';

  @override
  Future<void> send(PaymentResult result) async {}
}

class QueueChannel implements ReturnChannel {
  const QueueChannel();

  @override
  String get code => 'QUEUE';

  @override
  String get displayName => 'Fila';

  @override
  Future<void> send(PaymentResult result) async {}
}

class NotificationChannel implements ReturnChannel {
  const NotificationChannel();

  @override
  String get code => 'NOTIFICATION';

  @override
  String get displayName => 'Notificacao';

  @override
  Future<void> send(PaymentResult result) async {}
}

class PollingChannel implements ReturnChannel {
  const PollingChannel();

  @override
  String get code => 'POLLING';

  @override
  String get displayName => 'Polling';

  @override
  Future<void> send(PaymentResult result) async {}
}
