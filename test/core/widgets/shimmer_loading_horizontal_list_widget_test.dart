import 'package:dementia/core/widgets/shimmer_loading_horizontal_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('ShimmerLoadingHorizontalListWidget', (widgetTester) async {
    await widgetTester.pumpWidget(
        buildTestableWidget(const ShimmerLoadingHorizontalListWidget(
      elementHeight: 100,
      elementWidth: 100,
    )));

    await widgetTester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ShimmerLoadingHorizontalListWidget), findsOneWidget);
  });
}
