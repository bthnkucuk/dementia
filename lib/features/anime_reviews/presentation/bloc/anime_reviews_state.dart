part of 'anime_reviews_bloc.dart';

@freezed
class AnimeReviewsState with _$AnimeReviewsState {
  const factory AnimeReviewsState.initial() = AnimeReviewsStateInitial;
  const factory AnimeReviewsState.loading() = AnimeReviewsStateLoading;
  const factory AnimeReviewsState.loaded(AnimeReviewsModel reviews) =
      AnimeReviewsStateLoaded;
  const factory AnimeReviewsState.error(String message) =
      AnimeReviewsStateError;
}
