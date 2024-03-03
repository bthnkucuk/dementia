import 'package:dementia/config/theme/app_colors.dart';
import 'package:dementia/config/theme/text_styles.dart';
import 'package:dementia/core/enums/svg_icons.dart';
import 'package:dementia/core/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/router/routes.dart';
import '../../../../../core/method_channel/method_channel_handler.dart';
import '../../../../../core/widgets/bordered_card.dart';
import '../../../../../core/widgets/top_to_reload.dart';
import '../../../../../core/widgets/shimmer_loading_horizontal_list_widget.dart';
import '../../../../anime_characters/presentation/bloc/anime_characters_bloc.dart';
import '../../../../anime_characters/presentation/widgets/character_widget.dart';
import '../../../../anime_reviews/presentation/bloc/anime_reviews_bloc.dart';
import '../../../data/models/top_animes/top_animes_model.dart';
import '../../bloc/top_animes_bloc.dart';
import '../../widgets/details_app_bar.dart';
part 'anime_detail_part.dart';

class AnimeDetailsScreen extends HookWidget {
  final int malId;
  const AnimeDetailsScreen({
    super.key,
    required this.malId,
  });

  @override
  Widget build(BuildContext context) {
    final methodChannelHandler = MethodChannelHandler(context);

    void fetchCharacters(int malId) {
      methodChannelHandler.triggerNativeMethod(
          MethodChannelMethods.fetchAnimeCharacters,
          arg: malId);
    }

    void fetchReviews(int malId) {
      methodChannelHandler.triggerNativeMethod(
          MethodChannelMethods.fetchAnimeReviews,
          arg: malId);
    }

    useEffect(() {
      fetchCharacters(malId);
      fetchReviews(malId);
      return;
    }, []);

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: BlocBuilder<TopAnimesBloc, TopAnimesState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                DetailsAppBar(malId: malId),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: BlocBuilder<TopAnimesBloc, TopAnimesState>(
                        builder: (context, state) {
                          final animeGeneralInfo = state.topAnimesModelList
                              .expand((element) => element.data)
                              .firstWhere((element) => element.malId == malId);
                          final animeImage =
                              animeGeneralInfo.images.values.first;

                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Synopsis
                                if (animeGeneralInfo.synopsis != null)
                                  Container(
                                    margin: const EdgeInsets.all(20),
                                    child: BorderedCard(
                                        title: animeGeneralInfo
                                                .titleSynonyms.isNotEmpty
                                            ? animeGeneralInfo
                                                .titleSynonyms.first
                                            : null,
                                        textTitle: 'Synopsis',
                                        text: animeGeneralInfo.synopsis!,
                                        avatarUrl: animeImage.imageUrl,
                                        textMaxLines: 120),
                                  ),
                                //Information
                                const Divider(),
                                _GeneralInformations(
                                    animeGeneralInfo: animeGeneralInfo),

                                const Divider(),

                                const SizedBox(height: 10),
                                //Open Youtube and Open MAL
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      _RedirectButton(
                                        title: 'YouTube',
                                        icon: SvgIcons.youtube,
                                        onPressed: () {
                                          if (animeGeneralInfo.trailer.url !=
                                              null) {
                                            launchUrl(Uri.parse(
                                                animeGeneralInfo.trailer.url!));
                                          }
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      _RedirectButton(
                                          title: 'MAL',
                                          icon: SvgIcons.redirect,
                                          onPressed: () => launchUrl(
                                              Uri.parse(animeGeneralInfo.url)))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),

                                const Divider(),

                                //Characters
                                BlocBuilder<AnimeCharactersBloc,
                                    AnimeCharactersState>(
                                  builder: (context, state) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _SectionTitle(
                                          title: 'Characters',
                                          onPressed: () {
                                            state.maybeWhen(
                                              loaded: (characters) {
                                                CharactersRoute(malId)
                                                    .go(context);
                                              },
                                              orElse: () {},
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          height: 220,
                                          child: state.when(
                                            //TODO
                                            initial: () =>
                                                const ShimmerLoadingHorizontalListWidget(
                                              elementWidth: 120,
                                              elementHeight: 160,
                                            ),
                                            loading: () =>
                                                const ShimmerLoadingHorizontalListWidget(
                                              elementWidth: 120,
                                              elementHeight: 160,
                                            ),
                                            loaded: (characters) {
                                              return ListView.separated(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    characters.data.length,
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(width: 16),
                                                itemBuilder: (context, index) {
                                                  final character = characters
                                                      .data[index].character;

                                                  return CharacterWidget(
                                                      width: 120,
                                                      height: 160,
                                                      character: character);
                                                },
                                              );
                                            },
                                            //TODO
                                            error: (message) => Center(
                                                child: TopToReload.bottom(
                                                    onTap: () =>
                                                        fetchCharacters(
                                                            animeGeneralInfo
                                                                .malId))),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const Divider(),

                                //Genres
                                const _SectionTitle(title: 'Genres'),
                                SizedBox(
                                  height: 55,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: animeGeneralInfo.genres.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(width: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final genre =
                                          animeGeneralInfo.genres[index];
                                      return Chip(
                                          label: Text(genre.name ?? ''));
                                    },
                                  ),
                                ),
                                const Divider(),

                                //Reviews
                                BlocBuilder<AnimeReviewsBloc,
                                        AnimeReviewsState>(
                                    builder: (context, state) {
                                  return Column(
                                    children: [
                                      state.maybeWhen(
                                        loaded: (reviews) =>
                                            reviews.data.isNotEmpty
                                                ? _SectionTitle(
                                                    title: 'Reviews',
                                                    onPressed: () {
                                                      ReviewsRoute(malId)
                                                          .go(context);
                                                    },
                                                  )
                                                : const SizedBox(),
                                        orElse: () => const _SectionTitle(
                                          title: 'Reviews',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      state.when(
                                        initial: () => const SizedBox(
                                          height: 200,
                                          child:
                                              ShimmerLoadingHorizontalListWidget(
                                            elementWidth: 200,
                                            elementHeight: 200,
                                          ),
                                        ),
                                        loading: () => const SizedBox(
                                          height: 200,
                                          child:
                                              ShimmerLoadingHorizontalListWidget(
                                            elementWidth: 200,
                                            elementHeight: 200,
                                          ),
                                        ),
                                        loaded: (reviews) {
                                          if (reviews.data.isNotEmpty) {
                                            return SizedBox(
                                              height: 200,
                                              child: ListView.separated(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: reviews.data.length,
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(width: 10),
                                                itemBuilder: (context, index) {
                                                  final review =
                                                      reviews.data[index];
                                                  return SizedBox(
                                                    width: 200,
                                                    child: BorderedCard(
                                                        avatarUrl: review
                                                            .user
                                                            .images
                                                            .values
                                                            .first
                                                            .imageUrl,
                                                        title: review
                                                            .user.username,
                                                        textTitle:
                                                            review.tags.first,
                                                        text: review.review ??
                                                            ''),
                                                  );
                                                },
                                              ),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                        error: (message) => Center(
                                            child: TopToReload.bottom(
                                                onTap: () => fetchReviews(
                                                    animeGeneralInfo.malId))),
                                      ),
                                    ],
                                  );
                                })
                              ]);
                        },
                      )),
                ),
              ],
            );
          },
        ));
  }
}
