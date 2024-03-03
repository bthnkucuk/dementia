import 'dart:convert';
import 'package:dementia/features/anime_reviews/data/models/anime_reviews/anime_reviews_model.dart';
import 'package:dementia/features/anime_reviews/domain/rerpositories/anime_reviews_repository.dart';
import 'package:dementia/features/anime_reviews/domain/usecases/get_anime_reviews_with_anime_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../dummy_data/anime_reviews/reader.dart';
@GenerateNiceMocks([MockSpec<IAnimeReviewsRepository>()])
import 'get_anime_reviews_with_anime_id_test.mocks.dart';

void main() {
  late GetAnimeReviewsWithAnimeId usecase;
  late MockIAnimeReviewsRepository mockAnimeRepository;

  setUp(() {
    mockAnimeRepository = MockIAnimeReviewsRepository();
    usecase = GetAnimeReviewsWithAnimeId(mockAnimeRepository);
  });

  const animeId = 1;
  final model = AnimeReviewsModel.fromJson(
      jsonDecode(dummyAnimeReviewsReader()) as Map<String, dynamic>);

  test('get AnimeReviewsModel from repository', () async {
    when(mockAnimeRepository.getAnimeReviewsWithAnimeId(any))
        .thenAnswer((_) async => Right(model));

    final result = await usecase(animeId);
    expect(result, Right(model));
    verify(mockAnimeRepository.getAnimeReviewsWithAnimeId(animeId));
    verifyNoMoreInteractions(mockAnimeRepository);
  });
}
