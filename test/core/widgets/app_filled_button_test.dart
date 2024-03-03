import 'package:dementia/core/widgets/app_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('AppFilledButton', (widgetTester) async {
    int counter = 0;

    await widgetTester.pumpWidget(buildTestableWidget(AppFilledButton(
        onPressed: () {
          counter++;
        },
        child: const Text("Button"))));

    await widgetTester.pump(const Duration(milliseconds: 100));

    expect(find.text('Button'), findsOneWidget);
    expect(find.byType(AppFilledButton), findsOneWidget);
    expect(find.byType(CupertinoButton), findsOneWidget);

    await widgetTester.tap(find.byType(CupertinoButton));

    expect(counter, 1);

    await widgetTester.pumpAndSettle();
  });
}
