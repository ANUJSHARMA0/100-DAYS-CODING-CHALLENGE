import 'package:flutter_test/flutter_test.dart';
import 'package:nova_calc/main.dart';

void main() {
  testWidgets('Nova Calc app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const NovaCalcApp());
    expect(find.text('NOVA CALC'), findsOneWidget);
  });
}
