import 'package:fpdart/fpdart.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/anime_reviews/anime_reviews_model.dart';
import '../rerpositories/anime_reviews_repository.dart';

/// [GetAnimeReviewsWithAnimeId] is a class that provides anime reviews data from the [AnimeReviewsRepository].
class GetAnimeReviewsWithAnimeId implements IUseCase<AnimeReviewsModel, int> {
  final IAnimeReviewsRepository repository;

  GetAnimeReviewsWithAnimeId(this.repository);

  @override
  Future<Either<IFailure, AnimeReviewsModel>> call(int animeId) async {
    return await repository.getAnimeReviewsWithAnimeId(animeId);
  }
}
