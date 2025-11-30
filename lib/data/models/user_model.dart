import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

/// User model for data layer
/// Converts between JSON and User entity
@HiveType(typeId: 0)
class UserModel extends User {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String firstName;

  @HiveField(3)
  final String lastName;

  @HiveField(4)
  final String avatar;

  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  }) : super(
         id: id,
         email: email,
         firstName: firstName,
         lastName: lastName,
         avatar: avatar,
       );

  /// From JSON factory
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatar: json['avatar'] as String,
    );
  }

  /// To JSON method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }

  /// Convert from domain entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      avatar: user.avatar,
    );
  }

  /// Convert to domain entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
    );
  }
}
