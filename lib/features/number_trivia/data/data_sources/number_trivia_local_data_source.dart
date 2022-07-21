import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  const NumberTriviaLocalDataSource();

  /// Gets the cached [NumberTriviaModel] which was got the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}
