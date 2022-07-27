import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'core/networking/network_info.dart';
import 'core/utils/input_converter.dart';
import 'features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories_impl/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories_contract/number_trivia_repository_contract.dart';
import 'features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/state_holders/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //* Features - Number Trivia
  // Blocs.
  sl.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );

  // Use Cases.
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(repository: sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(repository: sl()));

  // Repositories.
  sl.registerLazySingleton<NumberTriviaRepositoryContract>(
    () => NumberTriviaRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data Sources.
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //* Core
  // Input Converter.
  sl.registerLazySingleton(() => const InputConverter());

  // Network Info.
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  //* External
  // Shared Preferences.
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Http Client.
  sl.registerLazySingleton(() => http.Client());

  // Data Connection Checker Null
  sl.registerLazySingleton(() => DataConnectionChecker());
}
