import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app_v2/features/number_trivia/data/repositories_impl/number_trivia_repository_impl.dart';

import '../../core/platform/mocks/generate_mock_network_info.mocks.dart';
import '../data_sources/mocks/generate_mock_number_trivia_local_data_source.mocks.dart';
import '../data_sources/mocks/generate_mock_number_trivia_remote_data_source.mocks.dart';

void main() {
  NumberTriviaRepositoryImpl repository;
  MockNetworkInfo mockNetworkInfo;
  MockNumberTriviaRemoteDataSource mockRemoteDataSource;
  MockNumberTriviaLocalDataSource mockLocalDataSource;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockLocalDataSource = MockNumberTriviaLocalDataSource();
    repository = NumberTriviaRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });
}
