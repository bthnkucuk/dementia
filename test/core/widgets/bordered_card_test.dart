import 'package:dementia/core/widgets/bordered_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('BorderedCard', (widgetTester) async {
    await widgetTester.pumpWidget(buildTestableWidget(const BorderedCard(
      title: 'Title',
      textTitle: 'TextTitle',
      text: 'Text',
    )));

    await widgetTester.pump(const Duration(milliseconds: 100));

    expect(find.byType(BorderedCard), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('TextTitle'), findsOneWidget);
    expect(find.text('Text'), findsOneWidget);
  });
}
