import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsersEvent extends UserListEvent {
  final int page;

  const FetchUsersEvent({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class RefreshUsersEvent extends UserListEvent {
  const RefreshUsersEvent();
}
