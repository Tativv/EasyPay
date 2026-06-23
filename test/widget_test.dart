import 'package:easypay/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('opens the deep link simulator in dev', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: EasyPayApp()));
    await tester.pumpAndSettle();

    expect(find.text('Deep Link Simulator'), findsOneWidget);
    expect(find.text('EasyPay'), findsOneWidget);
  });
}
