part of 'anime_characters_bloc.dart';

@freezed
class AnimeCharactersState with _$AnimeCharactersState {
  const factory AnimeCharactersState.initial() = AnimeCharactersStateInitial;
  const factory AnimeCharactersState.loading() = AnimeCharactersStateLoading;
  const factory AnimeCharactersState.loaded(AnimeCharactersModel characters) =
      Loaded;
  const factory AnimeCharactersState.error(String message) =
      AnimeCharactersStateError;
}
