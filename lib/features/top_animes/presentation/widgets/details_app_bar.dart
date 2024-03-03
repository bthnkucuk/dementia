import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../core/enums/hero_tag.dart';
import '../../../../core/enums/svg_icons.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../bloc/top_animes_bloc.dart';

class DetailsAppBar extends StatelessWidget {
  final int malId;
  const DetailsAppBar({super.key, required this.malId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopAnimesBloc, TopAnimesState>(
      builder: (context, state) {
        final animeGeneralInfo = state.topAnimesModelList
            .expand((element) => element.data)
            .firstWhere((element) => element.malId == malId);
        final animeImage = animeGeneralInfo.images.values.first;
        return SliverAppBar(
          backgroundColor: AppColors.secondaryColor,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * .45,
          floating: false,
          leading: GestureDetector(
            onTap: () => router.pop(),
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: HeroTagType.animeImage.toHeroTag(animeGeneralInfo.malId),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    AppColors.black.withOpacity(0.3), BlendMode.darken),
                child: AppCachedNetworkImage(
                  imageUrl: animeImage.largeImageUrl ??
                      animeImage.imageUrl ??
                      animeImage.smallImageUrl,
                  width: double.infinity,
                ),
              ),
            ),
            collapseMode: CollapseMode.parallax,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
                kToolbarHeight + MediaQuery.of(context).padding.top),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (animeGeneralInfo.title != null)
                    Text(animeGeneralInfo.title!,
                        style: s14W700.copyWith(color: AppColors.primaryColor)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (animeGeneralInfo.year != null)
                        Row(
                          children: [
                            SvgIcons.clock.toIcon(
                                color: AppColors.primaryColor, dimension: 14),
                            const SizedBox(width: 5),
                            Text(
                              animeGeneralInfo.year.toString(),
                              style: s12W400.copyWith(
                                  color: AppColors.primaryColor),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      Row(
                        children: [
                          SvgIcons.star.toIcon(
                              color: AppColors.primaryColor, dimension: 14),
                          const SizedBox(width: 5),
                          Text(
                            "${(animeGeneralInfo.score / 2).toStringAsFixed(1)} (MAL)",
                            style:
                                s12W400.copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  if (animeGeneralInfo.background != null)
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          animeGeneralInfo.background!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: s12W400.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
