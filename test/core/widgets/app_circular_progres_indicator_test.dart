import 'package:dementia/core/widgets/app_circular_progres_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('AppCircularProgressIndicator', (widgetTester) async {
    await widgetTester.pumpWidget(
        buildTestableWidget(const AppCircularProgressIndicator.dots()));

    await widgetTester.pump(const Duration(milliseconds: 100));

    expect(find.byType(AppCircularProgressIndicator), findsOneWidget);
    expect(find.byType(Lottie), findsOneWidget);

    await widgetTester.pumpWidget(
        buildTestableWidget(const AppCircularProgressIndicator.dots()));

    await widgetTester.pump(const Duration(milliseconds: 100));

    expect(find.byType(AppCircularProgressIndicator), findsOneWidget);
    expect(find.byType(Lottie), findsOneWidget);
  });
}
