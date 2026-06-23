import 'package:easypay/features/settings/domain/app_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appSettingsProvider = StateProvider<AppSettings>((ref) {
  return const AppSettings(
    defaultProviderId: 'mock',
    strategyId: 'default',
    enabledProviderIds: {'mock'},
    enabledReturnChannels: {'CALLBACK'},
  );
});
