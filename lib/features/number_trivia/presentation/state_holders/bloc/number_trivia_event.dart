part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  final List<dynamic> properties;

  const NumberTriviaEvent({
    List<dynamic> props = const <dynamic>[],
  }) : properties = props;

  @override
  List<Object> get props => [properties];
}

class NumberTriviaGetBtnPressed extends NumberTriviaEvent {
  final String numberString;

  NumberTriviaGetBtnPressed({
    required this.numberString,
  }) : super(props: [numberString]);
}

class NumberTriviaRandomBtnPressed extends NumberTriviaEvent {}
