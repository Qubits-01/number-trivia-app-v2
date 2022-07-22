import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_v2/core/networking/network_info.dart';

import 'mocks/generate_mock_data_connection_checker_nulls.mocks.dart';

void main() {
  late final NetworkInfoImpl networkInfo;
  late final MockDataConnectionChecker mockDataConnectionChecker;

  setUpAll(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(connectionChecker: mockDataConnectionChecker);
  });

  group('isConnected', () {
    test('Should forward the call to DataConnectionChecker.hasConnection',
        () async {
      // ARRANGE
      final tHasConnectionFuture = Future.value(true);

      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      // ACT
      // Notice: We're not awaiting the result.
      final Future<bool> result = networkInfo.isConnected;

      // ASSERT
      verify(mockDataConnectionChecker.hasConnection);

      // Utilizing Dart's default referential equality.
      // Only references to the same object are equal.
      expect(result, equals(tHasConnectionFuture));
    });
  });
}
