import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

/// Auth States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial State
class AuthInitial extends AuthState {}

/// Loading State
class AuthLoading extends AuthState {}

/// Authenticated State
class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

/// Unauthenticated State
class AuthUnauthenticated extends AuthState {}

/// Error State
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
