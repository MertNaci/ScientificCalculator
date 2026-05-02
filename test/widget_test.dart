import 'package:flutter_test/flutter_test.dart';
import 'package:scientific_calculator/main.dart';

void main() {
  testWidgets('Calculator app displays title', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('Scientific Calculator'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });
}
