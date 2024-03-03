part of 'top_animes_bloc.dart';

@freezed
class TopAnimesEvent with _$TopAnimesEvent {
  /// [fetchTopAnimes] is a event that fetches top animes data. If filterType is not null, it fetches top animes data with the filter.
  const factory TopAnimesEvent.filter([AnimeType? filterType]) =
      TopAnimesEventFilter;

  /// [nextPage] is a event that fetches the next page of top animes data.
  const factory TopAnimesEvent.nextPage() = TopAnimesEventNextPage;
}
