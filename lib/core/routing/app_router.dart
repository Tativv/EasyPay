import 'package:easypay/core/config/app_environment.dart';
import 'package:easypay/features/payment/presentation/screens/deep_link_simulator_screen.dart';
import 'package:easypay/features/payment/presentation/screens/payment_approved_screen.dart';
import 'package:easypay/features/payment/presentation/screens/payment_processing_screen.dart';
import 'package:easypay/features/payment/presentation/screens/payment_received_screen.dart';
import 'package:easypay/features/payment/presentation/screens/payment_rejected_screen.dart';
import 'package:easypay/features/payment/presentation/screens/provider_selection_screen.dart';
import 'package:easypay/features/settings/presentation/settings_screen.dart';
import 'package:easypay/features/transaction_history/presentation/transaction_history_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppEnvironment.current.enableDeepLinkSimulator
        ? '/dev/deep-link-simulator'
        : '/payment/received',
    routes: [
      GoRoute(
        path: '/payment/received',
        builder: (context, state) => const PaymentReceivedScreen(),
      ),
      GoRoute(
        path: '/payment/providers',
        builder: (context, state) => const ProviderSelectionScreen(),
      ),
      GoRoute(
        path: '/payment/processing',
        builder: (context, state) => const PaymentProcessingScreen(),
      ),
      GoRoute(
        path: '/payment/approved',
        builder: (context, state) => const PaymentApprovedScreen(),
      ),
      GoRoute(
        path: '/payment/rejected',
        builder: (context, state) => const PaymentRejectedScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const TransactionHistoryScreen(),
      ),
      if (AppEnvironment.current.enableDeepLinkSimulator)
        GoRoute(
          path: '/dev/deep-link-simulator',
          builder: (context, state) => const DeepLinkSimulatorScreen(),
        ),
    ],
  );
});
