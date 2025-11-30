import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
/// Using sealed class pattern for exhaustive pattern matching
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred'])
    : super(message);
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred'])
    : super(message);
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'No internet connection'])
    : super(message);
}

/// Authentication failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure([String message = 'Authentication failed'])
    : super(message);
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

/// Video call failures
class VideoCallFailure extends Failure {
  const VideoCallFailure([String message = 'Video call error occurred'])
    : super(message);
}

/// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure([String message = 'Permission denied'])
    : super(message);
}

/// Unknown/Unexpected failures
class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'An unexpected error occurred'])
    : super(message);
}
