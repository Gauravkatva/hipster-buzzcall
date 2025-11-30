/// Base class for all exceptions
class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'Server error occurred']);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error occurred']);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'No internet connection']);

  @override
  String toString() => message;
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException([this.message = 'Authentication failed']);

  @override
  String toString() => message;
}

class VideoCallException implements Exception {
  final String message;

  VideoCallException([this.message = 'Video call error occurred']);

  @override
  String toString() => message;
}

class PermissionException implements Exception {
  final String message;

  PermissionException([this.message = 'Permission denied']);

  @override
  String toString() => message;
}
