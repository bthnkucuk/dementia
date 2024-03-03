import 'package:dementia/config/theme/app_colors.dart';
import 'package:dementia/config/theme/text_styles.dart';
import 'package:dementia/core/enums/hero_tag.dart';
import 'package:dementia/core/enums/svg_icons.dart';
import 'package:dementia/core/widgets/app_cached_network_image.dart';
import 'package:dementia/core/widgets/app_filled_button.dart';
import 'package:dementia/core/widgets/rating_bar.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/router/anime_route.dart';
import '../../data/models/top_animes/top_animes_model.dart';

class AnimeCardWidget extends StatelessWidget {
  final SingleAnimeGeneralInfo anime;
  const AnimeCardWidget({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final image = anime.images.values.first;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Hero(
              tag: HeroTagType.animeImage.toHeroTag(anime.malId),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AppCachedNetworkImage(
                      imageUrl: image.imageUrl ??
                          image.smallImageUrl ??
                          image.largeImageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(anime.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 18)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: RatingBar(score: anime.score / 2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(anime.synopsis ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 10,
                    children: [
                      if (anime.rank != null)
                        Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgIcons.rank.toIcon(dimension: 20),
                              const SizedBox(width: 5),
                              const Text('Rank'),
                              const SizedBox(width: 5),
                              Text(
                                "#${anime.rank}",
                                style: s14W700.copyWith(color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                      if (anime.popularity != null)
                        Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgIcons.popularity.toIcon(dimension: 20),
                              const SizedBox(width: 5),
                              const Text('Popularity'),
                              const SizedBox(width: 5),
                              Text(
                                "#${anime.popularity}",
                                style: s14W700.copyWith(color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                      if (anime.type != null)
                        Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                anime.type!,
                                style: s14W700.copyWith(color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                      if (anime.episodes != null)
                        Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${anime.episodes!} Episodes',
                                style: s14W700.copyWith(color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppFilledButton(
                      key: const Key('see_more_button'),
                      backgroundColor: AppColors.secondaryColor,
                      child: const Text('See more'),
                      onPressed: () {
                        DetailsRoute(anime.malId).go(context);
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
