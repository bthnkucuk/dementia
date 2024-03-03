import 'package:fpdart/fpdart.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/anime_reviews/anime_reviews_model.dart';

abstract class IAnimeReviewsRepository {
  Future<Either<IFailure, AnimeReviewsModel>> getAnimeReviewsWithAnimeId(
      int animeId);
}
