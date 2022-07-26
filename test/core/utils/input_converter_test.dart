import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app_v2/core/errors/failures.dart';
import 'package:number_trivia_app_v2/core/utils/input_converter.dart';

void main() {
  late final InputConverter inputConverter;

  setUpAll(() => inputConverter = const InputConverter());

  group('stringToUnsignedInt', () {
    test(
        'Should return an integer when the string represents an unsigned integer.',
        () {
      // ARRANGE
      const tString = '123';

      // ACT
      final Either<Failure, int> result =
          inputConverter.stringToUnsignedInt(stringValue: tString);

      // ASSERT
      expect(result, equals(const Right(123)));
    });

    test('Should return a failure when the string is not an integer.', () {
      // ARRANGE
      const tString1 = 'abc';
      const tString2 = '1.2';

      // ACT
      final Either<Failure, int> result1 =
          inputConverter.stringToUnsignedInt(stringValue: tString1);
      final Either<Failure, int> result2 =
          inputConverter.stringToUnsignedInt(stringValue: tString2);

      // ASSERT
      expect(result1, equals(const Left(InvalidInputFailure())));
      expect(result2, equals(const Left(InvalidInputFailure())));
    });

    test('Should return a failure when the string is a negative integer.', () {
      // ARRANGE
      const tString = '-123';

      // ACT
      final Either<Failure, int> result =
          inputConverter.stringToUnsignedInt(stringValue: tString);

      // ASSERT
      expect(result, equals(const Left(InvalidInputFailure())));
    });
  });
}
