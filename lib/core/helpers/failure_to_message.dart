import '../failures/failures.dart';

String failureToMessage(IFailure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Server Failure';
    case NetworkFailure:
      return 'Network Failure';
    default:
      return 'Unexpected Error';
  }
}
