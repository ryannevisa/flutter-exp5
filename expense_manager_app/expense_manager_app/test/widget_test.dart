import 'package:flutter_test/flutter_test.dart';
import 'package:expense_manager_app/main.dart';
import 'package:expense_manager_app/budget_model.dart';

void main() {
  test('Budget totals and balance', () {
    const b = Budget(
        income: 50000, rent: 15000, food: 8000, transport: 3000, others: 4000);
    expect(b.totalExpenses, 30000);
    expect(b.balance, 20000);
  });

  Future<void> launch(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const ExpenseApp());
  }

  Future<void> fill(WidgetTester tester, List<String> v) async {
    final f = find.byType(TextFormField);
    for (var i = 0; i < v.length; i++) {
      await tester.enterText(f.at(i), v[i]);
    }
  }

  testWidgets('empty form shows validation errors and stays on screen',
      (tester) async {
    await launch(tester);
    await tester.tap(find.text('CALCULATE >>'));
    await tester.pump();
    expect(find.text('Enter monthly income'), findsOneWidget);
    expect(find.text('Enter amount (0 if none)'), findsNWidgets(4));
    expect(find.text('Budget Summary'), findsNothing);
  });

  testWidgets('positive balance shows green success message, Back returns',
      (tester) async {
    await launch(tester);
    await fill(tester, ['50000', '15000', '8000', '3000', '4000']);
    await tester.tap(find.text('CALCULATE >>'));
    await tester.pumpAndSettle();

    expect(find.text('Budget Summary'), findsOneWidget);
    expect(find.text('₹20000.00'), findsOneWidget);
    expect(find.text('Great! You are within your budget.'), findsOneWidget);

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Monthly Budget'), findsOneWidget);
  });

  testWidgets('negative balance shows overspending warning', (tester) async {
    await launch(tester);
    await fill(tester, ['20000', '15000', '8000', '3000', '4000']);
    await tester.tap(find.text('CALCULATE >>'));
    await tester.pumpAndSettle();

    expect(find.text('-₹10000.00'), findsOneWidget);
    expect(find.text('You are overspending!'), findsOneWidget);
  });
}
