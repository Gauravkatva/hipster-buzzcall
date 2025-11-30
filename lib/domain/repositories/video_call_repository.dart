import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';

/// Video call repository interface
/// Defines the contract for video call operations using Agora SDK
abstract class VideoCallRepository {
  /// Initialize Agora engine
  Future<Either<Failure, void>> initialize(String appId);

  /// Join a video call channel
  Future<Either<Failure, void>> joinChannel({
    required String channelName,
    String? token,
    int uid = 0,
  });

  /// Leave current channel
  Future<Either<Failure, void>> leaveChannel();

  /// Toggle local audio (mute/unmute)
  Future<Either<Failure, bool>> toggleAudio();

  /// Toggle local video (enable/disable camera)
  Future<Either<Failure, bool>> toggleVideo();

  /// Switch camera (front/back)
  Future<Either<Failure, void>> switchCamera();

  /// Start screen sharing
  Future<Either<Failure, void>> startScreenShare();

  /// Stop screen sharing
  Future<Either<Failure, void>> stopScreenShare();

  /// Clean up resources
  Future<void> dispose();
}
