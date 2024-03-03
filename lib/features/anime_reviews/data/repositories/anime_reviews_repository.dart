import 'package:dementia/core/exceptions/exceptions.dart';
import 'package:dementia/core/helpers/network_info.dart';

import 'package:dementia/core/failures/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/rerpositories/anime_reviews_repository.dart';
import '../data_sources/anime_reviews_network_data_source.dart.dart';
import '../models/anime_reviews/anime_reviews_model.dart';

class AnimeReviewsRepository implements IAnimeReviewsRepository {
  final AnimeReviewsNetworkDataSource networkDataSource;
  final NetworkInfo networkInfo;

  AnimeReviewsRepository({
    required this.networkDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<IFailure, AnimeReviewsModel>> getAnimeReviewsWithAnimeId(
      int animeId) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await networkDataSource.getAnimeReviews(animeId);
        return Right(model);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
