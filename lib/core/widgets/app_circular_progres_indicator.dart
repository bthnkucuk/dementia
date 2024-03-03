// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/lottie_constants.dart';

enum _AppCircularProgressIndicatorType { dots, line }

/// [AppCircularProgressIndicator] is a widget that displays a circular progress indicator.
class AppCircularProgressIndicator extends StatelessWidget {
  final double dimension;

  final _AppCircularProgressIndicatorType type;
  const AppCircularProgressIndicator.dots({super.key, this.dimension = 100})
      : type = _AppCircularProgressIndicatorType.dots;
  const AppCircularProgressIndicator.line({super.key, this.dimension = 100})
      : type = _AppCircularProgressIndicatorType.line;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      type == _AppCircularProgressIndicatorType.line
          ? LottieConstants.loadingCenter
          : LottieConstants.loadingBottom,
      height: dimension,
      width: dimension,
    );
  }
}
