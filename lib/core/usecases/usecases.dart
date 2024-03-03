import 'package:dementia/core/failures/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class IUseCase<T, P> {
  Future<Either<IFailure, T>> call(P params);
}
