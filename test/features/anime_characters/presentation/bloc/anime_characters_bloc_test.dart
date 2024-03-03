import 'dart:convert';

import 'package:dementia/core/failures/failures.dart';
import 'package:dementia/core/helpers/failure_to_message.dart';
import 'package:dementia/features/anime_characters/data/models/anime_characters/anime_characters_model.dart';
import 'package:dementia/features/anime_characters/domain/usecases/get_anime_characters_with_anime_id.dart';
import 'package:dementia/features/anime_characters/presentation/bloc/anime_characters_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../dummy_data/anime_caracters/reader.dart';
@GenerateNiceMocks([MockSpec<GetAnimeCharactersWithAnimeId>()])
import 'anime_characters_bloc_test.mocks.dart';

void main() {
  const animeId = 1;

  late AnimeCharactersBloc bloc;
  late GetAnimeCharactersWithAnimeId getAnimeCharactersWithAnimeId;
  late AnimeCharactersModel model;

  setUp(() async {
    getAnimeCharactersWithAnimeId = MockGetAnimeCharactersWithAnimeId();
    bloc = AnimeCharactersBloc(getAnimeCharactersWithAnimeId);
    model = AnimeCharactersModel.fromJson(
        jsonDecode(dummyAnimeCharactersReader()) as Map<String, dynamic>);
  });

  test('initial state should be _AnimeCharactersStateInitial.', () {
    // assert
    expect(bloc.state, equals(const AnimeCharactersState.initial()));
  });

  blocTest<AnimeCharactersBloc, AnimeCharactersState>(
    'emits [_AnimeCharactersEventFetchAnimeCharacters] when AnimeCharactersEvent.fetchAnimeCharacters(animeId) is added. If successfull, emits AnimeCharactersState.loaded(model)',
    build: () {
      when(getAnimeCharactersWithAnimeId(animeId))
          .thenAnswer((_) async => Right(model));

      return bloc;
    },
    act: (bloc) =>
        bloc.add(const AnimeCharactersEvent.fetchAnimeCharacters(animeId)),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      const AnimeCharactersState.loading(),
      AnimeCharactersState.loaded(model),
    ],
  );

  blocTest<AnimeCharactersBloc, AnimeCharactersState>(
    'emits [_AnimeCharactersEventFetchAnimeCharacters] when AnimeCharactersEvent.fetchAnimeCharacters(animeId) is added. If unsuccessfull AnimeGeneralErrorPage(failureToMessage(NetworkFailure()))',
    build: () {
      when(getAnimeCharactersWithAnimeId(animeId))
          .thenAnswer((_) async => Left(NetworkFailure()));
      return bloc;
    },
    act: (bloc) =>
        bloc.add(const AnimeCharactersEvent.fetchAnimeCharacters(animeId)),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      const AnimeCharactersState.loading(),
      AnimeCharactersState.error(failureToMessage(NetworkFailure())),
    ],
  );
}
