import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Get users use case
/// Fetches list of users from repository
class GetUsers implements UseCase<List<User>, GetUsersParams> {
  final UserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(GetUsersParams params) async {
    return await repository.getUsers(page: params.page);
  }
}

/// Parameters for get users use case
class GetUsersParams extends Equatable {
  final int page;

  const GetUsersParams({this.page = 1});

  @override
  List<Object?> get props => [page];
}
