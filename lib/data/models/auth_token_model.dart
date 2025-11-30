import '../../domain/entities/auth_token.dart';

/// Auth token model for data layer
class AuthTokenModel extends AuthToken {
  const AuthTokenModel({required String token}) : super(token: token);

  /// From JSON factory
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(token: json['token'] as String);
  }

  /// To JSON method
  Map<String, dynamic> toJson() {
    return {'token': token};
  }

  /// Convert from domain entity
  factory AuthTokenModel.fromEntity(AuthToken authToken) {
    return AuthTokenModel(token: authToken.token);
  }

  /// Convert to domain entity
  AuthToken toEntity() {
    return AuthToken(token: token);
  }
}
