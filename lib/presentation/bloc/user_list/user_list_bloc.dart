import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_users.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsers getUsers;

  UserListBloc({required this.getUsers}) : super(const UserListInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<RefreshUsersEvent>(_onRefreshUsers);
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserListState> emit,
  ) async {
    emit(const UserListLoading());

    final result = await getUsers(GetUsersParams(page: event.page));

    result.fold((failure) {
      // Check if it's a cache failure (offline mode)
      final isFromCache = failure.message.contains('cache');
      emit(UserListError(message: failure.message));
    }, (users) => emit(UserListLoaded(users: users)));
  }

  Future<void> _onRefreshUsers(
    RefreshUsersEvent event,
    Emitter<UserListState> emit,
  ) async {
    final result = await getUsers(const GetUsersParams(page: 1));

    result.fold(
      (failure) => emit(UserListError(message: failure.message)),
      (users) => emit(UserListLoaded(users: users)),
    );
  }
}
