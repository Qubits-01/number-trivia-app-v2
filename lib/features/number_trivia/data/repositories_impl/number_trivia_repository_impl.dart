import '../../../../core/platform/network_info.dart';
import '../data_sources/number_trivia_local_data_source.dart';
import '../data_sources/number_trivia_remote_data_source.dart';
import '../../domain/entities/number_trivia_entity.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories_contract/number_trivia_repository_contract.dart';

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
  Future<Either<Failure, NumberTriviaEntity>> getConcreteNumberTrivia(
      {required int number}) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTriviaEntity>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
