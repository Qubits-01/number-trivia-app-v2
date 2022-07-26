// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app_v2/core/utils/input_converter.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/number_trivia_entity.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(const NumberTriviaInitial()) {
    on<NumberTriviaGetBtnPressed>((event, emit) {
      emit(const NumberTriviaInitial());
      emit(const NumberTriviaLoadInProgress());

      final Either<Failure, int> parsedInt =
          inputConverter.stringToUnsignedInt(stringValue: event.numberString);

      parsedInt.fold(
        (failure) => emit(
          NumberTriviaLoadFailure(message: InvalidInputFailure.errorMsg),
        ),
        (integer) {
          throw UnimplementedError();
        },
      );
    });

    on<NumberTriviaRandomBtnPressed>((event, emit) {});
  }
}
