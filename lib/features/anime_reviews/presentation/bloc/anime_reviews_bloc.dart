// ignore_for_file: library_private_types_in_public_api

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../data/models/anime_reviews/anime_reviews_model.dart';
import '../../domain/usecases/get_anime_reviews_with_anime_id.dart';
part 'anime_reviews_event.dart';
part 'anime_reviews_state.dart';
part 'anime_reviews_bloc.freezed.dart';

class AnimeReviewsBloc extends Bloc<AnimeReviewsEvent, AnimeReviewsState> {
  final GetAnimeReviewsWithAnimeId getAnimeReviewsWithAnimeId;
  AnimeReviewsBloc(this.getAnimeReviewsWithAnimeId)
      : super(const AnimeReviewsStateInitial()) {
    on<AnimeReviewsEventFetchAnimeReviews>(fetchAnimeReviews);
  }

  /// [fetchAnimeReviews] is a event listener that fetches anime reviews data from the [GetAnimeReviewsWithAnimeId] and emits a state.
  Future<void> fetchAnimeReviews(
    AnimeReviewsEventFetchAnimeReviews event,
    Emitter<AnimeReviewsState> emit,
  ) async {
    emit(const AnimeReviewsStateLoading());
    final result = await getAnimeReviewsWithAnimeId(event.animeId);

    result.fold(
      (l) => emit(AnimeReviewsStateError(failureToMessage(l))),
      (r) => emit(AnimeReviewsStateLoaded(r)),
    );
  }
}
