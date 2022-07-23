import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_v2/core/errors/exceptions.dart';
import 'package:number_trivia_app_v2/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia_app_v2/features/number_trivia/data/models/number_trivia_model.dart';

import '../../fixtures/fixture_reader.dart';
import 'mocks/generate_mock_shared_preferences.mocks.dart';

void main() {
  late final NumberTriviaLocalDataSourceImpl dataSource;
  late final MockSharedPreferences mockSharedPreferences;

  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(fixture(fileName: 'trivia_cached.json')));

    test(
        'Should return numberTrivia from SharedPreferences when there is one in the cache.',
        () async {
      // ARRANGE
      when(mockSharedPreferences.getString(argThat(isNotNull)))
          .thenReturn(fixture(fileName: 'trivia_cached.json'));

      // ACT
      final result = await dataSource.getLastNumberTrivia();

      // ASSERT
      verify(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
      expect(result, equals(tNumberTriviaModel));
    });

    test('Should throw a CacheException when there is no cached value.', () {
      // ARRANGE
      when(mockSharedPreferences.getString(argThat(isNotNull)))
          .thenReturn(null);

      // ACT
      // Not calling the method here, just storing it inside a call variable.
      final call = dataSource.getLastNumberTrivia;

      // ASSERT
      // Calling the method happens from a higher-order function passed.
      // This is needed to test if calling a method throws an exception.
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test text.');
    final expectedJsonString = json.encode(tNumberTriviaModel.toJson());

    test('Should call SharedPreferences to cache the data.', () {
      // ARRANGE
      when(mockSharedPreferences.setString(
        argThat(isNotNull),
        argThat(isNotNull),
      )).thenAnswer((_) async => true);

      // ACT
      dataSource.cacheNumberTrivia(triviaToCache: tNumberTriviaModel);

      // ASSERT
      verify(mockSharedPreferences.setString(
        NumberTriviaLocalDataSourceImpl.CACHED_NUMBER_TRIVIA_KEY,
        expectedJsonString,
      ));
    });
  });
}
