import 'package:equatable/equatable.dart';

/// Base class for all auth events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to login user
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Event to logout user
class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

/// Event to check if user is logged in
class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}
