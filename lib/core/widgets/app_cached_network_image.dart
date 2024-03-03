import 'package:dementia/core/constants/image_constants.dart';
import 'package:dementia/core/widgets/app_circular_progres_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  const AppCachedNetworkImage(
      {super.key, required this.imageUrl, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return Image.asset(ImageConstants.notFond);
      },
      progressIndicatorBuilder: (context, url, progress) {
        return const Center(
          child: AppCircularProgressIndicator.dots(),
        );
      },
    );
  }
}
