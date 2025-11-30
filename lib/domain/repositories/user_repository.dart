import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user.dart';

/// User repository interface
/// Defines the contract for user data operations
abstract class UserRepository {
  /// Get list of users
  /// First tries to fetch from remote, falls back to cache if offline
  /// Returns Either<Failure, List<User>>
  Future<Either<Failure, List<User>>> getUsers({int page = 1});

  /// Cache users locally
  Future<void> cacheUsers(List<User> users);
}
