import 'package:dementia/core/enums/svg_icons.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class RatingBar extends StatelessWidget {
  final double score;

  const RatingBar({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final animeStar = score - 1;
    const size = 24.0;
    final color = AppColors.primaryColor;

    return Wrap(
      children: List.generate(
        5,
        (index) {
          if (index < animeStar) {
            return SizedBox(
              width: size,
              height: size,
              child: SvgIcons.star.toIcon(
                dimension: size,
                color: color,
              ),
            );
          } else {
            final reminder =
                double.parse((animeStar - index).abs().toStringAsFixed(1));

            return _HalfFilledIcon(
              size: size,
              color: color,
              reminder: reminder,
            );
          }
        },
      ),
    );
  }
}

class _HalfFilledIcon extends StatelessWidget {
  final double size;
  final Color color;
  final double reminder;

  const _HalfFilledIcon({
    required this.size,
    required this.color,
    required this.reminder,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [0, reminder, reminder],
          colors: [color, color, color.withOpacity(0)],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: SvgIcons.star.toIcon(
          dimension: 24,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
