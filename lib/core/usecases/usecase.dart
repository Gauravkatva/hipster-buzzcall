import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../errors/failures.dart';

/// Base class for all use cases
/// Returns Either<Failure, Success>
/// Params can be NoParams if no parameters are needed
abstract class UseCase<E, Params> {
  Future<Either<Failure, E>> call(Params params);
}

/// Used for use cases that don't require parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
