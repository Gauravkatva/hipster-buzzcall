import 'package:equatable/equatable.dart';

/// User Entity (Domain Layer)
class UserEntity extends Equatable {
  final int id;
  final String email;
  final String? token;

  const UserEntity({
    required this.id,
    required this.email,
    this.token,
  });

  @override
  List<Object?> get props => [id, email, token];
}
