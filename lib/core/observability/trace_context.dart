import 'package:uuid/uuid.dart';

class TraceContext {
  TraceContext({
    required this.transactionId,
    String? correlationId,
    String? traceId,
  })  : correlationId = correlationId ?? const Uuid().v4(),
        traceId = traceId ?? const Uuid().v4();

  final String transactionId;
  final String correlationId;
  final String traceId;

  Map<String, Object?> toLogFields() => {
        'transactionId': transactionId,
        'correlationId': correlationId,
        'traceId': traceId,
      };
}
