// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_v2/core/errors/exceptions.dart';
import 'package:number_trivia_app_v2/core/errors/failures.dart';
import 'package:number_trivia_app_v2/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_app_v2/features/number_trivia/data/repositories_impl/number_trivia_repository_impl.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/entities/number_trivia_entity.dart';

import '../../core/platform/mocks/generate_mock_network_info.mocks.dart';
import '../data_sources/mocks/generate_mock_number_trivia_local_data_source.mocks.dart';
import '../data_sources/mocks/generate_mock_number_trivia_remote_data_source.mocks.dart';

void main() {
  late final NumberTriviaRepositoryImpl repository;
  late final MockNetworkInfo mockNetworkInfo;
  late final MockNumberTriviaRemoteDataSource mockRemoteDataSource;
  late final MockNumberTriviaLocalDataSource mockLocalDataSource;

  setUpAll(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockLocalDataSource = MockNumberTriviaLocalDataSource();
    repository = NumberTriviaRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  // DATA FOR THE MOCKS AND ASSERTIONS.
  // We'll use these three variables throughout all the tests.
  const tNumber = 1;
  const tNumberTriviaModel =
      NumberTriviaModel(text: 'Test text.', number: tNumber);
  const NumberTriviaEntity tNumberTriviaEntity = tNumberTriviaModel;

  void _runTestsOnline(VoidCallback body) {
    group('Device is online.', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void _runTestsOffline(VoidCallback body) {
    group('Device is offline.', () {
      setUp(() {
        reset(mockRemoteDataSource);
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    test('Should check if the device is online.', () async {
      // ARRANGE
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getConcreteNumberTrivia(
              number: argThat(isNotNull, named: 'number')))
          .thenAnswer((_) async => tNumberTriviaModel);

      // ACT
      await repository.getConcreteNumberTrivia(number: tNumber);

      // ASSERT
      verify(mockNetworkInfo.isConnected);
    });

    _runTestsOnline(() {
      test(
          'Should return a remote data when the call to remote data source was successful.',
          () async {
        // ARRANGE
        when(mockRemoteDataSource.getConcreteNumberTrivia(
                number: argThat(isNotNull, named: 'number')))
            .thenAnswer((_) async => tNumberTriviaModel);

        // ACT
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getConcreteNumberTrivia(number: tNumber);

        // ASSERT
        verify(mockRemoteDataSource.getConcreteNumberTrivia(number: tNumber));
        expect(result, equals(const Right(tNumberTriviaEntity)));
      });

      test(
          'Should cache the data locally when the call to remote data source is successful.',
          () async {
        // ARRANGE
        when(mockRemoteDataSource.getConcreteNumberTrivia(
                number: argThat(isNotNull, named: 'number')))
            .thenAnswer((_) async => tNumberTriviaModel);

        // ACT
        await repository.getConcreteNumberTrivia(number: tNumber);

        // ASSERT
        verify(mockRemoteDataSource.getConcreteNumberTrivia(number: tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(
            triviaToCache: tNumberTriviaModel));
      });
    });

    _runTestsOffline(() {
      test(
          'Should return last locally cached data when the cached data is present.',
          () async {
        // ARRANGE
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        // ACT
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getConcreteNumberTrivia(number: tNumber);

        // ASSERT
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTriviaEntity)));
      });

      test('Should return CacheFailure when there is no cached data present.',
          () async {
        // ARRANGE
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(const CacheException());

        // ACT
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getConcreteNumberTrivia(number: tNumber);

        // ASSERT
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    setUpAll(() {
      reset(mockNetworkInfo);
      reset(mockRemoteDataSource);
      reset(mockLocalDataSource);
    });

    test('Should check if the device is offline.', () async {
      // ARRANGE
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      // ACT
      await repository.getRandomNumberTrivia();

      // ASSERT
      verify(mockNetworkInfo.isConnected);
    });

    _runTestsOnline(() {
      test(
          'Should return a random remote data when the call to remote data source was successful.',
          () async {
        // ARRANGE
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        // ACT
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getRandomNumberTrivia();

        // ASSERT
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(const Right(tNumberTriviaEntity)));
      });

      test(
          'Should cache the random data locally when the call to remote data source is successful.',
          () async {
        // ARRANGE
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        // ACT
        await repository.getRandomNumberTrivia();

        // ASSERT
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verify(mockLocalDataSource.cacheNumberTrivia(
            triviaToCache: tNumberTriviaModel));
      });
    });

    _runTestsOffline(() {
      test(
          'Should return last locally cached data when the cached data is present.',
          () async {
        // ARRANGE
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        // ACT
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getRandomNumberTrivia();

        // ASSERT
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTriviaEntity)));
      });

      test('Should return CacheFailure when there is no cached data present.',
          () async {
        // ARRANGE
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(const CacheException());

        // ACT
        final Either<Failure, NumberTriviaEntity> result =
            await repository.getRandomNumberTrivia();

        // ASSERT
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Left(CacheFailure())));
      });
    });
  });
}
