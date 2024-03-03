import 'package:fpdart/fpdart.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../data/models/anime_characters/anime_characters_model.dart';
import '../rerpositories/anime_characters_repository.dart';

/// [GetAnimeCharactersWithAnimeId] is a class that provides anime characters data from the [AnimeCharactersRepository].
class GetAnimeCharactersWithAnimeId
    implements IUseCase<AnimeCharactersModel, int> {
  final IAnimeCharactersRepository repository;

  GetAnimeCharactersWithAnimeId(this.repository);

  @override
  Future<Either<IFailure, AnimeCharactersModel>> call(int animeId) async {
    return await repository.getAnimeCharactersWithCharacterId(animeId);
  }
}
