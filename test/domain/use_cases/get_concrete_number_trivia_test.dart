import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_v2/core/errors/failures.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';

import 'mocks/generate_mock_number_trivia_repository_contract.mocks.dart';

void main() {
  late final MockNumberTriviaRepositoryContract
      mockNumberTriviaRepositoryContract;
  late final GetConcreteNumberTrivia useCase;

  setUp(() {
    mockNumberTriviaRepositoryContract = MockNumberTriviaRepositoryContract();
    useCase =
        GetConcreteNumberTrivia(repository: mockNumberTriviaRepositoryContract);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTriviaEntity(text: 'Test text.', number: tNumber);

  test(
    'Should get trivia for the number from the repository.',
    () async {
      // ARRANGE
      // 'On the fly' implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument (non-null), always answer with
      // the Right 'side' of Either type containing a test NumberTrivia object.
      when(mockNumberTriviaRepositoryContract.getConcreteNumberTrivia(
        number: argThat(isNotNull, named: 'number'),
      )).thenAnswer((_) async => const Right(tNumberTrivia));

      // ACT
      // The 'act' phase of the test.
      final Either<Failure, NumberTriviaEntity> result =
          await useCase(params: const Params(number: tNumber));

      // ASSERT
      // UseCase should simply return whatever was returned from the Repository.
      expect(result, equals(const Right(tNumberTrivia)));

      // Verify that the method has been called on the Repository.
      verify(mockNumberTriviaRepositoryContract.getConcreteNumberTrivia(
        number: tNumber,
      ));

      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockNumberTriviaRepositoryContract);
    },
  );
}
