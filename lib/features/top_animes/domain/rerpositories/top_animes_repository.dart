import 'package:fpdart/fpdart.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/top_animes/top_animes_model.dart';

abstract class ITopAnimeSRepository {
  Future<Either<IFailure, TopAnimesModel>> getTopAnimesWithPageNumber(
      int pageNumber,
      {String? type});
}
