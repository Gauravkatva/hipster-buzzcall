import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/video_call_repository.dart';

/// Start video call use case
/// Initializes and joins a video call channel
class StartVideoCall implements UseCase<void, VideoCallParams> {
  final VideoCallRepository repository;

  StartVideoCall(this.repository);

  @override
  Future<Either<Failure, void>> call(VideoCallParams params) async {
    // Initialize Agora engine first
    final initResult = await repository.initialize(params.appId);

    return initResult.fold((failure) => Left(failure), (_) async {
      // Join channel
      return await repository.joinChannel(
        channelName: params.channelName,
        token: params.token,
        uid: params.uid,
      );
    });
  }
}

/// Parameters for video call use case
class VideoCallParams extends Equatable {
  final String appId;
  final String channelName;
  final String? token;
  final int uid;

  const VideoCallParams({
    required this.appId,
    required this.channelName,
    this.token,
    this.uid = 0,
  });

  @override
  List<Object?> get props => [appId, channelName, token, uid];
}
