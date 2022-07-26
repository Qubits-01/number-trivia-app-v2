import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties;

  /// If the subclasses have some properties, they'll get passed to this constructor.
  /// so that [Equatable] can perform value comparison.
  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

// General failures.
class ServerFailure extends Failure {
  static const String errorMsg = 'Server Failure.';

  const ServerFailure();
}

class CacheFailure extends Failure {
  static const String errorMsg = 'Cache Failure. ';

  const CacheFailure();
}

class InvalidInputFailure extends Failure {
  static const String errorMsg =
      'Invalid Input - The number must be a positive integer or zero.';

  const InvalidInputFailure();
}
