import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  const NumberTriviaLocalDataSource();

  /// Gets the cached [NumberTriviaModel] which was got the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia({required NumberTriviaModel triviaToCache});
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  const NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  // ignore: constant_identifier_names
  static const CACHED_NUMBER_TRIVIA_KEY = 'CACHED_NUMBER_TRIVIA';

  @override
  Future<void> cacheNumberTrivia({required NumberTriviaModel triviaToCache}) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA_KEY,
      json.encode(triviaToCache.toJson()),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA_KEY);
    if (jsonString != null) {
      // Future which is immediately completed.
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw const CacheException();
    }
  }
}
