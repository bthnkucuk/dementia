import 'package:dementia/core/helpers/network_info.dart';
import 'package:dementia/core/failures/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../domain/rerpositories/top_animes_repository.dart';
import '../data_sources/top_animes_network_data_source.dart.dart';
import '../models/top_animes/top_animes_model.dart';

/// [TopAnimesRepository] is a class that provides top animes data from the [TopAnimesNetworkDataSource].
class TopAnimesRepository implements ITopAnimeSRepository {
  final Talker talker;
  final TopAnimesAnimeNetworkDataSource networkDataSource;
  final NetworkInfo networkInfo;

  TopAnimesRepository({
    required this.networkDataSource,
    required this.networkInfo,
    required this.talker,
  });

  @override
  Future<Either<IFailure, TopAnimesModel>> getTopAnimesWithPageNumber(
      int pageNumber,
      {String? type}) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await networkDataSource
            .getTopAnimesWithPageNumber(pageNumber, type: type);
        return Right(model);
      } catch (e, s) {
        talker.handle(e, s);

        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
