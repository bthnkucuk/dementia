import 'dart:convert';

import 'package:dementia/core/exceptions/exceptions.dart';
import 'package:dementia/core/failures/failures.dart';
import 'package:dementia/core/helpers/network_info.dart';
import 'package:dementia/features/anime_characters/data/data_sources/anime_characters_network_data_source.dart.dart';
import 'package:dementia/features/anime_characters/data/models/anime_characters/anime_characters_model.dart';
import 'package:dementia/features/anime_characters/data/repositories/anime_characters_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../dummy_data/anime_caracters/reader.dart';
@GenerateNiceMocks(
    [MockSpec<AnimeCharactersNetworkDataSource>(), MockSpec<NetworkInfo>()])
import 'anime_characters_repository_test.mocks.dart';

void main() {
  late AnimeCharactersRepository repository;

  late AnimeCharactersNetworkDataSource networkDataSource;

  late NetworkInfo networkInfo;

  setUp(() {
    networkDataSource = MockAnimeCharactersNetworkDataSource();

    networkInfo = MockNetworkInfo();

    repository = AnimeCharactersRepository(
      networkDataSource: networkDataSource,
      networkInfo: networkInfo,
    );
  });

  group('getAnimeCharacters', () {
    const animeId = 1;
    final model =
        AnimeCharactersModel.fromJson(jsonDecode(dummyAnimeCharactersReader()));
    test('is network active', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      repository.getAnimeCharactersWithCharacterId(animeId);

      verify(networkInfo.isConnected);
    });

    group('device have connection', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('returns AnimeCharactersModel', () async {
        when(networkDataSource.getAnimeCharacters(animeId))
            .thenAnswer((_) async => model);

        final result =
            await repository.getAnimeCharactersWithCharacterId(animeId);

        verify(networkDataSource.getAnimeCharacters(animeId));
        expect(result, Right(model));
      });

      test('returns serverFailure', () async {
        when(networkDataSource.getAnimeCharacters(animeId))
            .thenThrow(ServerException());

        final result =
            await repository.getAnimeCharactersWithCharacterId(animeId);

        verify(networkDataSource.getAnimeCharacters(animeId));
        expect(result, Left(ServerFailure()));
      });
    });

    group("device haven't connection", () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('returns NetworkFailure', () async {
        when(networkDataSource.getAnimeCharacters(animeId))
            .thenAnswer((_) async => model);

        final result =
            await repository.getAnimeCharactersWithCharacterId(animeId);

        expect(result, Left(NetworkFailure()));
      });
    });
  });
}
