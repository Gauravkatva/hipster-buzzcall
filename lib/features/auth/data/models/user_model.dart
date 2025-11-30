import '../../domain/entities/user_entity.dart';

/// User Model (Data Layer)
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      email: json['email'] as String? ?? '',
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      if (token != null) 'token': token,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      token: entity.token,
    );
  }
}
