class AppSettings {
  const AppSettings({
    required this.defaultProviderId,
    required this.strategyId,
    required this.enabledProviderIds,
    required this.enabledReturnChannels,
  });

  final String defaultProviderId;
  final String strategyId;
  final Set<String> enabledProviderIds;
  final Set<String> enabledReturnChannels;

  AppSettings copyWith({
    String? defaultProviderId,
    String? strategyId,
    Set<String>? enabledProviderIds,
    Set<String>? enabledReturnChannels,
  }) {
    return AppSettings(
      defaultProviderId: defaultProviderId ?? this.defaultProviderId,
      strategyId: strategyId ?? this.strategyId,
      enabledProviderIds: enabledProviderIds ?? this.enabledProviderIds,
      enabledReturnChannels:
          enabledReturnChannels ?? this.enabledReturnChannels,
    );
  }
}
