class ProviderDescriptor {
  const ProviderDescriptor({
    required this.id,
    required this.displayName,
    required this.enabled,
    required this.capabilityCodes,
  });

  final String id;
  final String displayName;
  final bool enabled;
  final List<String> capabilityCodes;
}
