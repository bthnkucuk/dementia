import 'package:equatable/equatable.dart';

abstract class IFailure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends IFailure {}

class NetworkFailure extends IFailure {}
