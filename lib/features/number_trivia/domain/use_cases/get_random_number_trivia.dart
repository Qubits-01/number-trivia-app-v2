import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/number_trivia_entity.dart';

import '../repositories_contract/number_trivia_repository_contract.dart';

class GetRandomNumberTrivia implements UseCase<NumberTriviaEntity, NoParams> {
  final NumberTriviaRepositoryContract repository;

  const GetRandomNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTriviaEntity>> call({
    required NoParams params,
  }) async {
    return await repository.getRandomNumberTrivia();
  }
}
