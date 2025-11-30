import 'package:equatable/equatable.dart';

/// Base Failure class for error handling
/// Uses Equatable for value equality
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

/// Server Failure - API errors, network issues
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });
}

/// Cache Failure - Local storage errors
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.statusCode,
  });
}

/// Network Failure - No internet connection
class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'No internet connection',
    super.statusCode,
  }) : super(message: message);
}

/// Authentication Failure - Login/auth errors
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    required super.message,
    super.statusCode,
  });
}

/// Video Call Failure - Agora SDK errors
class VideoCallFailure extends Failure {
  const VideoCallFailure({
    required super.message,
    super.statusCode,
  });
}

/// Permission Failure - Missing permissions
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.statusCode,
  });
}

/// Validation Failure - Input validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.statusCode,
  });
}

/// Unknown/Unexpected Failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    String message = 'An unexpected error occurred',
    super.statusCode,
  }) : super(message: message);
}
