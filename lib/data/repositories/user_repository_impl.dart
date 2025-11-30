import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

/// Implementation of UserRepository
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers({int page = 1}) async {
    // Check network connectivity
    if (await networkInfo.isConnected) {
      try {
        final userModels = await remoteDataSource.getUsers(page: page);

        // Cache users locally for offline access
        await cacheUsers(userModels);

        return Right(userModels.map((model) => model.toEntity()).toList());
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      // No internet - try to fetch from cache
      try {
        final cachedUsers = await localDataSource.getCachedUsers();
        return Right(cachedUsers.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<void> cacheUsers(List<User> users) async {
    final userModels = users.map((user) => UserModel.fromEntity(user)).toList();
    await localDataSource.cacheUsers(userModels);
  }
}
