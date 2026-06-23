import 'dart:developer' as developer;

class StructuredLogger {
  const StructuredLogger();

  void info(String message, {Map<String, Object?> fields = const {}}) {
    developer.log(_format(message, fields), name: 'easypay.info');
  }

  void warning(String message, {Map<String, Object?> fields = const {}}) {
    developer.log(_format(message, fields), name: 'easypay.warning');
  }

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> fields = const {},
  }) {
    developer.log(
      _format(message, fields),
      name: 'easypay.error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  String _format(String message, Map<String, Object?> fields) {
    if (fields.isEmpty) return message;
    return '$message ${fields.entries.map((e) => '${e.key}=${e.value}').join(' ')}';
  }
}
