/// Base Exception class
class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => message;
}

/// Server Exception - API errors
class ServerException extends AppException {
  ServerException({
    required super.message,
    super.statusCode,
  });
}

/// Cache Exception - Local storage errors
class CacheException extends AppException {
  CacheException({
    required super.message,
    super.statusCode,
  });
}

/// Network Exception - No internet
class NetworkException extends AppException {
  NetworkException({
    String message = 'No internet connection',
    super.statusCode,
  }) : super(message: message);
}

/// Authentication Exception
class AuthenticationException extends AppException {
  AuthenticationException({
    required super.message,
    super.statusCode,
  });
}

/// Video Call Exception
class VideoCallException extends AppException {
  VideoCallException({
    required super.message,
    super.statusCode,
  });
}

/// Permission Exception
class PermissionException extends AppException {
  PermissionException({
    required super.message,
    super.statusCode,
  });
}
