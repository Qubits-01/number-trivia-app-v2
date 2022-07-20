import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failure.dart';

/// Parameters [Params] have to be put into a container object so that they can be
/// included in this abstract base class method definition.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

/// This will be used by the code calling the use case whenever the use case
/// doesn't accept any parameters.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
