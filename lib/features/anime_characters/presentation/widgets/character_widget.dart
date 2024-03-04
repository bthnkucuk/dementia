import 'package:dementia/config/theme/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_cached_network_image.dart';
import '../../data/models/anime_characters/anime_characters_model.dart';

/// [CharacterWidget] is a widget that displays a character.
class CharacterWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? imageHeight;
  final double? imageWidth;
  const CharacterWidget({
    super.key,
    required this.character,
    this.width,
    this.height,
    this.imageHeight,
    this.imageWidth,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AppCachedNetworkImage(
              height: imageHeight,
              width: imageWidth,
              imageUrl: character.images.jpg.imageUrl,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            character.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: s12W400(context),
          ),
        ],
      ),
    );
  }
}
