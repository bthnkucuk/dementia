// ignore_for_file: library_private_types_in_public_api

import 'package:dementia/config/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/lottie_constants.dart';

enum _TopToReloadType { bottom, center }

class TopToReload extends StatelessWidget {
  final VoidCallback onTap;
  final _TopToReloadType _type;
  const TopToReload.bottom({
    super.key,
    required this.onTap,
  }) : _type = _TopToReloadType.bottom;

  const TopToReload.center({
    super.key,
    required this.onTap,
  }) : _type = _TopToReloadType.center;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              LottieConstants.error,
              height: _type == _TopToReloadType.bottom ? 60 : null,
              width: _type == _TopToReloadType.bottom ? 60 : null,
            ),
            SizedBox(height: _type == _TopToReloadType.bottom ? 10 : 20),
            Text(
              'Tap to reload',
              style: s14W500.copyWith(
                fontSize: _type == _TopToReloadType.bottom ? null : 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
