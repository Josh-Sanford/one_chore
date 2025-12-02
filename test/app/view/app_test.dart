// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:one_chore/app/app.dart';

void main() {
  group('App', () {
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(App());
      expect(find.text('OneChore Theme Demo'), findsOneWidget);
    });
  });
}
