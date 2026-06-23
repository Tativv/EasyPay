# EasyPay

EasyPay is a Flutter payment integration platform prepared for deep-link based
payments, provider routing, return channels, observability, and long-term
provider expansion.

## Architecture

- Flutter + Riverpod + Go Router.
- Clean Architecture with vertical slices under `lib/features`.
- Internal provider plugin model through `PaymentProvider`.
- Registry and strategy based provider selection.
- Versioned deep link parser for `mypay://v1/payment`.
- Drift table definitions for transactions, providers, settings, and audit logs.
- Dio client factory with retry, logging, timeout, and certificate pinning hook.

See [docs/architecture.md](docs/architecture.md) for diagrams and the evolution
plan for 50+ providers.

## Development Entry Point

In dev/homolog the app opens `Deep Link Simulator`, where you can edit JSON,
generate Base64, generate a deep link, decode the payload, and execute the
payment flow internally with `MockProvider`.

## Useful Commands

```powershell
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter run
```
