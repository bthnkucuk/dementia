import 'package:dementia/core/flavor/flavor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/router/router.dart';
import 'config/theme/app_theme.dart';
import 'features/anime_characters/presentation/bloc/anime_characters_bloc.dart';
import 'features/anime_reviews/presentation/bloc/anime_reviews_bloc.dart';
import 'features/top_animes/presentation/bloc/top_animes_bloc.dart';
import 'injection_container.dart' as injection;

FlavorModel? appFlavor;

class AnimeApp extends StatelessWidget {
  final FlavorModel flavor;
  const AnimeApp({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    appFlavor = flavor;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injection.sl<TopAnimesBloc>()),
        BlocProvider(create: (context) => injection.sl<AnimeCharactersBloc>()),
        BlocProvider(create: (context) => injection.sl<AnimeReviewsBloc>()),
      ],
      child: MaterialApp.router(
        title: flavor.name,
        theme: appTheme,
        routerConfig: router,
      ),
    );
  }
}
