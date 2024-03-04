import 'package:dementia/core/helpers/network_info.dart';

import 'package:dementia/core/failures/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../domain/rerpositories/anime_characters_repository.dart';
import '../data_sources/anime_characters_network_data_source.dart.dart';
import '../models/anime_characters/anime_characters_model.dart';

/// [AnimeCharactersRepository] is a class that provides anime characters data from the [AnimeCharactersNetworkDataSource].
class AnimeCharactersRepository implements IAnimeCharactersRepository {
  final Talker talker;
  final AnimeCharactersNetworkDataSource networkDataSource;
  final NetworkInfo networkInfo;

  AnimeCharactersRepository({
    required this.networkDataSource,
    required this.networkInfo,
    required this.talker,
  });

  @override
  Future<Either<IFailure, AnimeCharactersModel>>
      getAnimeCharactersWithCharacterId(int animeId, {String? type}) async {
    if (await networkInfo.isConnected) {
      try {
        final model = await networkDataSource.getAnimeCharacters(animeId);
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
