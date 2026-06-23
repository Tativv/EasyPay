import 'package:dio/dio.dart';

class DioClientFactory {
  DioClientFactory();

  Dio create({
    Duration timeout = const Duration(seconds: 20),
    List<String> pinnedCertificateFingerprints = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
      ),
    );

    dio.interceptors.addAll([
      _CorrelationInterceptor(),
      _RetryInterceptor(dio: dio),
      LogInterceptor(requestBody: true, responseBody: true),
      _CertificatePinningPlaceholder(pinnedCertificateFingerprints),
    ]);

    return dio;
  }
}

class _CorrelationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.putIfAbsent('x-correlation-id', () {
      return DateTime.now().microsecondsSinceEpoch.toString();
    });
    handler.next(options);
  }
}

class _RetryInterceptor extends Interceptor {
  _RetryInterceptor({required this.dio});

  final Dio dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final attempt = (err.requestOptions.extra['retryAttempt'] as int?) ?? 0;
    final canRetry = attempt < 2 &&
        (err.type == DioExceptionType.connectionTimeout ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.connectionError);

    if (!canRetry) {
      handler.next(err);
      return;
    }

    await Future<void>.delayed(Duration(milliseconds: 250 * (attempt + 1)));
    err.requestOptions.extra['retryAttempt'] = attempt + 1;

    try {
      final response = await dio.fetch<dynamic>(err.requestOptions);
      handler.resolve(response);
    } on DioException catch (error) {
      handler.next(error);
    }
  }
}

class _CertificatePinningPlaceholder extends Interceptor {
  _CertificatePinningPlaceholder(this.fingerprints);

  final List<String> fingerprints;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Native pinning should be enforced per provider with platform TLS hooks.
    options.extra['certificatePinningEnabled'] = fingerprints.isNotEmpty;
    handler.next(options);
  }
}
