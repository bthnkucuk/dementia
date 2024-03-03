import 'package:flutter/material.dart';

import '../../../../core/enums/anime_type.dart';
import '../../../../core/widgets/clip_text_button.dart';

class HomeFilterBar extends StatelessWidget {
  const HomeFilterBar({
    super.key,
    required this.selectedTypeFilter,
    required this.onChanged,
  });

  final AnimeType? selectedTypeFilter;
  // bool function
  final Function(AnimeType?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        children: List.generate(
          AnimeType.values.length,
          (index) {
            final animeType = AnimeType.values[index];
            return ClipTextButton(
              isActive: selectedTypeFilter == animeType,
              text: animeType.titleString,
              onTap: () {
                if (selectedTypeFilter != animeType) {
                  onChanged(animeType);
                } else {
                  onChanged(null);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
