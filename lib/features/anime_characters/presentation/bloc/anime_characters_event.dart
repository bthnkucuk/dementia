part of 'anime_characters_bloc.dart';

@freezed
class AnimeCharactersEvent with _$AnimeCharactersEvent {
  const factory AnimeCharactersEvent.fetchAnimeCharacters(int animeId) =
      AnimeCharactersEventFetchAnimeCharacters;
}
