import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_v2/core/errors/exceptions.dart';
import 'package:number_trivia_app_v2/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_app_v2/features/number_trivia/data/models/number_trivia_model.dart';

import '../../fixtures/fixture_reader.dart';
import 'mocks/generate_mock_http_client.mocks.dart';

void main() {
  late final NumberTriviaRemoteDataSourceImpl dataSource;
  late final MockClient mockHttpClient;

  setUpAll(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture(fileName: 'trivia_int.json')),
    );

    void setUpMockHttpClientSuccess200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture(fileName: 'trivia_int.json'), 200),
      );
    }

    void setUpMockHttpClientError404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('Something went wrong.', 404),
      );
    }

    test(
      'Should perform a GET request on a URL with number being the endpoint and with application/json header.',
      () {
        // ARRANGE
        setUpMockHttpClientSuccess200();

        // ACT
        dataSource.getConcreteNumberTrivia(number: tNumber);

        // ASSERT
        final uri = Uri.parse('http://numbersapi.com/$tNumber');
        const headers = {'Content-Type': 'application/json'};
        verify(mockHttpClient.get(uri, headers: headers));
      },
    );

    test(
      'Should return NumberTrivia when the response code is 200 (success).',
      () async {
        // ARRANGE
        setUpMockHttpClientSuccess200();

        // ACT
        final NumberTriviaModel result =
            await dataSource.getConcreteNumberTrivia(number: tNumber);

        // ASSERT
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404.',
      () async {
        // ARRANGE
        setUpMockHttpClientError404();

        // ACT
        final Future<NumberTriviaModel> Function({required int number}) call =
            dataSource.getConcreteNumberTrivia;

        // ASSERT
        expect(
          () => call(number: tNumber),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture(fileName: 'trivia_int.json')),
    );

    void setUpMockHttpClientSuccess200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture(fileName: 'trivia_int.json'), 200),
      );
    }

    void setUpMockHttpClientError404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('Something went wrong.', 404),
      );
    }

    test(
      'Should perform a GET request on a URL with a random endpoint and with application/json header.',
      () {
        // ARRANGE
        setUpMockHttpClientSuccess200();

        // ACT
        dataSource.getRandomNumberTrivia();

        // ASSERT
        final uri = Uri.parse('http://numbersapi.com/random');
        const headers = {'Content-Type': 'application/json'};
        verify(mockHttpClient.get(uri, headers: headers));
      },
    );

    test(
      'Should return NumberTrivia when the response code is 200 (success).',
      () async {
        // ARRANGE
        setUpMockHttpClientSuccess200();

        // ACT
        final NumberTriviaModel result =
            await dataSource.getRandomNumberTrivia();

        // ASSERT
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'Should throw a ServerException when the response code is 404.',
      () async {
        // ARRANGE
        setUpMockHttpClientError404();

        // ACT
        final Future<NumberTriviaModel> Function() call =
            dataSource.getRandomNumberTrivia;

        // ASSERT
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
