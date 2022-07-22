// Mocks generated by Mockito 5.2.0 from annotations
// in number_trivia_app_v2/test/data/data_sources/mocks/generate_mock_number_trivia_local_data_source.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:number_trivia_app_v2/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart'
    as _i3;
import 'package:number_trivia_app_v2/features/number_trivia/data/models/number_trivia_model.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeNumberTriviaModel_0 extends _i1.Fake
    implements _i2.NumberTriviaModel {}

/// A class which mocks [NumberTriviaLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockNumberTriviaLocalDataSource extends _i1.Mock
    implements _i3.NumberTriviaLocalDataSource {
  MockNumberTriviaLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.NumberTriviaModel> getLastNumberTrivia() =>
      (super.noSuchMethod(Invocation.method(#getLastNumberTrivia, []),
              returnValue: Future<_i2.NumberTriviaModel>.value(
                  _FakeNumberTriviaModel_0()))
          as _i4.Future<_i2.NumberTriviaModel>);
  @override
  _i4.Future<void> cacheNumberTrivia({_i2.NumberTriviaModel? triviaToCache}) =>
      (super.noSuchMethod(
          Invocation.method(
              #cacheNumberTrivia, [], {#triviaToCache: triviaToCache}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}
