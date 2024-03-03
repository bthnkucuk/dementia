import 'dart:convert';

import 'package:dementia/core/exceptions/exceptions.dart';
import 'package:dementia/core/failures/failures.dart';
import 'package:dementia/core/helpers/network_info.dart';
import 'package:dementia/features/anime_reviews/data/data_sources/anime_reviews_network_data_source.dart.dart';
import 'package:dementia/features/anime_reviews/data/models/anime_reviews/anime_reviews_model.dart';
import 'package:dementia/features/anime_reviews/data/repositories/anime_reviews_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../dummy_data/anime_reviews/reader.dart';
@GenerateNiceMocks(
    [MockSpec<AnimeReviewsNetworkDataSource>(), MockSpec<NetworkInfo>()])
import 'anime_reviews_repository_test.mocks.dart';

void main() {
  late AnimeReviewsRepository repository;

  late AnimeReviewsNetworkDataSource networkDataSource;

  late NetworkInfo networkInfo;

  setUp(() {
    networkDataSource = MockAnimeReviewsNetworkDataSource();

    networkInfo = MockNetworkInfo();

    repository = AnimeReviewsRepository(
      networkDataSource: networkDataSource,
      networkInfo: networkInfo,
    );
  });

  group('getAnimeReviews', () {
    const animeId = 1;
    final model =
        AnimeReviewsModel.fromJson(jsonDecode(dummyAnimeReviewsReader()));
    test('is network active', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      repository.getAnimeReviewsWithAnimeId(animeId);

      verify(networkInfo.isConnected);
    });

    group('device have connection', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('returns AnimeReviewsModel', () async {
        when(networkDataSource.getAnimeReviews(animeId))
            .thenAnswer((_) async => model);

        final result = await repository.getAnimeReviewsWithAnimeId(animeId);

        verify(networkDataSource.getAnimeReviews(animeId));
        expect(result, Right(model));
      });

      test('returns serverFailure', () async {
        when(networkDataSource.getAnimeReviews(animeId))
            .thenThrow(ServerException());

        final result = await repository.getAnimeReviewsWithAnimeId(animeId);

        verify(networkDataSource.getAnimeReviews(animeId));
        expect(result, Left(ServerFailure()));
      });
    });

    group("device haven't connection", () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('returns NetworkFailure', () async {
        when(networkDataSource.getAnimeReviews(animeId))
            .thenAnswer((_) async => model);

        final result = await repository.getAnimeReviewsWithAnimeId(animeId);

        expect(result, Left(NetworkFailure()));
      });
    });
  });
}
