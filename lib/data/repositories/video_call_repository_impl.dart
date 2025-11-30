import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/video_call_repository.dart';

/// Implementation of VideoCallRepository using Agora SDK
class VideoCallRepositoryImpl implements VideoCallRepository {
  RtcEngine? _engine;
  bool _isAudioMuted = false;
  bool _isVideoDisabled = false;

  @override
  Future<Either<Failure, void>> initialize(String appId) async {
    try {
      // Request permissions
      await [Permission.camera, Permission.microphone].request();

      // Create Agora engine
      _engine = createAgoraRtcEngine();

      await _engine!.initialize(
        RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      // Enable video
      await _engine!.enableVideo();
      await _engine!.enableAudio();

      // Set video configuration
      await _engine!.setVideoEncoderConfiguration(
        const VideoEncoderConfiguration(
          dimensions: VideoDimensions(width: 640, height: 480),
          frameRate: 15,
          bitrate: 0,
        ),
      );

      return const Right(null);
    } on PermissionException catch (e) {
      return Left(PermissionFailure(e.message));
    } catch (e) {
      return Left(VideoCallFailure('Failed to initialize: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> joinChannel({
    required String channelName,
    String? token,
    int uid = 0,
  }) async {
    try {
      if (_engine == null) {
        return const Left(VideoCallFailure('Engine not initialized'));
      }

      final options = ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
      );

      await _engine!.joinChannel(
        token: token ?? '',
        channelId: channelName,
        uid: uid,
        options: options,
      );

      return const Right(null);
    } catch (e) {
      return Left(VideoCallFailure('Failed to join channel: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> leaveChannel() async {
    try {
      if (_engine == null) {
        return const Left(VideoCallFailure('Engine not initialized'));
      }

      await _engine!.leaveChannel();
      return const Right(null);
    } catch (e) {
      return Left(VideoCallFailure('Failed to leave channel: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleAudio() async {
    try {
      if (_engine == null) {
        return const Left(VideoCallFailure('Engine not initialized'));
      }

      _isAudioMuted = !_isAudioMuted;
      await _engine!.muteLocalAudioStream(_isAudioMuted);
      return Right(_isAudioMuted);
    } catch (e) {
      return Left(VideoCallFailure('Failed to toggle audio: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleVideo() async {
    try {
      if (_engine == null) {
        return const Left(VideoCallFailure('Engine not initialized'));
      }

      _isVideoDisabled = !_isVideoDisabled;
      await _engine!.muteLocalVideoStream(_isVideoDisabled);
      return Right(_isVideoDisabled);
    } catch (e) {
      return Left(VideoCallFailure('Failed to toggle video: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> switchCamera() async {
    try {
      if (_engine == null) {
        return const Left(VideoCallFailure('Engine not initialized'));
      }

      await _engine!.switchCamera();
      return const Right(null);
    } catch (e) {
      return Left(VideoCallFailure('Failed to switch camera: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> startScreenShare() async {
    try {
      if (_engine == null) {
        return const Left(VideoCallFailure('Engine not initialized'));
      }

      // Start screen sharing
      await _engine!.startScreenCapture(const ScreenCaptureParameters2());
      return const Right(null);
    } catch (e) {
      return Left(
        VideoCallFailure('Failed to start screen share: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> stopScreenShare() async {
    try {
      if (_engine == null) {
        return const Left(VideoCallFailure('Engine not initialized'));
      }

      await _engine!.stopScreenCapture();
      return const Right(null);
    } catch (e) {
      return Left(
        VideoCallFailure('Failed to stop screen share: ${e.toString()}'),
      );
    }
  }

  @override
  Future<void> dispose() async {
    await _engine?.leaveChannel();
    await _engine?.release();
    _engine = null;
  }
}
