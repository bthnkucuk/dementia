part of 'anime_reviews_bloc.dart';

@freezed
class AnimeReviewsEvent with _$AnimeReviewsEvent {
  const factory AnimeReviewsEvent.fetchAnimeReviews(int animeId) =
      AnimeReviewsEventFetchAnimeReviews;
}
