import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_v2/core/errors/failure.dart';
import 'package:number_trivia_app_v2/core/use_cases/use_case.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/repositories_contract/number_trivia_repository_contract.dart';
import 'package:number_trivia_app_v2/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';

import 'mocks/generate_mock_number_trivia_repository_contract.mocks.dart';

@GenerateMocks([NumberTriviaRepositoryContract])
void main() {
  late final MockNumberTriviaRepositoryContract
      mockNumberTriviaRepositoryContract;
  late final GetRandomNumberTrivia useCase;

  setUp(() {
    mockNumberTriviaRepositoryContract = MockNumberTriviaRepositoryContract();
    useCase =
        GetRandomNumberTrivia(repository: mockNumberTriviaRepositoryContract);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTriviaEntity(text: 'Test text.', number: tNumber);

  test(
    'Should get random trivia for the number from the repository.',
    () async {
      // ARRANGE
      when(mockNumberTriviaRepositoryContract.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(tNumberTrivia));

      // ACT
      final Either<Failure, NumberTriviaEntity> result =
          await useCase(params: const NoParams());

      // ASSERT
      expect(result, equals(const Right(tNumberTrivia)));
      verify(mockNumberTriviaRepositoryContract.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepositoryContract);
    },
  );
}
