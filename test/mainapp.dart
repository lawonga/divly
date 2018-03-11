// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:divly/layout/list/company_listview.dart';
import 'package:divly/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Navigation tab bar should be showing', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.text('My Portfolio'), findsOneWidget);
    expect(find.text('Performance Chart'), findsOneWidget);
  });

  testWidgets('Portfolio list should be showing', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.byType(CompanyList), findsOneWidget);
  });
}
