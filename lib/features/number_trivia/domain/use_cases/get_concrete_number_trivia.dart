import 'package:dartz/dartz.dart';
import 'package:number_trivia_app_v2/core/errors/failure.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/entities/number_trivia_entity.dart';

import '../repositories_contract/number_trivia_repository_contract.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepositoryContract repository;

  const GetConcreteNumberTrivia({required this.repository});

  Future<Either<Failure, NumberTriviaEntity>> execute({
    required int number,
  }) async {
    return await repository.getConcreteNumberTrivia(number: number);
  }
}
