part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  final List<dynamic> properties;

  const NumberTriviaState({this.properties = const <dynamic>[]});

  @override
  List<Object> get props => [properties];
}

class NumberTriviaInitial extends NumberTriviaState {
  const NumberTriviaInitial();
}

class NumberTriviaLoadInProgress extends NumberTriviaState {
  const NumberTriviaLoadInProgress();
}

class NumberTriviaLoadSuccess extends NumberTriviaState {
  final NumberTriviaEntity numberTriviaEntity;

  NumberTriviaLoadSuccess({
    required this.numberTriviaEntity,
  }) : super(properties: [numberTriviaEntity]);
}

class NumberTriviaLoadFailure extends NumberTriviaState {
  final String errorMessage;

  NumberTriviaLoadFailure({
    required String message,
  })  : errorMessage = message,
        super(properties: [message]);
}
