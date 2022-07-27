// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app_v2/core/use_cases/use_case.dart';
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
    on<NumberTriviaGetBtnPressed>(
      (event, emit) async => await _getBtnPressedEvent(event, emit),
    );

    on<NumberTriviaRandomBtnPressed>(
      (event, emit) => _randomBtnPressed(event, emit),
    );
  }

  Future<void> _getBtnPressedEvent(
    NumberTriviaGetBtnPressed event,
    Emitter<NumberTriviaState> emit,
  ) async {
    _emitInitialThenInProgress(emit);

    final Either<Failure, int> parsedInt =
        inputConverter.stringToUnsignedInt(stringValue: event.numberString);

    await parsedInt.fold(
      (failure) async => emit(NumberTriviaLoadFailure(
        message: _mapFailureToErrorMsg(failure: failure),
      )),
      (integer) async {
        final Either<Failure, NumberTriviaEntity> retrievedTrivia =
            await getConcreteNumberTrivia(params: Params(number: integer));

        _emitEitherSuccessOrFailureState(
          emit: emit,
          retrievedTrivia: retrievedTrivia,
        );
      },
    );
  }

  Future<void> _randomBtnPressed(
    NumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    _emitInitialThenInProgress(emit);

    final Either<Failure, NumberTriviaEntity> retrievedTrivia =
        await getRandomNumberTrivia(params: const NoParams());

    _emitEitherSuccessOrFailureState(
      emit: emit,
      retrievedTrivia: retrievedTrivia,
    );
  }

  void _emitInitialThenInProgress(Emitter<NumberTriviaState> emit) {
    emit(const NumberTriviaInitial());
    emit(const NumberTriviaLoadInProgress());
  }

  void _emitEitherSuccessOrFailureState({
    required Either<Failure, NumberTriviaEntity> retrievedTrivia,
    required Emitter<NumberTriviaState> emit,
  }) {
    retrievedTrivia.fold(
      (failure) => emit(NumberTriviaLoadFailure(
        message: _mapFailureToErrorMsg(failure: failure),
      )),
      (numberTriviaEntity) => emit(
        NumberTriviaLoadSuccess(numberTriviaEntity: numberTriviaEntity),
      ),
    );
  }

  String _mapFailureToErrorMsg({required Failure failure}) {
    if (failure is ServerFailure) {
      return ServerFailure.errorMsg;
    } else if (failure is CacheFailure) {
      return CacheFailure.errorMsg;
    } else if (failure is InvalidInputFailure) {
      return InvalidInputFailure.errorMsg;
    } else {
      return 'Unexpected Error.';
    }
  }
}
