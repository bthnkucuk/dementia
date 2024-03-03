import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/anime_characters/presentation/screens/anime_characters_screen.dart';
import '../../features/anime_characters/presentation/screens/anime_detail/anime_detail_screen.dart';
import '../../features/anime_reviews/presentation/screens/anime_reviews_screen.dart';
import '../../features/top_animes/presentation/screens/anime_home_screen.dart';

part 'anime_route.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/home',
  name: 'Home',
  routes: [
    TypedGoRoute<DetailsRoute>(
      path: 'details/:malId',
      name: 'Details',
      routes: [
        TypedGoRoute<CharactersRoute>(
          path: 'characters',
          name: 'Characters',
        ),
        TypedGoRoute<ReviewsRoute>(
          path: 'reviews',
          name: 'Reviews',
        ),
      ],
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AnimeHomeScreen();
}

class DetailsRoute extends GoRouteData {
  final int malId;
  const DetailsRoute(this.malId);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AnimeDetailsScreen(malId: malId);
  }
}

class CharactersRoute extends GoRouteData {
  final int malId;
  const CharactersRoute(this.malId);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AnimeCharactersScreen(malId: malId);
  }
}

class ReviewsRoute extends GoRouteData {
  final int malId;
  const ReviewsRoute(this.malId);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AnimeReviewsScreen(malId: malId);
  }
}
