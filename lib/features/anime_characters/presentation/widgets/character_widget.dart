import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_cached_network_image.dart';
import '../../data/models/anime_characters/anime_characters_model.dart';

/// [CharacterWidget] is a widget that displays a character.
class CharacterWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const CharacterWidget({
    super.key,
    required this.character,
    this.width,
    this.height,
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
              imageUrl: character.images.jpg.imageUrl,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            character.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
