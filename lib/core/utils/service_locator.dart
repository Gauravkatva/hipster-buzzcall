import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/user_local_data_source.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/repositories/video_call_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/video_call_repository.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/start_video_call.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/user_list/user_list_bloc.dart';
import '../../presentation/bloc/video_call/video_call_bloc.dart';
import '../network/network_info.dart';
import '../constants/app_constants.dart';

final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // External dependencies
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  await Hive.initFlutter();
  // Open Hive boxes
  final userBox = await Hive.openBox(AppConstants.userBoxName);
  final authBox = await Hive.openBox(AppConstants.authBoxName);
  sl.registerLazySingleton(() => userBox);
  sl.registerLazySingleton(() => authBox);

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl(), box: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(box: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<VideoCallRepository>(
    () => VideoCallRepositoryImpl(),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton(() => StartVideoCall(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(loginUser: sl()));
  sl.registerFactory(() => UserListBloc(getUsers: sl()));
  sl.registerFactory(() => VideoCallBloc(startVideoCall: sl()));
}
