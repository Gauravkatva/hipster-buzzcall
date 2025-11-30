import 'package:equatable/equatable.dart';

abstract class VideoCallEvent extends Equatable {
  const VideoCallEvent();

  @override
  List<Object?> get props => [];
}

class JoinCallEvent extends VideoCallEvent {
  final String appId;
  final String channelName;
  final String? token;
  final int uid;

  const JoinCallEvent({
    required this.appId,
    required this.channelName,
    this.token,
    this.uid = 0,
  });

  @override
  List<Object?> get props => [appId, channelName, token, uid];
}

class LeaveCallEvent extends VideoCallEvent {
  const LeaveCallEvent();
}

class ToggleAudioEvent extends VideoCallEvent {
  const ToggleAudioEvent();
}

class ToggleVideoEvent extends VideoCallEvent {
  const ToggleVideoEvent();
}

class SwitchCameraEvent extends VideoCallEvent {
  const SwitchCameraEvent();
}

class StartScreenShareEvent extends VideoCallEvent {
  const StartScreenShareEvent();
}

class StopScreenShareEvent extends VideoCallEvent {
  const StopScreenShareEvent();
}

class UserJoinedEvent extends VideoCallEvent {
  final int uid;

  const UserJoinedEvent({required this.uid});

  @override
  List<Object?> get props => [uid];
}

class UserLeftEvent extends VideoCallEvent {
  final int uid;

  const UserLeftEvent({required this.uid});

  @override
  List<Object?> get props => [uid];
}
