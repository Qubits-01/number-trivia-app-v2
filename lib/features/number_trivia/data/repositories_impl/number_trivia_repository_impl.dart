import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/networking/network_info.dart';
import '../../domain/entities/number_trivia_entity.dart';
import '../../domain/repositories_contract/number_trivia_repository_contract.dart';
import '../data_sources/number_trivia_local_data_source.dart';
import '../data_sources/number_trivia_remote_data_source.dart';
import '../models/number_trivia_model.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepositoryContract {
  final NetworkInfo networkInfo;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;

  const NumberTriviaRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia({
    required int number,
  }) async {
    return await _getTrivia(
      () => remoteDataSource.getConcreteNumberTrivia(number: number),
    );
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTriviaEntity>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final NumberTriviaModel remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(triviaToCache: remoteTrivia);

        return Right(remoteTrivia);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final NumberTriviaModel localTrivia =
            await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }
}
