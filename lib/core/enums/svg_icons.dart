import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum SvgIcons {
  clock,
  popularity,
  rank,
  star,
  youtube,
  redirect;

  Widget toIcon({double? dimension, Color? color}) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      colorFilter: color != null
          ? ColorFilter.mode(
              color,
              BlendMode.srcIn,
            )
          : null,
      width: dimension ?? 24,
      height: dimension ?? 24,
    );
  }
}
