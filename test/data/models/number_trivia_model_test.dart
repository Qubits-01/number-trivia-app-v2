import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app_v2/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/entities/number_trivia_entity.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test text.');

  test('Should be a subclass of NumberTriviaEntity.', () {
    // Assert
    expect(tNumberTriviaModel, isA<NumberTriviaEntity>());
  });

  group('fromJson', () {
    test('Should return a valid model when the JSON number is an integer.', () {
      // ARRANGE
      final Map<String, dynamic> jsonMap =
          json.decode(fixture(fileName: 'trivia_double.json'));

      // ACT
      final result = NumberTriviaModel.fromJson(jsonMap);

      // ASSERT
      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('Should return a JSON map containing the proper data', () {
      // ACT
      final result = tNumberTriviaModel.toJson();

      // ASSERT
      const expectedJsonMap = {
        "text": "Test text.",
        "number": 1,
      };
      expect(result, equals(expectedJsonMap));
    });
  });
}
