import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object?> get props => [];
}

class UserListInitial extends UserListState {
  const UserListInitial();
}

class UserListLoading extends UserListState {
  const UserListLoading();
}

class UserListLoaded extends UserListState {
  final List<User> users;
  final bool isFromCache;

  const UserListLoaded({required this.users, this.isFromCache = false});

  @override
  List<Object?> get props => [users, isFromCache];
}

class UserListError extends UserListState {
  final String message;

  const UserListError({required this.message});

  @override
  List<Object?> get props => [message];
}
