import 'package:equatable/equatable.dart';

/// Auth Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Login Event
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

/// Logout Event
class LogoutEvent extends AuthEvent {}

/// Check Auth Status Event
class CheckAuthStatusEvent extends AuthEvent {}
