part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  final String? property;

  const NumberTriviaEvent({this.property});

  @override
  List<Object?> get props => [property];
}

class NumberTriviaGetBtnPressed extends NumberTriviaEvent {
  final String numberString;

  const NumberTriviaGetBtnPressed({
    required this.numberString,
  }) : super(property: numberString);
}

class NumberTriviaRandomBtnPressed extends NumberTriviaEvent {
  const NumberTriviaRandomBtnPressed();
}
