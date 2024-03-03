import 'dart:convert';

import 'package:dementia/core/failures/failures.dart';
import 'package:dementia/core/helpers/failure_to_message.dart';
import 'package:dementia/features/anime_reviews/data/models/anime_reviews/anime_reviews_model.dart';
import 'package:dementia/features/anime_reviews/domain/usecases/get_anime_reviews_with_anime_id.dart';
import 'package:dementia/features/anime_reviews/presentation/bloc/anime_reviews_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../dummy_data/anime_reviews/reader.dart';
@GenerateNiceMocks([MockSpec<GetAnimeReviewsWithAnimeId>()])
import 'anime_reviews_bloc_test.mocks.dart';

void main() {
  const animeId = 1;

  late AnimeReviewsBloc bloc;
  late GetAnimeReviewsWithAnimeId getAnimeReviewsWithAnimeId;
  late AnimeReviewsModel model;

  setUp(() async {
    getAnimeReviewsWithAnimeId = MockGetAnimeReviewsWithAnimeId();
    bloc = AnimeReviewsBloc(getAnimeReviewsWithAnimeId);
    model = AnimeReviewsModel.fromJson(
        jsonDecode(dummyAnimeReviewsReader()) as Map<String, dynamic>);
  });

  test('initial state should be _AnimeReviewsStateInitial.', () {
    // assert
    expect(bloc.state, equals(const AnimeReviewsState.initial()));
  });

  blocTest<AnimeReviewsBloc, AnimeReviewsState>(
    'emits [_AnimeReviewsEventFetchAnimeReviews] when AnimeReviewsEvent.fetchAnimeReviews(animeId) is added. If successfull, emits AnimeReviewsState.loaded(model)',
    build: () {
      when(getAnimeReviewsWithAnimeId(animeId))
          .thenAnswer((_) async => Right(model));

      return bloc;
    },
    act: (bloc) => bloc.add(const AnimeReviewsEvent.fetchAnimeReviews(animeId)),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      const AnimeReviewsState.loading(),
      AnimeReviewsState.loaded(model),
    ],
  );

  blocTest<AnimeReviewsBloc, AnimeReviewsState>(
    'emits [_AnimeReviewsEventFetchAnimeReviews] when AnimeReviewsEvent.fetchAnimeReviews(animeId) is added. If unsuccessfull AnimeGeneralErrorPage(failureToMessage(NetworkFailure()))',
    build: () {
      when(getAnimeReviewsWithAnimeId(animeId))
          .thenAnswer((_) async => Left(NetworkFailure()));
      return bloc;
    },
    act: (bloc) => bloc.add(const AnimeReviewsEvent.fetchAnimeReviews(animeId)),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      const AnimeReviewsState.loading(),
      AnimeReviewsState.error(failureToMessage(NetworkFailure())),
    ],
  );
}
