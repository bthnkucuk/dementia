import 'package:dementia/core/widgets/clip_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('ClipTextButton', (widgetTester) async {
    int counter = 0;

    await widgetTester.pumpWidget(buildTestableWidget(ClipTextButton(
      isActive: true,
      text: 'text',
      onTap: () {
        counter++;
      },
    )));

    await widgetTester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ClipTextButton), findsOneWidget);

    await widgetTester.tap(find.byType(ClipTextButton));

    expect(counter, 1);

    expect(find.text('text'), findsOneWidget);
  });
}
