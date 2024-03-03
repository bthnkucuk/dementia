import 'package:fpdart/fpdart.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/top_animes/top_animes_model.dart';
import '../rerpositories/top_animes_repository.dart';

class GetTopAnimesWithPageNumber implements IUseCase<TopAnimesModel, int> {
  final ITopAnimeSRepository repository;

  GetTopAnimesWithPageNumber(this.repository);

  @override
  Future<Either<IFailure, TopAnimesModel>> call(int pageNumber,
      {String? type}) async {
    return await repository.getTopAnimesWithPageNumber(pageNumber, type: type);
  }
}
