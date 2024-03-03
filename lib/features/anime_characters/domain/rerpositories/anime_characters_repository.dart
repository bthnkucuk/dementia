import 'package:fpdart/fpdart.dart';
import '../../../../../core/failures/failures.dart';
import '../../data/models/anime_characters/anime_characters_model.dart';

abstract class IAnimeCharactersRepository {
  Future<Either<IFailure, AnimeCharactersModel>>
      getAnimeCharactersWithCharacterId(int animeId, {String? type});
}
