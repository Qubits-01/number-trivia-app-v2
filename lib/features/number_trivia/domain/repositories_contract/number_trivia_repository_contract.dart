import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/number_trivia_entity.dart';

abstract class NumberTriviaRepositoryContract {
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
      {required int number});
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia();
}
