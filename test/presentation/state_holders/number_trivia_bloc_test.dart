import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_v2/core/errors/failures.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/entities/number_trivia_entity.dart';

import 'package:number_trivia_app_v2/features/number_trivia/presentation/state_holders/bloc/number_trivia_bloc.dart';

import 'mocks/generate_mock_get_concrete_number_trivia.mocks.dart';
import 'mocks/generate_mock_get_random_number_trivia.mocks.dart';
import 'mocks/generate_mock_input_converter.mocks.dart';

void main() {
  late final NumberTriviaBloc bloc;
  late final MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late final MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late final MockInputConverter mockInputConverter;

  setUpAll(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  group('NumberTriviaGetBtnPressed', () {
    // The event takes in a String.
    const tNumberString = '1';

    // This is the successful output of the InputConverter.
    final tNumberParsed = int.parse(tNumberString);

    // NumberTriviaEntity instance is needed too.
    final tNumberTriviaEntity = NumberTriviaEntity(
      text: 'Test text.',
      number: tNumberParsed,
    );

    test(
      'Should call the InputConverter to validate and convert the String to an unsigned int.',
      () async {
        // ARRANGE
        when(mockInputConverter.stringToUnsignedInt(
          stringValue: argThat(
            isNotNull,
            named: 'stringValue',
          ),
        )).thenReturn(Right(tNumberParsed));

        // ACT
        bloc.add(const NumberTriviaGetBtnPressed(numberString: tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInt(
          stringValue: argThat(
            isNotNull,
            named: 'stringValue',
          ),
        ));

        // ASSERT
        verify(mockInputConverter.stringToUnsignedInt(
          stringValue: tNumberString,
        ));
      },
    );

    test('Should emit an [Error] when the input is invalid.', () {
      // ARRANGE
      when(mockInputConverter.stringToUnsignedInt(
        stringValue: argThat(
          isNotNull,
          named: 'stringValue',
        ),
      )).thenReturn(const Left(InvalidInputFailure()));

      // ASSERT LATER
      final expectedStates = <NumberTriviaState>[
        const NumberTriviaInitial(),
        const NumberTriviaLoadInProgress(),
        NumberTriviaLoadFailure(message: InvalidInputFailure.errorMsg),
      ];
      expectLater(bloc.stream, emitsInOrder(expectedStates));

      // ACT
      bloc.add(const NumberTriviaGetBtnPressed(numberString: tNumberString));
    });
  });
}
