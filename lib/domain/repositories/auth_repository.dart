import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/auth_token.dart';

/// Authentication repository interface
/// Defines the contract for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  /// Returns Either<Failure, AuthToken>
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
  });

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Logout user
  Future<void> logout();
}
