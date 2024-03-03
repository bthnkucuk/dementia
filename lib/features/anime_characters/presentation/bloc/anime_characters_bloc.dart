// ignore_for_file: library_private_types_in_public_api

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../../core/helpers/failure_to_message.dart';
import '../../data/models/anime_characters/anime_characters_model.dart';
import '../../domain/usecases/get_anime_characters_with_anime_id.dart';
part 'anime_characters_event.dart';
part 'anime_characters_state.dart';
part 'anime_characters_bloc.freezed.dart';

class AnimeCharactersBloc
    extends Bloc<AnimeCharactersEvent, AnimeCharactersState> {
  final GetAnimeCharactersWithAnimeId getAnimeCharactersWithAnimeId;
  AnimeCharactersBloc(this.getAnimeCharactersWithAnimeId)
      : super(const AnimeCharactersStateInitial()) {
    on<AnimeCharactersEventFetchAnimeCharacters>(fetchAnimeCharacters);
  }

  Future<void> fetchAnimeCharacters(
    AnimeCharactersEventFetchAnimeCharacters event,
    Emitter<AnimeCharactersState> emit,
  ) async {
    emit(const AnimeCharactersStateLoading());
    final result = await getAnimeCharactersWithAnimeId(event.animeId);
    result.fold(
      (l) => emit(AnimeCharactersStateError(failureToMessage(l))),
      (r) => emit(Loaded(r)),
    );
  }
}
