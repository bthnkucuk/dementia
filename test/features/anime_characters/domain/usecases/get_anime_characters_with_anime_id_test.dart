import 'dart:convert';
import 'package:dementia/features/anime_characters/data/models/anime_characters/anime_characters_model.dart';
import 'package:dementia/features/anime_characters/domain/rerpositories/anime_characters_repository.dart';
import 'package:dementia/features/anime_characters/domain/usecases/get_anime_characters_with_anime_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../dummy_data/anime_caracters/reader.dart';
@GenerateNiceMocks([MockSpec<IAnimeCharactersRepository>()])
import 'get_anime_characters_with_anime_id_test.mocks.dart';

void main() {
  late GetAnimeCharactersWithAnimeId usecase;
  late MockIAnimeCharactersRepository mockAnimeRepository;

  setUp(() {
    mockAnimeRepository = MockIAnimeCharactersRepository();
    usecase = GetAnimeCharactersWithAnimeId(mockAnimeRepository);
  });

  const animeId = 1;
  final model = AnimeCharactersModel.fromJson(
      jsonDecode(dummyAnimeCharactersReader()) as Map<String, dynamic>);

  test('get AnimeCharactersModel from repository', () async {
    when(mockAnimeRepository.getAnimeCharactersWithCharacterId(any))
        .thenAnswer((_) async => Right(model));

    final result = await usecase(animeId);
    expect(result, Right(model));
    verify(mockAnimeRepository.getAnimeCharactersWithCharacterId(animeId));
    verifyNoMoreInteractions(mockAnimeRepository);
  });
}
