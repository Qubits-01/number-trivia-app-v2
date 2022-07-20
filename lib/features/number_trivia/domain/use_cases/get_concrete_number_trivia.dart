import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app_v2/core/errors/failure.dart';
import 'package:number_trivia_app_v2/core/use_cases/use_case.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/entities/number_trivia_entity.dart';

import '../repositories_contract/number_trivia_repository_contract.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTriviaEntity, Params> {
  final NumberTriviaRepositoryContract repository;

  const GetConcreteNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTriviaEntity>> call({
    required Params params,
  }) async {
    return await repository.getConcreteNumberTrivia(number: params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
