import 'package:dementia/core/widgets/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('RatingBar', (widgetTester) async {
    await widgetTester.pumpWidget(buildTestableWidget(const RatingBar(
      score: 3.5,
    )));

    await widgetTester.pump(const Duration(milliseconds: 100));

    expect(find.byType(RatingBar), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(5));
  });
}
