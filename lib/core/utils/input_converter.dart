import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

class InputConverter {
  const InputConverter();

  Either<Failure, int> stringToUnsignedInt({required String stringValue}) {
    try {
      final convertedStringValue = int.parse(stringValue);
      if (convertedStringValue < 0) throw const FormatException();

      return Right(convertedStringValue);
    } on FormatException {
      return const Left(InvalidInputFailure());
    }
  }
}
