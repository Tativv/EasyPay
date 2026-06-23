enum AppFlavor { dev, homolog, prod }

class AppEnvironment {
  const AppEnvironment({
    required this.flavor,
    required this.deepLinkScheme,
    required this.enableDeepLinkSimulator,
  });

  final AppFlavor flavor;
  final String deepLinkScheme;
  final bool enableDeepLinkSimulator;

  static const current = AppEnvironment(
    flavor: AppFlavor.dev,
    deepLinkScheme: 'mypay',
    enableDeepLinkSimulator: true,
  );

  bool get isProduction => flavor == AppFlavor.prod;
}
