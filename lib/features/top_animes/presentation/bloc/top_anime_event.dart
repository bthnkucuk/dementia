part of 'top_animes_bloc.dart';

@freezed
class TopAnimesEvent with _$TopAnimesEvent {
  const factory TopAnimesEvent.filter([AnimeType? filterType]) =
      TopAnimesEventFilter;

  const factory TopAnimesEvent.nextPage() = TopAnimesEventNextPage;
}
