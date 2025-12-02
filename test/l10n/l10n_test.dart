import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/l10n/l10n.dart';

void main() {
  group('AppLocalizationsX', () {
    testWidgets('l10n extension returns AppLocalizations', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: _TestWidget(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the extension works without errors
      expect(find.byType(_TestWidget), findsOneWidget);
    });
  });
}

class _TestWidget extends StatelessWidget {
  const _TestWidget();

  @override
  Widget build(BuildContext context) {
    // This uses the l10n extension, providing coverage
    final localizations = context.l10n;
    return Text(localizations.counterAppBarTitle);
  }
}
