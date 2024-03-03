import 'package:dementia/core/widgets/clip_text_button.dart';
import 'package:dementia/core/widgets/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('ClipTextButton Golden', (tester) async {
    final gb = GoldenBuilder.column(bgColor: Colors.white)
      ..addScenario(
        'ClipTextButton Active',
        ClipTextButton(
          isActive: true,
          text: 'Lorem ipsum',
          onTap: () {},
        ),
      )
      ..addScenario(
          'ClipTextButton Passive',
          ClipTextButton(
            isActive: false,
            text: 'Lorem ipsum',
            onTap: () {},
          ));

    await tester.pumpWidgetBuilder(
      gb.build(),
      surfaceSize: const Size(500, 500),
    );

    await tester.pump(const Duration(milliseconds: 500));

    await multiScreenGolden(
      tester,
      'clip_text_button_test',
      devices: [Device.phone],
      overrideGoldenHeight: 1500,
    );
  });

  testGoldens('RatingBar Golden', (tester) async {
    final gb = GoldenBuilder.column(bgColor: Colors.white)
      ..addScenario(
        'RatingBar',
        const RatingBar(
          score: 10,
        ),
      );

    await tester.pumpWidgetBuilder(
      gb.build(),
      surfaceSize: const Size(500, 500),
    );

    await tester.pump(const Duration(milliseconds: 500));

    await multiScreenGolden(
      tester,
      'rating_bar_test',
      devices: [Device.phone],
      overrideGoldenHeight: 1500,
    );
  });
}
